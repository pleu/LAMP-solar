
%TEST Summary of this function goes here
%   Detailed explanation goes here

pitch = 1400;
%lattice = 50*[1 0;0 1];
%number = [200];
number = inf;
holeWidth = 1000;

%wavelength = 1380;
wavelengthArray = linspace(200, 2000);
hazeAngle = zeros(length(wavelengthArray), 1);
hazeAngleCheck = zeros(length(wavelengthArray), 1);

for i = 1:length(wavelengthArray)
  wavelength = wavelengthArray(i);
  k = 2*pi/wavelength;
  numKPts = 200;
  kx = linspace(-k,k, numKPts);
  
  minN = floor(pitch/wavelength);
  k1 = 2*pi./pitch*(-minN:1:minN);
  
  kx = unique([kx k1]);
  
  normalizedIntensitySlit = (sin(1/2*holeWidth.*kx)./(1/2*holeWidth.*kx)).^2;
  normalizedIntensitySlit(kx == 0) = 1;
  
  theta = rad2deg(asin(kx/k));
  
  figure(1);
  clf;
  plot(theta, normalizedIntensitySlit, 'b')
  
  
  if isinf(number)
    kroneckerDelta = zeros(1, numel(theta));
    kroneckerDelta(ismember(kx, k1)) = 1;
    normalizedIntensityArray = kroneckerDelta;
    normalizedIntensity = normalizedIntensitySlit.*normalizedIntensityArray;
    normalizedIntensity(kx == 0) = 1;
  else
    normalizedIntensityArray = ...
      (sin(number*1/2*kx*pitch)./...
      (sin(1/2*pitch.*kx))).^2/number^2;
    normalizedIntensity = normalizedIntensitySlit.*normalizedIntensityArray;
    normalizedIntensity(ismember(kx, k1)) = normalizedIntensitySlit(ismember(kx, k1));
    normalizedIntensity(kx == 0) = 1;
  end
  
  % hold on;
  % %plot(theta, normalizedIntensityArray, 'r');
  % plot(theta, normalizedIntensity, 'g')
  
  
  angleCutoff = 2.5;
  indexPos = find(theta >= angleCutoff);
  indexNeg = find(theta <= -angleCutoff);
  hazeAnglePositive = trapz(theta(indexPos), normalizedIntensity(indexPos));
  hazeAngleNegative = trapz(theta(indexNeg), normalizedIntensity(indexNeg));
  hazeAngle(i) = (hazeAnglePositive+hazeAngleNegative)/...
    trapz(theta, normalizedIntensity);
  
  kCutoff = k*sin(deg2rad(angleCutoff));
  indexPos = find(kx >= kCutoff);
  indexNeg = find(kx <= -kCutoff);  
  hazeAnglePositiveCheck = trapz(kx(indexPos), normalizedIntensity(indexPos));
  hazeAngleNegativeCheck = trapz(kx(indexNeg), normalizedIntensity(indexNeg));
  hazeAngleCheck(i) = (hazeAnglePositiveCheck+hazeAngleNegativeCheck)/...
    trapz(kx, normalizedIntensity);
  
end

figure(1);
clf;
plot(wavelengthArray, hazeAngle*100, 'b');
hold on;
plot(wavelengthArray, hazeAngleCheck*100, 'g');

axis([0 2000 0 100]);


