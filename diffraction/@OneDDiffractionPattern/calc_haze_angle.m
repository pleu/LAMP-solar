function [hazeAngle] = calc_haze_angle(theta, normalizedIntensity, angleCutoff, howCalcHaze)
%CALCULATE_HAZE Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  angleCutoff = 2.5;
  howCalcHaze = 'trapz';
elseif nargin == 2
  howCalcHaze = 'trapz';
end

indexPos = find(theta >= angleCutoff);
indexNeg = find(theta <= -angleCutoff);

if strcmp(howCalcHaze, 'trapz')
  hazeAnglePositive = trapz(theta(indexPos), normalizedIntensity(indexPos));
  hazeAngleNegative = trapz(theta(indexNeg), normalizedIntensity(indexNeg));
  hazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
    trapz(theta, normalizedIntensity);
%   obj.HazeAngle = hazeAnglePositive/...
%     trapz(theta, normalizedIntensity);
elseif strcmp(howCalcHaze, 'sum')
  % only use this if delta functions
  hazeAnglePositive = sum(normalizedIntensity(indexPos));
  hazeAngleNegative = sum(normalizedIntensity(indexNeg));
  %   obj.HazeAngle = hazeAnglePositive/...
  %     sum(normalizedIntensity);
  hazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
    sum(normalizedIntensity);
elseif strcmp(howCalcHaze, 'trapzSpherical')
  hazeAnglePositive = trapz(theta(indexPos).*sin(deg2rad(theta(indexPos))), normalizedIntensity(indexPos).*sin(deg2rad(theta(indexPos))));
  %hazeAngleNegative = sum(normalizedIntensity(indexNeg));
  hazeAngle = hazeAnglePositive/...
    trapz(theta.*sin(deg2rad(theta)), normalizedIntensity.*sin(deg2rad(theta)));
elseif strcmp(howCalcHaze, 'sumSpherical')
  
  
  
  hazeAnglePositive = sum(normalizedIntensity(indexPos).*sin(deg2rad(theta(indexPos))));
  hazeAngle = hazeAnglePositive/...
    sum(normalizedIntensity.*sin(deg2rad(theta(indexPos))));
end


end

