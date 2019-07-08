function [obj] = calc_haze_mode(obj, howCalcHaze)
%CALCULATE_HAZE_MODE Summary of this function goes here
%   calculates haze by identifying first zero in normalized intensity
% and using that as the cutoff angle
if nargin == 1
  howCalcHaze = 'trapz';
end

diffForAlmostEqual = 1e-3;

modeIndex = is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual);
modeIndexMatrix = zeros(length(obj.ThetaY), length(obj.ThetaX));
for ind = 1:length(obj.ThetaY)
  indexX = find(obj.ThetaX > 0 & modeIndex(ind,:)==1,1, 'first');
  modeIndexMatrix(ind,indexX:length(obj.ThetaX)) = ones(1, length(indexX:length(obj.ThetaX)));
  indexX = find(obj.ThetaX < 0 & modeIndex(ind,:)==1,1, 'last');
  modeIndexMatrix(ind,1:indexX) = ones(1, length(1:indexX));
end

for ind = 1:length(obj.ThetaX)
  indexY = find(obj.ThetaY' > 0 & modeIndex(:,ind)==1,1, 'first');
  modeIndexMatrix(indexY:length(obj.ThetaY),ind) = ones(length(indexY:length(obj.ThetaY)), 1);
  indexY = find(obj.ThetaY' < 0 & modeIndex(:,ind)==1,1, 'last');
  modeIndexMatrix(1:indexY, ind) = ones(1, length(1:indexY));
end
% figure(1);
% clf;
% contourf(obj.ThetaX, obj.ThetaY, modeIndexMatrix);



if isempty(modeIndex)
  obj.HazeMode = 0;
else
  if strcmp(howCalcHaze, 'trapz')
    hazeAnglePositive = trapz(obj.ThetaY, trapz(obj.ThetaX, obj.NormalizedIntensity.*modeIndexMatrix, 2));
    hazeAngleTotal = trapz(obj.ThetaY, trapz(obj.ThetaX, obj.NormalizedIntensity, 2));
    obj.HazeMode = hazeAnglePositive/hazeAngleTotal;
  elseif strcmp(howCalcHaze, 'sum')
    hazeAnglePositive = sum(sum(obj.ThetaY, obj.NormalizedIntensity.*modeIndexMatrix, 2));
    obj.HazeMode = hazeAnglePositive/sum(obj.NormalizedIntensity);
  elseif strcmp(howCalcHaze, 'trapzSpherical')
    %hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
    %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
%     obj.HazeMode = hazeAnglePositive/...
%       trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity.*sin(deg2rad(obj.Theta)));
  elseif strcmp(howCalcHaze, 'sumSpherical')
%     hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
%     obj.HazeAngle = hazeAnglePositive/...
%       sum(obj.NormalizedIntensity.*sin(deg2rad(obj.Theta(indexPos))));
  end
end

end





