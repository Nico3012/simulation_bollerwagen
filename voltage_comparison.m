clear; clc;

%% Pfade
addpath('.\hoehenprofil');

%% Vorbereiten: Höhenprofil -> glätten -> Gradient (vom Modell benötigt)
[distance_lookup, altitude_lookup] = extract_height_profile();
smoothedData = smooth_data(distance_lookup, altitude_lookup, 0.01);
[gradient_distance_lookup, gradient_lookup] = calculate_gradient(distance_lookup, smoothedData);

%% Modell öffnen
open('mdl.slx');

% Single run (no iteration needed)
run('init.m');

% Genau einmal simulieren und Signale entnehmen
simOut = sim('mdl');
voltage_ts = simOut.sigsOut.getElement('U [V]').Values;  % timeseries (Time, Data)
km_ts      = simOut.sigsOut.getElement('s [km]').Values;  % timeseries (Time, Data)

% Plot: Voltage über Strecke (Kilometer)
figure('Name','Voltage over distance'); hold on; grid on;
plot(km_ts.Data, voltage_ts.Data, 'DisplayName', 'Model');

% Measured data points (real life)
measured_km = [0, 2.7, 4.8, 8.2, 10.6];
measured_V  = [13.5, 13.35, 12.93, 12.74, 12.7];
plot(measured_km, measured_V, 'o', 'MarkerSize', 7, 'MarkerFaceColor', 'r', 'DisplayName', 'Measured');

xlabel('Distance s [km]', 'Interpreter','none');
ylabel('Voltage U [V]', 'Interpreter','none');
title('Voltage profiles over distance', 'Interpreter','none');
lgd2 = legend('show','Location','best');
set(lgd2, 'Interpreter','none');
