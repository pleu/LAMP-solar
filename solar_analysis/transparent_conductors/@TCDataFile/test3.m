df = TCDataFile.read_haze_transmission_file('CuNM_High_Low_H_T.txt');
ourMarkerSize = 8;
plotOptions = {'LineStyle',...
  'none','Color', 'b', 'Marker', 's','MarkerFaceColor','b','MarkerSize',ourMarkerSize, 'LineType', ''};
figure(1);
clf;
df.plot_transmission_versus_haze(plotOptions{:});
axis([0 100 0 100]);

  
  
