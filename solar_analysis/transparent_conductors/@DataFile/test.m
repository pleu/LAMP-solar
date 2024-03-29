function test()
  clear;
  markerSize = 8;
%  plotOptions = {{'logarithmicX','LineStyle','none', 'Color','b', 'MarkerFaceColor','b','Marker','v', 'MarkerSize',markerSize,'LineType', ''},...
%  {'logarithmicX','LineStyle','none', 'Color', 'r', 'MarkerFaceColor','r','Marker', '>', 'MarkerSize',markerSize,'LineType', ''}};

  plotOptions{1} = {'logarithmicX','LineStyle','none', 'Color','b', 'MarkerFaceColor','b','Marker','v', 'MarkerSize',markerSize,'LineType', ''};
  plotOptions{2} = {'logarithmicX','LineStyle','none', 'Color','r', 'MarkerFaceColor','r','Marker','>', 'MarkerSize',markerSize,'LineType', ''};
  

%  plotOptions = {{'''logarithmicX'',''LineStyle'',''none'', ''Color'',''b'', ''MarkerFaceColor'',''b'',''Marker'',''v'', ''MarkerSize''',num2str(markerSize),'''LineType'', '''},...
%  {'''logarithmicX'',''LineStyle'',''none'', ''Color'', ''r'', ''MarkerFaceColor'',''r'',''Marker'', ''>'', ''MarkerSize''',num2str(markerSize),'''LineType'', '''''}};
    
  df(1) = DataFile('ITO_sim.txt');
  df(2) = DataFile('AgTF_sim.txt');

  figure(2);
  clf;
  df.plot_transmission_versus_sheet_resistance(plotOptions{:});
  
%  df.plot_transmissivity_versus_sheet_resistance('logarithmicX', 'Color', 'g');

  
  
