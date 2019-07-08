function [obj] = calc_haze_angle(obj, angleCutoff, howCalcHaze)
%CALC_HAZE_ANGLE Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  angleCutoff = deg2rad(2.5);
  howCalcHaze = 'trapz';
elseif nargin == 2
  howCalcHaze = 'trapz';
end

indexPos = obj.Phi >= angleCutoff;

thetaVec = obj.Theta(2, :);
phiVec = obj.Phi(:, 1);
if strcmp(howCalcHaze, 'trapz')
  if size(thetaVec) == 1
    hazeAnglePositive = trapz(phiVec, indexPos.*obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)));
    %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
    obj.HazeAngle = hazeAnglePositive/...
      trapz(phiVec, obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)));
  else
    hazeAnglePositive = trapz(thetaVec, trapz(phiVec, indexPos.*obj.NormalizedIntensity.*sin(obj.Phi), 1));
    %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
    obj.HazeAngle = hazeAnglePositive/...
      trapz(thetaVec, trapz(phiVec, obj.NormalizedIntensity.*sin(obj.Phi), 1));
  end
elseif strcmp(howCalcHaze, 'sum')
  % use this if bunch of delta functions
  % this ignores spherical coordinates; this might be okay
  hazeAnglePositive = sum(sum(indexPos.*obj.NormalizedIntensity, 1), 2);
  indNotCenter = obj.Phi ~= 0;
  indCenter = obj.Phi == 0;
  [normCenter] = obj.NormalizedIntensity(indCenter);
  obj.HazeAngle = hazeAnglePositive/...
    (sum(sum(obj.NormalizedIntensity(indNotCenter), 1), 2)+...
    normCenter(1));
  numModes = obj.NormalizedIntensity~=0;
  numModes = sum(numModes, 2);
  numModes(1) = 1;  % for phi = 0;
  obj.NumModes = sum(numModes);
end


end

