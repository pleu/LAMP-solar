function [] = contour_plot(obj, figureNumber)
%CONTOUR_PLOT Summary of this function goes here
%   Detailed explanation goes here
numContourLines = 200;
if nargin == 1
  figureNumber = 1;
end

for i = 1:size(obj, 2)
%   radius = 90;
%   figure(figureNumber);
%   clf;
%   %[h1] = polarplot(obj(i).KxNormalized,obj(i).KyNormalized);
%   hold on;
%   %P = peaks(obj(i).KxNormalized,obj(i).KyNormalized);
%   r2 = [0 radius];
%   axprop = {'DataAspectRatio',[1 1 8],'View', [-12 38],...
%     'Xlim', [-90 90],       'Ylim', [-90 90],...
%     'XTick',[-4 -2 0 2 4],    'YTick',[-4 -2 0 2 4]};
%   figure(1);
%   clf;  
%   polarplot3d(obj(i).NormalizedIntensity,'plottype','surfcn','radialrange',[0 90]*pi/180,...
%     'polargrid',{10 360},'tickspacing',15);
%   set(gca,axprop{:});

  

  %  thetaX = [-obj(i).ThetaX(numel(obj(i).ThetaX):-1:2) obj(i).ThetaX];
  %  thetaY = [-obj(i).ThetaY(numel(obj(i).ThetaY):-1:2) obj(i).ThetaY];
  %[thetaXGrid,thetaYGrid] = meshgrid(obj(i).ThetaX, obj(i).ThetaY);
  %  normalizedIntensity = zeros(numel(obj(i).ThetaY)*2-1,numel(obj(i).ThetaX)*2-1);
  
  %  normalizedIntensity(numel(obj(i).ThetaY):1:2*numel(obj(i).ThetaY)-1,:) = [obj(i).NormalizedIntensity(:,numel(obj(i).ThetaX):-1:2) obj(i).NormalizedIntensity];
  %  normalizedIntensity(1:numel(obj(i).ThetaY)-1,:) = normalizedIntensity(2*numel(obj(i).ThetaY)-1:-1:numel(obj(i).ThetaY)+1,:);
  
  %obj.NormalizedIntensity(obj(i).ThetaX.^2 + obj.(i).ThetaY.^2 > 90^2) = nan;
  
%   ch = get(h,'child'); 
%   alpha(ch,0.2)
%   set(h1,'Visible','off');

figure(2);
clf;
%  [h1] = polar(obj(i).KxNormalized,obj(i).KyNormalized);
%hold on;
[C, h]= contourf(obj(i).KxNormalized, obj(i).KyNormalized, obj.NormalizedIntensity, numContourLines);
%set(h1,'Visible','off');  
shading flat;
  set(h, 'edgecolor', 'none');
  axis image;
  
  figure(3);
  clf;
 % [h1] = polar(obj(i).Kx,obj(i).Ky);
  hold on;

  contour3(obj(i).KxNormalized, obj(i).KyNormalized, obj(i).NormalizedIntensity, numContourLines);
%  set(h1,'Visible','off');
  
%   figure(4);
%   clf;
% 
%   [h1] = polar(obj(i).Kx,obj(i).Ky);
%   hold on;
% 
%   surf(obj(i).Kx, obj(i).Ky, obj(i).NormalizedIntensity);
%   set(h1,'Visible','off');

end


xlabel('Theta (degrees)');
ylabel('Normalized Intensity');
%axis([-90 90 0 1]);

end




