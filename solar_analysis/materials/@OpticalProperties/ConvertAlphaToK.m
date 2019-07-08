function [K] = ConvertAlphaToK(alpha, frequency)
  K = alpha*Constants.LightConstants.C./(2.*2*pi*frequency*...
    Constants.UnitConversions.NMtoM); % in nm
end

