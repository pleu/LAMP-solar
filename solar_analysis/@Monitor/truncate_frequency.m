function obj = truncate_frequency(obj, minFrequency, maxFrequency)
%TRUNCATE_ENERGY Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(obj, 2)
  [obj(i).Frequency, obj(i).Data] = ...
    truncate(obj(i).Frequency', minFrequency, maxFrequency, obj(i).Data');
end


