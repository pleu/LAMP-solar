function qF0 = calc_qF0(bandGap, n)
% calculates F0 for a step function absorber;
% in units of Amps/m^2
ss = SolarSpectrum.global_AM1p5;
EVector = linspace(bandGap, max(ss.Energy), 1e5);
%EVector = ss.Energy(ss.Energy >= bandGap);
qF0 = Constants.LightConstants.Q*trapz(EVector, SolarSpectrum.calculate_bn(EVector, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a));
% figure(1);
% clf;
% be = SolarSpectrum.calculate_bn(EVector, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a)
% plot(EVector, be, 'b')
end