function [normalizedIntensity] = modify_normalized_intensity_array(obj, normalizedIntensitySingle, kPointsNewMat, kroneckerDelta, deltaInd);
%MODIFY_NORMALIZED_INTENSITY_ARRAY Summary of this function goes here
%   Detailed explanation goes here
normalizedIntensity = normalizedIntensitySingle;
nDim = 2;

if isinf(obj.Number(1))
  normalizedIntensity = ...
    normalizedIntensity.*kroneckerDelta;
else
  for ind = 1:nDim
    normalizedIntensityPrev = normalizedIntensity;
    normalizedIntensity = normalizedIntensity.*...
      (sin(obj.Number(ind)*pi*kPointsNewMat(:, :, ind))./...
      (sin(pi*kPointsNewMat(:, :, ind)))).^2/obj.Number(ind)^2;
    normalizedIntensity(kPointsNewMat(:, :, ind) == 0) = normalizedIntensityPrev(kPointsNewMat(:, :, ind) == 0);
    normalizedIntensity(deltaInd) = normalizedIntensitySingle(deltaInd);
  end
end


end

