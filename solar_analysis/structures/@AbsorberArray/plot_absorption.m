function plot_absorption(sa, xAxis)
% xAxis should be 'Energy' or 'Wavelength';
  color = ('bgrcmy');
  legendArray = cell(length(sa),1 );
  for i = 1:length(sa)
    sa(i).Absorber.plot_absorption(xAxis, 'Color', color(i));
    legendArray{i} = sa(i).Absorber.Name;
  end
  title_or_legend(legendArray);
end

