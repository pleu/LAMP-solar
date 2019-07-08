function [] = plot(obj, variable, value)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

% figure(3);
% clf;
color = ('bgrcmy');
for i = 1:length(obj)
  plot(obj(i).Phi*180/pi, obj(i).NormalizedIntensity, color(i));
end
xlabel('Theta (Degrees)');
ylabel('Transmission');

end

