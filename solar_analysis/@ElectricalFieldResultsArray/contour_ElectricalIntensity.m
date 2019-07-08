function [] = contour_ElectricalIntensity(obj)

    X = obj.PositionX;
    Z = obj.PositionZ;
    %Z = flipud(Z);

    IntegrateE2 = obj.ElectricalField;
    Generation = obj.Generation;
    
    figure(1);
    clf;
    dataContour = squeeze(IntegrateE2(:, :));
    contourf(X, Z, dataContour', 500);
    shading flat;
    xlabel('x (nm)');
    ylabel('z (nm)');
    colorbar;
    hold on;
    
    figure(2);
    clf;
    for i=1:obj.NumX
        for j=1:obj.NumZ
            if Generation(i,j)>0
                Generation(i,j)=log10(Generation(i,j));
            else
                Generation(i,j)=Generation(i,j);
            end
        end
    end
    dataContour = squeeze(Generation(:, :));
    contourf(X, Z, dataContour', 500);
    shading flat;

    xlabel('x (nm)');
    ylabel('z (nm)');
    colorbar;
    hold on;
end
