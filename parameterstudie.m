clear; clc;

%% Pfade
addpath('.\hoehenprofil');
addpath('.\parameterstudie');

%% Vorbereiten: Höhenprofil -> glätten -> Gradient (vom Modell benötigt)
[distance_lookup, altitude_lookup] = extract_height_profile();
smoothedData = smooth_data(distance_lookup, altitude_lookup, 0.01);
[gradient_distance_lookup, gradient_lookup] = calculate_gradient(distance_lookup, smoothedData);

%% Modell öffnen
open('mdl.slx');

%% Alle Init-Skripte erfassen und RESULTS vorab dimensionieren
files = dir(fullfile('.\parameterstudie','init_*.m'));
n = numel(files);
results = cell(n+2, 3);                 % Header + Original + n Varianten
results(1,:) = {'Parameter','SOC Result [%]','Delta [%]'};

% Speicher für Signale
SOCsignals = cell(n+1,1);   % timeseries for SOC [%]
KMsignals  = cell(n+1,1);   % timeseries for s [km] (same length as SOC)
names      = cell(n+1,1);

%% 1) Original init
run('init.m');

% -> Genau einmal simulieren und beide Signale entnehmen
simOut = sim('mdl');
soc_ts = simOut.sigsOut.getElement('SOC [%]').Values;  % timeseries (Time, Data)
km_ts  = simOut.sigsOut.getElement('s [km]').Values;   % timeseries (Time, Data)

origVal = soc_ts.Data(end);
origName = regexprep('init.m', '^init_|\.m$', '');
results(2,:) = {origName, origVal, 0};

SOCsignals{1} = soc_ts;
KMsignals{1}  = km_ts;
names{1}      = origName;

%% 2) Parameterstudie-Init-Skripte
for k = 1:n
    run(fullfile(files(k).folder, files(k).name));

    % -> Einmal simulieren, beide Signale holen
    simOut = sim('mdl');
    soc_ts = simOut.sigsOut.getElement('SOC [%]').Values;
    km_ts  = simOut.sigsOut.getElement('s [km]').Values;

    val = soc_ts.Data(end);
    if origVal ~= 0
        pct = round(100 * (val - origVal) / origVal, 2);
    else
        pct = NaN;
    end
    displayName = regexprep(files(k).name, '^init_|\.m$', '');

    results(k+2,:) = {displayName, val, pct};
    SOCsignals{k+1} = soc_ts;
    KMsignals{k+1}  = km_ts;
    names{k+1}      = displayName;
end

%% Nach Excel schreiben
writecell(results, 'parameterstudie.xlsx');

%% Plot 1: SOC über Zeit
figure('Name','SOC over time'); hold on; grid on;
for i = 1:numel(SOCsignals)
    plot(SOCsignals{i}.Time, SOCsignals{i}.Data, 'DisplayName', names{i});
end
xlabel('Simulation time [s]');
ylabel('SOC [%]');
title('SOC profiles over time');
legend('show','Location','best');

%% Plot 2: SOC über Strecke (Kilometer)
% Hinweis: Für diesen Plot verwenden wir KMsignals{i}.Data als x-Achse,
% und SOCsignals{i}.Data als y-Achse. Beide haben dieselbe Länge je Lauf.
figure('Name','SOC over distance'); hold on; grid on;
for i = 1:numel(SOCsignals)
    plot(KMsignals{i}.Data, SOCsignals{i}.Data, 'DisplayName', names{i});
end
xlabel('Distance s [km]');
ylabel('SOC [%]');
title('SOC profiles over distance');
legend('show','Location','best');
