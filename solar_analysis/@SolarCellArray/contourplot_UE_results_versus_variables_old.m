function contourplot_UE_results_versus_variables(sr)

clf;
[XInd, YInd] = meshgrid(sr.VariableArray(1), sr.VariableArray(2));
ZInd = griddata(x, y, z, XInd, YInd, 'v4');

cmax = max(max(ZInd));

[c,h] = contourf(XAxis, YAxis, ZInd, 200);
shading flat;
hold on;

zMin=round(zMin*100);
zMax=round(zMax*100);
NoLine=zMax-zMin+1;
v=linspace(zMin/100,zMax/100,NoLine);
[c,h] = contour3(XInd, YInd, ZInd, v,'k');

for i = 1:length(h)
    zz = get(h(i), 'Zdata');
    set(h(i), 'LineWidth', 2);
    set(h(i), 'Zdata', (cmax+1)*ones(size(zz)));
end
text_handle = clabel(c, h);
colorbar('FontSize', 16);
xAxisLabel = strcat(sr.VariableStringArray(1,:), '(', sr.VariableUnitsArray, ')');
yAxisLabel = strcat(sr.VariableStringArray(2,:), '(', sr.VariableUnitsArray, ')');
xlabel(xAxisLabel);
ylabel(yAxisLabel);
