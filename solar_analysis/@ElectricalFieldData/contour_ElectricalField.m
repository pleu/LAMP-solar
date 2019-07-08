function [] = contour_ElectricalField(obj)

    X = obj.X;
    Z = obj.Z;
    Z = flipud(Z);

    electricalintensity=obj.ElectricalIntensity;
    E_max=max(max(electricalintensity));
    clf;
    dataContour = squeeze(electricalintensity);
    contourf(X, Z, dataContour', 100);
    %set(gca, 'FontSize', 16);
    shading flat;
    xlabel('x (nm)');
    ylabel('z (nm)');
    if E_max<1000;
    %title('|E|^2 (V/m)^2');
    cmax=2.5;
    else
    %title('Loss');
    cmax=2e4;
    end
    caxis([0 cmax]);
    colorbar;
end




