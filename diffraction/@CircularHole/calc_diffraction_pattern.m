function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength, kxGrid, kyGrid)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here

k = 2*pi/wavelength;

if nargin == 2 
  thetaVec = linspace(0,2*pi,181);
  %[theta,phi] = meshgrid(0,linspace(0,pi/2,181));
  phi = linspace(0, pi/2, 91);
  %[kxGrid,kyGrid] = pol2cart(theta,k*sin(phi));
  %maxZero = k*obj.Diameter;
  numZeros = floor(k*obj.Diameter/pi);
  bZeros = zeros(numZeros, 1);
  bessj0 = @(x) besselj(1,x);
  for n = 1:numZeros
    bZeros(n) = fzero(bessj0,[(n-1) n]*pi);
  end
  phi1 = asin(bZeros./(k*obj.Diameter));
  phi = unique([phi phi1']);
  
  [thetaGrid,phiGrid] = meshgrid(thetaVec,phi);
  [kxGrid,kyGrid] = pol2cart(thetaGrid,k*sin(phiGrid));
end

rGrid = sqrt(kxGrid.^2 + kyGrid.^2);
normalizedIntensity = (2*besselj(1,obj.Diameter/2.*rGrid)./...
  (obj.Diameter/2.*rGrid)).^2;
normalizedIntensity(rGrid == 0) = 1;


% normalizedIntensity = (2*besselj(1,obj.Diameter.*kxGrid)./...
%   (obj.Diameter.*kxGrid)).^2;
% normalizedIntensity(phi == 0) = 1;

diffractionPattern = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');

end

