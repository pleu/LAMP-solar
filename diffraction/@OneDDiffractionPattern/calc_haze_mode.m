function [obj] = calc_haze_mode(obj, howCalcHaze)
%CALCULATE_HAZE_MODE Summary of this function goes here
%   calculates haze by identifying first zero in normalized intensity
% and using that as the cutoff angle
if nargin == 1
  howCalcHaze = 'trapz';
end

% may want to add additional thing that checks for change in slope
diffForAlmostEqual = 1e-3;

modeIndexPos = find(obj.Theta > 0 & is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual), 1, 'first');


modeIndexNeg = find(obj.Theta < 0 & is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual), 1, 'last');
  
if isempty(modeIndexPos) && isempty(modeIndexNeg)
  obj.HazeMode = 0;
else
  indexPos = modeIndexPos:length(obj.Theta);
  indexNeg = 1:modeIndexNeg;
  if strcmp(howCalcHaze, 'trapz')
    if length(indexPos) == 1
      hazeAnglePositive = 0;
    else
      hazeAnglePositive = trapz(obj.Theta(indexPos), obj.NormalizedIntensity(indexPos));
    end
    if length(indexNeg) == 1
      hazeAngleNegative = 0;
    else
      hazeAngleNegative = trapz(obj.Theta(indexNeg), obj.NormalizedIntensity(indexNeg));
    end
    obj.HazeMode = (hazeAnglePositive+hazeAngleNegative)/...
      trapz(obj.Theta, obj.NormalizedIntensity);
  elseif strcmp(howCalcHaze, 'sum')
    hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos));
    hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
    obj.HazeMode = (hazeAnglePositive+hazeAngleNegative)/sum(obj.NormalizedIntensity);
  elseif strcmp(howCalcHaze, 'trapzSpherical')
%     hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
%     %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
%     obj.HazeMode = hazeAnglePositive/...
%       trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity.*sin(deg2rad(obj.Theta)));
  elseif strcmp(howCalcHaze, 'sumSpherical')
%     hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
%     obj.HazeAngle = hazeAnglePositive/...
%       sum(obj.NormalizedIntensity.*sin(deg2rad(obj.Theta(indexPos))));
  end
end

end



