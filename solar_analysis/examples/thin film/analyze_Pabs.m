diameter = 130;
pitch = 200;
thickness = 120;

slice = 100;

filename = ['Core-shellNanospherep200nmTotal'];

fr = FieldResults.create_scalar(filename, 'Pabs');
clf;
fr.X = fr.X * Constants.UnitConversions.MtoNM;
fr.Y = fr.Y * Constants.UnitConversions.MtoNM;
fr.Z = -fr.Z * Constants.UnitConversions.MtoNM;
fr.OutputObj.Value = fr.OutputObj.Value/(Constants.UnitConversions.MtoNM^3)

%maximum around 825
%fr.contour_slice('x', find(fr.Y == 0), 'y', 19);
%fr.contour_slice( find(round(fr.Y) == slice), 'x' ,'y', 1);
fr.contour_slice( 'x', find(round(fr.Y) == slice),'y', 1);
caxis([0 3e-7]);
title('');
%colorbar off;
if (strfind(filename,'Total') == [])
else
  % plot sphere  
  theta=0:pi/100:2*pi;
  x=sqrt((diameter/2)^2-slice^2)*cos(theta);
  y=sqrt((diameter/2)^2-slice^2)*sin(theta)-diameter/2;
  hold on;  
  plot([-pitch/2 pitch/2],[thickness thickness],'w--');
  plot([-pitch/2 pitch/2],[0 0],'w--');
  plot(x,y,'w--');
  
end

xlabel('nm');
ylabel('nm');
title('P_{abs}');
axis image;

hold on;


