addpath('.\hoehenprofil');

[distance_lookup, altitude_lookup] = extract_height_profile();

figure;
plot(distance_lookup, altitude_lookup, 'b-', 'LineWidth', 1.5);
xlabel('Distance [km]');
ylabel('Altitude [m]');
title('Altitude Profile');
grid on;
