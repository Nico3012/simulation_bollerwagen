function [distance2_lookup, altitude2_lookup] = calculate_gradient(distance_lookup, smoothedData)
%CALCULATE_GRADIENT Calculates the gradient between consecutive points
%   [distance2_lookup, altitude2_lookup] = calculate_gradient(distance_lookup, smoothedData)
%   Returns mid-point distances and gradients.

    distance2_lookup = zeros(1, length(distance_lookup)-1);
    altitude2_lookup = zeros(1, length(distance_lookup)-1);
    minDistance = inf;

    for i = 2:length(distance_lookup)
        ds = distance_lookup(i) - distance_lookup(i-1); % km
        dh = smoothedData(i) - smoothedData(i-1); % m
        altitude2_lookup(i-1) = dh/ds/1000;
        distance2_lookup(i-1) = (distance_lookup(i-1) + distance_lookup(i)) / 2;
        if minDistance > ds
            minDistance = ds;
        end
    end
end
