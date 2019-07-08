function [lambdaResonances] = calculate_spp_modes_array(op, rhs)

lambdaResonances = zeros(length(rhs), 1);
lambdaResonances(1) = calculate_spp_modes(op, rhs(1));

for ind = 2:length(rhs)
  lambdaResonances(ind) = calculate_spp_modes(op, rhs(ind), real(2*pi./lambdaResonances(ind-1)));  
  ind
  lambdaResonances
end


