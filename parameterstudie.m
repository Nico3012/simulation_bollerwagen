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

%% Helper: letzten SOC-Wert holen (Dataset heißt 'sigsOut')
getLastSOC = @() sim('mdl').sigsOut.getElement('SOC [%]').Values.Data(end);

%% Alle Init-Skripte erfassen und RESULTS vorab dimensionieren
files = dir(fullfile('.\parameterstudie','init_*.m'));
n = numel(files);
results = cell(n+2, 3);                 % Header + Original + n Varianten
results(1,:) = {'Parameter','SOC Result [%]','Delta [%]'};

%% 1) Original init
run('init.m');
origVal = getLastSOC();
origName = regexprep('init.m', '^init_|\.m$', '');
results(2,:) = {origName, origVal, 0};

%% 2) Parameterstudie-Init-Skripte
for k = 1:n
    run(fullfile(files(k).folder, files(k).name));
    val = getLastSOC();
    if origVal ~= 0
        pct = round(100 * (val - origVal) / origVal, 2);
    else
        pct = NaN;
    end
    displayName = regexprep(files(k).name, '^init_|\.m$', '');
    results(k+2,:) = {displayName, val, pct};
end

%% Nach Excel schreiben
writecell(results, 'parameterstudie.xlsx');
