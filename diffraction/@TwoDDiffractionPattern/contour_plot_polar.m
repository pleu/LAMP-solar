function [] = contour_plot_polar(obj)
%CONTOUR_PLOT_POLAR Summary of this function goes here
%   Detailed explanation goes here

x = sin(obj.Phi).*cos(obj.Theta);
y = cos(obj.Phi).*cos(obj.Theta);

h = polar(x,y);
hold on;
contourf(x,y,obj.NormalizedIntensity);
set(h,'Visible','off')
axis off
axis image

end

