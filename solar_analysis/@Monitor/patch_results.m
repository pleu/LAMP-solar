function [obj] = patch_results(obj, obj2)
%PATCH_RESULTS Summary of this function goes here
%   Detailed explanation goes here

keepRange = [min(obj.Frequency) max(obj.Frequency)];
if max(max(obj2.Frequency)) > keepRange(1)
  keepRange(1) = max(max(obj2.Frequency));
end
if min(min(obj2.Frequency)) > keepRange(2)
  keepRange(2) = min(min(obj2.Frequency));
end

obj.truncate_frequency(keepRange(1), keepRange(2));
frequency = [obj2.Frequency; obj.Frequency];
data = [obj2.Data; obj.Data];

obj = Monitor(obj.Type, frequency, data);

end

