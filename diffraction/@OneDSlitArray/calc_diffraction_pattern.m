function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   This seems to work for test2

%theta = 0:0.5:90;

% include thetas where array part == 1
% where the array part == 1
%maxN = floor(obj.Pitch/wavelength);
% theta1 = rad2deg(asin(wavelength*(0:1:maxN)./(obj.Pitch)));
% [theta] = unique([theta theta1]);
diffractionPattern(size(obj, 1)*size(obj,2)*size(obj,3)) = OneDDiffractionPattern;

for i = 1:size(obj, 1)
  for j = 1:size(obj, 2)
    for kInd = 1:size(obj, 3)
      numKPts = 200;
      
      k = 2*pi/wavelength;
      kx = linspace(-k,k, numKPts);
      %theta = rad2deg(asin(k_x/k));
      minN = floor(obj(i, j, kInd).Pitch/wavelength);
      k1 = 2*pi./obj(i, j, kInd).Pitch*(-minN:1:minN);
      kx = unique([kx k1]);
      
      % latticePoints = 0:maxN;
      % %kPts = 2*pi./
      % kPts = latticePoints*2*pi/obj.Pitch;
      % theta1Check = rad2deg(asin(kPts.*wavelength/(2*pi)));
      
      
      
      dp = obj(i, j, kInd).OneDSlit.calc_diffraction_pattern(wavelength, kx);
      [diffractionPattern(i, j, kInd)] = obj(i, j, kInd).calc_diffraction_array(dp, wavelength, k1);
    end
  end
end

end

