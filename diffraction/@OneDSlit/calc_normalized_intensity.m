function [normalizedIntensity] = calc_normalized_intensity(obj, kx)

%theta = rad2deg(asin(kx/k));


normalizedIntensity = (sin(1/2*obj.HoleWidth.*kx)./(1/2*obj.HoleWidth.*kx)).^2;
normalizedIntensity(kx == 0) = 1;



end

