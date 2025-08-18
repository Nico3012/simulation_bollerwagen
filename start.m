clear; clc;

%% add 'hoehenprofil' folder to path
addpath('.\hoehenprofil');

[distance_lookup, altitude_lookup] = extract_height_profile();
smoothedData = smooth_data(distance_lookup, altitude_lookup, 0.01);
[gradient_distance_lookup, gradient_lookup] = calculate_gradient(distance_lookup, smoothedData);

init;

open('mdl.slx');
