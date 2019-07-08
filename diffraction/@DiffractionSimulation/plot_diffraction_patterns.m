function [] = plot_diffraction_patterns(obj, figureNumber)
%PLOT_DIFFRACTION_PATTERNS Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  figureNumber = 1;
end
%dp = class(obj(1).DiffractionPattern).empty(length(obj), 0);
% if isa(obj.DiffractionPattern, 'OneDDiffractionPattern')
%   dp = OneDDiffractionPattern.empty(length(obj), 0);
% elseif isa(obj.DiffractionPattern, 'TwoDDiffractionPattern')
%   dp = TwoDDiffractionPattern.empty(length(obj), 0);
% end
% for i = 1:length(obj)
%   dp(i) = obj(i).DiffractionPattern;
% end

obj.DiffractionPattern.plot(figureNumber);
legendString = [];
if exist(obj.VariableArray)
  for i = 1:obj.NumStructures
    legendString = [legendString; {[num2str([obj.LightSource.Wavelength]'), ...
      repmat(' nm; ', obj.NumWavelengths, 1),...
      repmat([num2str(obj.VariableArray(i)), ' nm'], obj.NumWavelengths, 1)]}];
  end
  legend(legendString)
  legend boxoff;
end

end

