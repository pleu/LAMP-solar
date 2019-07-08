function [obj] = calc_haze_mode(obj, howCalcHaze)
%CALCULATE_HAZE_MODE Summary of this function goes here
%   calculates haze by identifying first zero in normalized intensity
% and using that as the cutoff angle
if nargin == 1
  howCalcHaze = 'trapz';
end

diffForAlmostEqual = 1e-3;


modeIndex = is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual);
modeIndexMatrix = zeros(size(obj.Ky, 1), size(obj.Ky, 2));

for ind = 1:size(obj.Ky, 2)
  indexX = find(modeIndex(:, ind)==1,1, 'first');
  modeIndexMatrix(indexX:size(obj.Ky, 1), ind) = ones(length(indexX:size(obj.Ky, 1)), 1);
end

thetaVec = obj.Theta(2, :); % azimuth
phiVec = obj.Phi(:, 1); % zenith

if strcmp(howCalcHaze, 'trapz')
  if size(thetaVec) == 1
    %indexPos = modeIndexMatrix >= angleCutoff;
    hazeAnglePositive = trapz(phiVec, modeIndexMatrix.*obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)));
    %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
    obj.HazeMode = hazeAnglePositive/...
      trapz(phiVec, obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)));
  else
    %indexPos = modeIndexMatrix >= angleCutoff;
    hazeAnglePositive = trapz(thetaVec, trapz(phiVec, modeIndexMatrix.*obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)), 1), 2);
    %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
    obj.HazeMode = hazeAnglePositive/...
      trapz(thetaVec, trapz(phiVec, obj.NormalizedIntensity.*sin(deg2rad(obj.Phi)), 1));
  end
elseif strcmp(howCalcHaze, 'sum')
  % use this if bunch of delta functions
  % this ignores spherical coordinates; this might be okay
  hazeAnglePositive = sum(sum(modeIndexMatrix.*obj.NormalizedIntensity, 1), 2);
  indNotCenter = obj.Phi ~= 0;
  indCenter = obj.Phi == 0;
  [normCenter] = obj.NormalizedIntensity(indCenter);
  obj.HazeMode = hazeAnglePositive/...
    (sum(sum(obj.NormalizedIntensity(indNotCenter), 1), 2)+...
    normCenter(1));
end

end





