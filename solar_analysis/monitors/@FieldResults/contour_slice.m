function contour_slice(obj, x, y, z, wavelength)
%CONTOUR_SLICE Summary of this function goes here
% for x, y, z, and wavelength
% designate one 'x' for x-axis
% designate one 'y' for y-axis
% use values to designate slices for the other two values
%
% obj.contourslice(30, 30, 'x', 'y');
  [xData, yData, data] = extract_data(obj, x, y, z, wavelength);
  %data = obj.OutputObj.Value(:, :); 
  [c, h] = contourf(xData, yData, data', 500);
  set(h,'edgecolor','none')
  %shading flat;
  colorbar;
%  title(field);

end

function [xData, yData, data] = extract_data(obj, x, y, z, wavelength)
  %[nx, ny, nz, nwavelength] = size(fr.OutputObj.Value);
  if strcmpi(x, 'x') && strcmpi(y, 'y')
    xData = obj.X;
    yData = obj.Y;
    disp(['z = ', num2str(obj.Z(z))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(:, :, z, wavelength);
  elseif strcmpi(x, 'x') && strcmpi(z, 'y')
    xData = obj.X;
    yData = obj.Z;
    disp(['y = ', num2str(obj.Y(y))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(:, y, :, wavelength);
    data = squeeze(data);
  elseif strcmpi(x, 'x') && strcmpi(wavelength, 'y')
    xData = obj.X;
    yData = obj.Wavelength;
    disp(['y = ', num2str(obj.Y(y))]);
    disp(['z = ', num2str(obj.Z(z))]);
    data = obj.OutputObj.Value(:, y, z, :);
  elseif strcmpi(y, 'x') && strcmpi(x, 'y')
    xData = obj.Y;
    yData = obj.X;
    disp(['z = ', num2str(obj.Z(z))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(:, :, z, wavelength);
    data = data';
  elseif strcmpi(y, 'x') && strcmpi(z, 'y')
    xData = obj.Y;
    yData = obj.Z;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(x, :, :, wavelength);
    data = squeeze(data);
  elseif strcmpi(y, 'x') && strcmpi(wavelength, 'y')
    xData = obj.Y;
    yData = obj.Wavelength;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['z = ', num2str(obj.Z(z))]);
    data = obj.OutputObj.Value(x, :, z, :);
  elseif strcmpi(z, 'x') && strcmpi(x, 'y')
    xData = obj.Z;
    yData = obj.X;
    disp(['y = ', num2str(obj.Y(y))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(:, y, :, wavelength);
    data = data';
  elseif strcmpi(z, 'x') && strcmpi(y, 'y')
    xData = obj.Z;
    yData = obj.Y;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['wavelength = ', num2str(obj.Wavelength(wavelength))]);
    data = obj.OutputObj.Value(x, :, :, wavelength);    
    data = data';
  elseif strcmpi(z, 'x') && strcmpi(wavelength, 'y')    
    xData = obj.Z;
    yData = obj.Wavelength;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['y = ', num2str(obj.Y(y))]);
    data = obj.OutputObj.Value(x, y, :, :);   
  elseif strcmpi(wavelength, 'x') && strcmpi(x, 'y')
    xData = obj.Wavelength;
    yData = obj.X;
    disp(['y = ', num2str(obj.Y(y))]);
    disp(['z = ', num2str(obj.Z(z))]);
    data = obj.OutputObj.Value(:, y, z, :);
    data = data';
  elseif strcmpi(wavelength, 'x') && strcmpi(y, 'y')
    xData = obj.Wavelength;
    yData = obj.Y;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['z = ', num2str(obj.Z(z))]);
    data = obj.OutputObj.Value(x, :, z, :);
    data = data';
  elseif strcmpi(wavelength, 'x') && strcmpi(z, 'y')
    xData = obj.Wavelength;
    yData = obj.Z;
    disp(['x = ', num2str(obj.X(x))]);
    disp(['y = ', num2str(obj.Y(y))]);
    data = obj.OutputObj.Value(x, y, :, :);
    data = data';
  end
end


function [indices] = get_both_slice_index(obj, x, y, z, wavelength)
  indices = [0 0]; % incides 
  %numIndex = 1;
  indices(1) = get_slice_index(x, y, z, wavelength);
end

function get_slice_index(x, y, z, wavelength)
  if isnumeric(x)
    indices(numIndex) = x;
%    indices(numIndex) = find(is_numerically_equal(obj.X, x));
    %numIndex = numIndex + 1;
  elseif isnumeric(y)
    indices(numIndex) = y;
    %indices(numIndex) = find(is_numerically_equal(obj.Y, y));
    %numIndex = numIndex + 1;
  elseif isnumeric(z)
    indices(numIndex) = z;
    %indices(numIndex) = find(is_numerically_equal(obj.Z, z));
    %numIndex = numIndex + 1;  
  elseif isnumeric(wavelength)
    indices(numIndex) = wavelength;
    %indices(numIndex) = find(is_numerically_equal(obj.Z, z));
    %numIndex = numIndex + 1;  
    %indices(numIndex) = find(is_numerically_equal(obj.Wavelength, z));      
  end
end
  

function [data, index] = get_data(obj, x, y, z, wavelength, string)
  sum = 0;
  if strcmpi(x, string)
    data = obj.X;
    sum = sum + 1;
    index = 1;
  end
  if strcmpi(y, string)
    data = obj.Y;
    sum = sum + 1;
    index = 2;
  end
  if strcmpi(z, string)
    data = obj.Z;
    sum = sum + 1;
    index = 3;
  end
  if strcmpi(wavelength, string)
    data = obj.Wavelength;
    sum = sum + 1;
    index = 4;
  end
  if sum~=1
    error('must be only one variable designated for x and/or y');
  end

end

