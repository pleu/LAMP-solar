function [obj] = calc_haze_angle(obj, angleCutoff, howCalcHaze)
%CALCULATE_HAZE Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  angleCutoff = 2.5;
  howCalcHaze = 'trapz';
elseif nargin == 2
  howCalcHaze = 'trapz';
end

indexPos = find(obj.Theta >= angleCutoff);

if strcmp(howCalcHaze, 'trapz')
  hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos));
  obj.HazeAngle = hazeAnglePositive/...
    trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity);
elseif strcmp(howCalcHaze, 'sum')
  % only use this if delta functions
  hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos));
  obj.HazeAngle = hazeAnglePositive/...
    sum(obj.NormalizedIntensity);
  
end



end

