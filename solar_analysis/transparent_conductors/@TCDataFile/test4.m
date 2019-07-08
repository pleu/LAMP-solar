function test4()
  clear;
  markerSize = 8;
%  plotOptions = {{'logarithmicX','LineStyle','none', 'Color','b', 'MarkerFaceColor','b','Marker','v', 'MarkerSize',markerSize,'LineType', ''},...
%  {'logarithmicX','LineStyle','none', 'Color', 'r', 'MarkerFaceColor','r','Marker', '>', 'MarkerSize',markerSize,'LineType', ''}};

  

%  plotOptions = {{'''logarithmicX'',''LineStyle'',''none'', ''Color'',''b'', ''MarkerFaceColor'',''b'',''Marker'',''v'', ''MarkerSize''',num2str(markerSize),'''LineType'', '''},...
%  {'''logarithmicX'',''LineStyle'',''none'', ''Color'', ''r'', ''MarkerFaceColor'',''r'',''Marker'', ''>'', ''MarkerSize''',num2str(markerSize),'''LineType'', '''''}};
    
  df(1) = TCDataFile('ITO_sim.txt');
  df(2) = TCDataFile('AgTF_sim.txt');

  df(1).PlotOptions = {'logarithmicX','LineStyle','none', 'Color','b', 'MarkerFaceColor','b','Marker','v', 'MarkerSize',markerSize,'LineType', ''};
  df(2).PlotOptions = {'logarithmicX','LineStyle','none', 'Color','r', 'MarkerFaceColor','r','Marker','>', 'MarkerSize',markerSize,'LineType', ''};
  
  
  figure(2);
  clf;
  df.plot_transmission_versus_sheet_resistance();

%  df.plot_transmissivity_versus_sheet_resistance('logarithmicX', 'Color', 'g');

  