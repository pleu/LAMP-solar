function [obj] = average_over_azimuth(obj, howAverage)
%AVERAGE_OVER_ALL_PHI Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  howAverage = obj.HowCalcHaze;
end

diffForAlmostEqual = 1e-3;

modeIndex = is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual);
modeIndexMatrix = zeros(size(obj.Ky, 1), size(obj.Ky, 2));

for ind = 1:size(obj.Ky, 2)
  indexX = find(modeIndex(:, ind)==1,1, 'first');
  modeIndexMatrix(indexX:size(obj.Ky, 1), ind) = ones(length(indexX:size(obj.Ky, 1)), 1);
end

thetaVec = obj.Theta(2, :);
%phiVec = obj.Phi(:, 1);
%numThetas = length(thetaVec);
%intensityTheta = zeros(numThetas, 1);

intensityPhi = mean(obj.NormalizedIntensity, 2);

% if strcmp(howAverage, 'trapz')
%   % don't think this is right
%   %intensityPhi = trapz(thetaVec, obj.NormalizedIntensity, 2)/length(thetaVec);
%   intensityPhi = mean(thetaVec, obj.NormalizedIntensity, 2)
% elseif strcmp(howAverage, 'sum')
%   % use this if bunch of delta functions
%   % this ignores spherical coordinates; this might be okay
%   intensityPhi = sum(obj.NormalizedIntensity, 2)/length(thetaVec);
% end
normalizedIntensityOld = obj.NormalizedIntensity;
obj.NormalizedIntensity = repmat(intensityPhi, 1, length(thetaVec));

% check
% ans1 = trapz(thetaVec, normalizedIntensityOld, 2)
% ans2 = trapz(thetaVec, obj.NormalizedIntensity, 2)



end

