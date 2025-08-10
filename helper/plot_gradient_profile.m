addpath('.\hoehenprofil');

[distance_lookup, altitude_lookup] = extract_height_profile();
smoothedData = smooth_data(distance_lookup, altitude_lookup, 0.01);

% Calculate gradients and mid-point distances
[distance2_lookup, altitude2_lookup] = calculate_gradient(distance_lookup, smoothedData);

% Plot the gradient profile
figure;
plot(distance2_lookup, altitude2_lookup, 'r-', 'LineWidth', 1.5);
xlabel('Distance (km)');
ylabel('Gradient [1] (%/100)');
title('Gradient Profile over Distance');
grid on;
legend('Gradient');
