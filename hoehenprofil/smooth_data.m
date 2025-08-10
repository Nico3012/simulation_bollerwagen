function smoothedData = smooth_data(distance_lookup, altitude_lookup, smoothing_factor)
%smooth_data Smooths altitude data using a Gaussian filter.
%   [smoothedData, winSize] = smooth_data(distance_lookup, altitude_lookup, smoothing_factor)
%   Returns the smoothed altitude data and window size used.

    if nargin < 3
        smoothing_factor = 0.01; % Default value
    end

    smoothedData = smoothdata(altitude_lookup, ...
        "gaussian", "SmoothingFactor", smoothing_factor, ...
        "SamplePoints", distance_lookup);
end
