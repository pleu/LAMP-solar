function [obj] = calc_haze_mode(obj, howCalcHaze)
%CALCULATE_HAZE_MODE Summary of this function goes here
%   calculates haze by identifying first zero in normalized intensity
% and using that as the cutoff angle

if nargin == 1
  howCalcHaze = 'trapz';
end
diffForAlmostEqual = 1e-12;

modeIndex = find(is_almost_equal(obj.NormalizedIntensity,0, diffForAlmostEqual), 1);
if isempty(modeIndex)
  obj.HazeMode = 0;
else
  indexPos = find(obj.Theta > obj.Theta(modeIndex));
  if strcmp(howCalcHaze, 'trapz')
    hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos));
    obj.HazeMode = hazeAnglePositive/...
      trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity);
  elseif strcmp(howCalcHaze, 'sum')
    hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
    obj.HazeMode = hazeAnglePositive/sum(obj.NormalizedIntensity);
  end
end


end



