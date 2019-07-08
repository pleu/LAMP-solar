function colorShade = shade(varargin)
%SHADE   Create shade of a color or colormap
%
%   SHADE(color,factor) takes rgb color (n-by-3, values between 0 and 1) or
%   colormap and factor (scalar, between 0 and 1, 0 = black, 1 = original)
%   and returns the shade (same size as color)
%
%   SHADE(color) takes rgb color (n-by-3, values between 0 and 1) or
%   colormap and shows example shades 
%
%   Examples:
%       shade([1 0 0],0.5)  % returns a shade of red
%       shade(jet(9),0.5)   % returns a shade of each color of jet colormap
%       shade([1 0 0])      % displays example shades of red
%       shade(jet(9))       % displays example shades of jet colormap 

narginchk(1,2);
p = inputParser;
p.addRequired('color',...
    @(x) validateattributes(x,...
    {'numeric'},{'nonempty','ncols',3,'>=', 0,'<=', 1}));
p.addOptional('factor',[],...
    @(x) validateattributes(x,...
    {'numeric'},{'scalar','>=', 0,'<=', 1}));
p.parse(varargin{:});
color = p.Results.color;
factor = p.Results.factor;

switch nargin
    case 2
        colorShade = factor*color;
    case 1
        nColors = size(color,1);
        nShades = 11;
        factors = linspace(0,1,nShades);
        figure
        hold on
        for iColor = 1:nColors
            for iShade = 1:nShades
                colorShadeExample = shade(color(iColor,:),factors(iShade));
                patch([iColor (iColor+1) (iColor+1) iColor],[iShade iShade (iShade+1) (iShade+1)],...
                    colorShadeExample,'edgecolor','none')
            end
            set(gca,'XTick',0.5+(1:nColors),'XTickLabel',1:nColors)
            set(gca,'YTick',0.5+(1:nShades),'YTickLabel',factors)
            axis tight
            xlabel('Color index')
            ylabel('Shade factor')
        end
end


end