clc; clear; close all;

%% ================= CONFIGURACIÓN =================
puerto   = "COM6";
baudrate = 115200;

duracion = 60;          
ventana  = 10;          

%% ================= CONEXIÓN SERIAL =================
s = serialport(puerto, baudrate);
configureTerminator(s, "LF");
flush(s);

%% ================= VARIABLES =================
tiempo = [];
senal  = [];

SPI_tiempo = [];
SPI_valores = [];

buffer = [];
buffer_t = [];

ultimos_picos_t = [];
PPGA_hist = [];

t0 = tic;

figure;
h = animatedline; hold on;
h_picos  = animatedline('LineStyle','none','Marker','o'); % picos
h_valles = animatedline('LineStyle','none','Marker','o'); % valles

xlabel("Tiempo (s)");
ylabel("Señal IR");
title("Señal PPG - MAX30102");
grid on;

%% ================= ADQUISICIÓN =================
while toc(t0) < duracion
    
    dato = readline(s);
    valor = str2double(dato);
    
    if ~isnan(valor)
        t = toc(t0);
        valor = -valor;

        tiempo(end+1) = t;
        senal(end+1)  = valor;
        
        addpoints(h, t, valor);

        %% ====== VENTANA DESLIZANTE ======
        xlim([max(0, t-ventana) t]);

        %% ====== AUTOESCALA SEGURA ======
        if length(senal) > 20
            idx = tiempo > (t - ventana);
            segmento = senal(idx);

            segmento = segmento(~isnan(segmento) & ~isinf(segmento));

            if ~isempty(segmento)
                y_min = min(segmento);
                y_max = max(segmento);

                if isfinite(y_min) && isfinite(y_max)
                    if y_max == y_min
                        delta = max(abs(y_min)*0.05, 1);
                        ylim([y_min - delta, y_max + delta]);
                    else
                        margen = 0.1 * (y_max - y_min);
                        ylim([y_min - margen, y_max + margen]);
                    end
                end
            end
        end

        %% ================= BUFFER =================
        buffer(end+1) = valor;
        buffer_t(end+1) = t;

        %% ================= DETECCIÓN =================
        if length(buffer) > 80
            
            ventana_signal = buffer(end-80:end);
            ventana_time   = buffer_t(end-80:end);

            dt = mean(diff(ventana_time));
            minDist = round(0.6 / dt);

            % evitar error
            minDist = max(1, min(minDist, floor(length(ventana_signal)/2)));

            prom = 0.3 * std(ventana_signal);

            [pks, locs] = findpeaks(ventana_signal,...
                'MinPeakDistance', minDist,...
                'MinPeakProminence', prom);

            if ~isempty(pks)

                v_pico = pks(end);
                idx_pico = locs(end);
                t_pico = ventana_time(idx_pico);

                % evitar doble detección
                if isempty(ultimos_picos_t) || abs(t_pico - ultimos_picos_t(end)) > 0.5

                    addpoints(h_picos, t_pico, v_pico);

                    %% ===== HBI =====
                    if ~isempty(ultimos_picos_t)
                        HBI = t_pico - ultimos_picos_t(end);
                    else
                        HBI = NaN;
                    end
                    ultimos_picos_t(end+1) = t_pico;

                    %% ===== VALLE =====
                    idx_ini = max(1, idx_pico-15);
                    segmento_v = ventana_signal(idx_ini:idx_pico);
                    [v_valle, idx_valle] = min(segmento_v);

                    t_valle = ventana_time(idx_ini + idx_valle -1);
                    addpoints(h_valles, t_valle, v_valle);

                    %% ===== PPGA =====
                    PPGA = v_pico - v_valle;

                    %% ===== NORMALIZACIÓN =====
                    PPGA_hist(end+1) = PPGA;
                    if length(PPGA_hist) > 10
                        PPGA_hist(1) = [];
                    end

                    PPGA_ref = mean(PPGA_hist);
                    PPGA_norm = PPGA / (PPGA_ref + eps);

                    if length(ultimos_picos_t) > 2
                        HBI_ref = mean(diff(ultimos_picos_t));
                    else
                        HBI_ref = HBI;
                    end

                    HBI_norm = HBI / (HBI_ref + eps);

                    PPGA_norm = min(PPGA_norm,2);
                    HBI_norm  = min(HBI_norm,2);

                    %% ===== SPI =====
                    if ~isnan(HBI)

                        SPI = 100 - (33*HBI_norm + 67*PPGA_norm);
                        SPI = max(0, min(100, SPI));

                        SPI_tiempo(end+1) = t_pico;
                        SPI_valores(end+1) = SPI;

                        %% ===== HR =====
                        HR = 60 / HBI;

                        %% ===== CLASIFICACIÓN =====
                        if SPI < 20
                            estado = "Analgesia alta";
                        elseif SPI <= 50
                            estado = "Óptimo";
                        else
                            estado = "Dolor";
                        end

                        fprintf("t=%.1f s | HR=%.1f bpm | SPI=%.2f --> %s\n", ...
                            t_pico, HR, SPI, estado);
                    end
                end
            end
        end
        
        drawnow limitrate;
    end
end

%% ================= CIERRE =================
clear s;

%% ================= GRAFICA FINAL PPG =================
figure;
plot(tiempo, senal);
xlabel("Tiempo (s)");
ylabel("Señal IR");
title("Señal PPG adquirida");
grid on;

%% ================= GRAFICA FINAL SPI =================
figure;
plot(SPI_tiempo, SPI_valores,'LineWidth',2);
xlabel("Tiempo (s)");
ylabel("SPI");
title("SPI vs tiempo");
ylim([0 100]);
grid on;