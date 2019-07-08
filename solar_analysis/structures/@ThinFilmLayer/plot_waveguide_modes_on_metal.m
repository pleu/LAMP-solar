function [lambdaResonancesArray] = plot_waveguide_modes_on_metal(tf, betaArray, TEorTM)

[lambdaResonancesArray] = calculate_waveguide_modes_on_metal2(tf, betaArray, TEorTM)

for j = 1:size(lambdaResonancesArray, 1)
  ind = ~isnan(real(lambdaResonancesArray(j, :)));
  plot(betaArray, lambdaResonancesArray(j, ind));
  hold on;
end

end
