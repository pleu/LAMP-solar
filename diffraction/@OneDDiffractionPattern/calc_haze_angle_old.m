function [obj] = calc_haze_angle_old(obj, angleCutoff, howCalcHaze)
%CALCULATE_HAZE Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  angleCutoff = 2.5;
  howCalcHaze = 'trapz';
elseif nargin == 2
  howCalcHaze = 'trapz';
end

indexPos = find(obj.Theta >= angleCutoff);
indexNeg = find(obj.Theta <= -angleCutoff);

if strcmp(howCalcHaze, 'trapz')
  hazeAnglePositive = trapz(obj.Theta(indexPos), obj.NormalizedIntensity(indexPos));
  hazeAngleNegative = trapz(obj.Theta(indexNeg), obj.NormalizedIntensity(indexNeg));
  obj.HazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
    trapz(obj.Theta, obj.NormalizedIntensity);
%   obj.HazeAngle = hazeAnglePositive/...
%     trapz(obj.Theta, obj.NormalizedIntensity);
elseif strcmp(howCalcHaze, 'sum')
  % only use this if delta functions
  hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos));
  hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
  %   obj.HazeAngle = hazeAnglePositive/...
  %     sum(obj.NormalizedIntensity);
  obj.HazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
    sum(obj.NormalizedIntensity);
elseif strcmp(howCalcHaze, 'trapzSpherical')
  hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
  %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
  obj.HazeAngle = hazeAnglePositive/...
    trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity.*sin(deg2rad(obj.Theta)));
elseif strcmp(howCalcHaze, 'sumSpherical')
  
  
  
  hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
  obj.HazeAngle = hazeAnglePositive/...
    sum(obj.NormalizedIntensity.*sin(deg2rad(obj.Theta(indexPos))));
end


end

