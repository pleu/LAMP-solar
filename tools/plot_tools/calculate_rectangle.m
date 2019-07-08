function [X,Y] = calculate_rectangle(x, y, w, h)
%# This functions returns points to draw an ellipse
%#
%#  @param x     X coordinate
%#  @param y     Y coordinate
%#  @param a     Semimajor axis
%#  @param b     Semiminor axis
%#  @param angle Angle of the ellipse (in degrees)
%#

narginchk(4,4);

alpha = linspace(0, 1)';
numSteps = length(alpha);
side = ones(numSteps, 1);

X = [x - w/2+(w* alpha); x + w/2*side; x+w/2-(w*alpha); x - w/2*side];
Y = [y+h/2*side; y+h/2-h*alpha; y-h/2*side; y-h/2+h*alpha];


% X = [x - (w/2* alpha); x + w/2*side; x + w/2*(1 - alpha); x-w/2*side];
% Y = [y+h/2*side; y + h/2*alpha; y-h/2*side; y+h/2*(1-alpha)];

if nargout==1, X = [X Y]; end

end