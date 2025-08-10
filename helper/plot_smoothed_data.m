addpath('.\hoehenprofil');

% Smooth input data using the new function
[distance_lookup, altitude_lookup] = extract_height_profile();
smoothedData = smooth_data(distance_lookup, altitude_lookup, 0.01);

% Display results
figure
plot(distance_lookup, altitude_lookup, "SeriesIndex", 6, "DisplayName", "Input data")
hold on
plot(distance_lookup, smoothedData, "SeriesIndex", 1, "LineWidth", 1.5, "DisplayName", "Smoothed data")
hold off
legend
xlabel("distance_lookup", "Interpreter", "none")
