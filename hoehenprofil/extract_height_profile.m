
function [distance_lookup, altitude_lookup] = extract_height_profile()
% extract_height_profile Initializes lookup table data for Simulink
%   [distance_lookup, altitude_lookup] = extract_height_profile()
%   Reads GPS data, calculates cumulative distance, and returns lookup arrays.


% --- Configuration ---

csv_filename = 'hoehenprofil/daten/hin_und_zurueck.txt'; % The name of your data file


% --- Data Loading ---
if ~isfile(csv_filename)
    error('Data file not found: %s', csv_filename);
end
data_table = readtable(csv_filename, 'VariableNamingRule', 'preserve');


% Extract the necessary columns
lat = data_table.latitude;
lon = data_table.longitude;
alt = data_table.("altitude (m)"); % use preserved name


% --- Distance Calculation ---
num_points = length(lat);
distances = zeros(num_points, 1);
earth_radius = 6371e3; % Earth's radius in meters


for i = 2:num_points
    lat1_rad = deg2rad(lat(i-1));
    lon1_rad = deg2rad(lon(i-1));
    lat2_rad = deg2rad(lat(i));
    lon2_rad = deg2rad(lon(i));

    dLat = lat2_rad - lat1_rad;
    dLon = lon2_rad - lon1_rad;
    a = sin(dLat/2)^2 + cos(lat1_rad) * cos(lat2_rad) * sin(dLon/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    segment_distance = earth_radius * c;

    distances(i) = distances(i-1) + segment_distance;
end


% Convert distances to kilometers
distances_km = distances / 1000;


% --- Create Output Variables for Lookup Table ---
distance_lookup = distances_km(:); % Breakpoints (x-axis)
altitude_lookup = alt(:);          % Table data (y-axis)


% Ensure the breakpoint data is strictly monotonic increasing, as required by lookup tables.
[distance_lookup, unique_indices, ~] = unique(distance_lookup, 'stable');
altitude_lookup = altitude_lookup(unique_indices);

end
