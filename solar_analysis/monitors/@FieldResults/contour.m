function contour(obj, field)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  if isa(obj.OutputObj, 'VectorField')
    if strcmpi(field, 'x')
      data = obj.OutputObj.VecX;
      magnitude =0;
    elseif strcmpi(field, 'y')
      data = obj.OutputObj.VecY;
      magnitude =0;
    elseif strcmpi(field, 'z')
      data = obj.OutputObj.VecZ;    
      magnitude =0;
    elseif strcmpi(field, '2')
      data = obj.OutputObj.Vec2;        
      magnitude =1;
    end
  else % ScalarField
    data = obj.OutputObj.Value;        
    magnitude =1;
  end
  contourf(obj.X, obj.Y, data', 100);
  shading flat;
  colorbar;
  title(field);
  
  if ~magnitude
    colormap(bluewhitered);
    maxMagnitude = max(max(abs(data)));
    caxis([-1*maxMagnitude maxMagnitude]);
  else
    colormap('default');
    maxMagnitude = max(max(abs(data)));
    caxis([0 maxMagnitude]);
  end
  

end

