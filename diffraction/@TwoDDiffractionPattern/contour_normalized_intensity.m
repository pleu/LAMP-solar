function [] = contour_normalized_intensity(obj, howPlot, figureNumber)
%CONTOUR_PLOT Summary of this function goes here
%   Detailed explanation goes here
%numContourLines = 200;
if nargin == 1
  howPlot = obj.HowCalcHaze;
  figureNumber = 1;
elseif nargin == 2
  figureNumber = 1;
end

phi = obj.Phi(:, 1);
theta = obj.Theta(2, :);
% polarplot3d(P,'plottype','surfn','radialrange',[min(r4) max(r4)],...
%               'angularrange',[min(t4) max(t4)],'polargrid',{r4 t4},'tickspacing',15);

for i = 1:size(obj, 2)
  %dummy = zeros(size(obj(i).NormalizedIntensity));
  figure(figureNumber+i-1);
  clf;
  xlimit = 120;
  %[h1] = polarplot(obj(i).KxNormalized,obj(i).KyNormalized);
  hold on;
  %P = peaks(obj(i).KxNormalized,obj(i).KyNormalized);
  axprop = {'DataAspectRatio',[1 1 8],'View', [0 90],...
    'Xlim', [-xlimit xlimit]*pi/180,       'Ylim', [-xlimit xlimit]*pi/180,...
    'XTick',-xlimit:20:xlimit*pi/180,    'YTick',-xlimit:20:xlimit*pi/180};
%   figure(1);
%   clf;

  if strcmp(howPlot, 'sum')    
    polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
      'ColorData', obj(i).NormalizedIntensity, 'interpmethod', 'nearest', 'polargrid',{9 24},'tickspacing',15);

%     polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
%       'ColorData', log(obj(i).NormalizedIntensity), 'interpmethod', 'nearest', 'polargrid',{9 24},'tickspacing',15);

%     polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
%       'ColorData', log(obj(i).NormalizedIntensity), 'interpmethod', 'nearest', 'polargrid',{9 24},'tickspacing',15);
    set(gca,axprop{:});
    hold on;
    [ind] = find(obj(i).NormalizedIntensity ~= 0);
    %indNotCenter = obj(i).Phi(ind) ~= 0
    %indCheck = ind(indNotCenter);
    %scatter3(obj(i).KxNormalized(indCheck), obj(i).KyNormalized(indCheck), obj(i).NormalizedIntensity(indCheck), 50, obj(i).NormalizedIntensity(indCheck), 'filled');
    
    %     x = [0; obj(i).KxNormalized(indCheck)];
    %     y = [0; obj(i).KyNormalized(indCheck)];
    %     z = [1; obj(i).NormalizedIntensity(indCheck)];
    %     [h] = scatter3(x, y, z,80, z, 'filled', 'MarkerEdgeColor', [.3 .3 .3], 'LineWidth', 1);
    scatter3(obj(i).KxNormalized(ind), obj(i).KyNormalized(ind), obj(i).NormalizedIntensity(ind),...
      80, obj(i).NormalizedIntensity(ind), 'filled', 'MarkerEdgeColor', [0.5 0.5 0.5], 'LineWidth', 1.5);
    caxis([0 1]);
    
%     figure(2);
%     clf;
%     %z = [.0313 .0547 .3281 .5728 1 1 1 1 1 1];
% %    scatter3(x, y, z, 50, z, 'filled');
%     scatter3(x, y, z, 80, z, 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1);

%     [indCheck] = find(obj(i).NormalizedIntensity ~= 0);
%     indNotCenter = obj(i).Phi(indCheck) ~= 0;
%     indCenter = obj.Phi == 0;
%     numDeltas = sum(indNotCenter)
%     
%     indCheck = indCheck(indNotCenter);
%     scatter3(obj(i).KxNormalized(indCheck), obj(i).KyNormalized(indCheck), obj(i).NormalizedIntensity(indCheck), 70);

    
  else
  
    if size(obj(i).NormalizedIntensity, 2) == 1
      minSize = 361;
      normalizedIntensity = obj(i).NormalizedIntensity*ones(1, minSize);
      polarplot3d(normalizedIntensity,'plottype','surfcn','radialrange',[0 90]*pi/180,...
        'polargrid',{9 24},'tickspacing',15);
      set(gca,axprop{:});
      hold on;
    else
      %     polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','radialrange',[0 90]*pi/180,...
      %       'polargrid',{9 24},'tickspacing',15);
      polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
        'interpmethod', 'spline', 'polargrid',{9 24},'tickspacing',15);
      
      %     polarplot3d(obj(i).NormalizedIntensity,'xi', obj(i).KxNormalized, 'yi', obj(i).KyNormalized, 'plottype','surfcn','radialrange',[0 90]*pi/180,...
      %       'polargrid',{9 24},'tickspacing',15);
      set(gca,axprop{:});
      hold on;
      %    contourf(obj(i).KxNormalized, obj(i).KyNormalized, obj(i).NormalizedIntensity);
    end
  end


end


xlabel('Theta (degrees)');
ylabel('Normalized Intensity');
%axis([-90 90 0 1]);

end




