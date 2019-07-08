bandGaps = [1.3];
ss = SolarSpectrum.global_AM1p5;


energyInd = find(ss.Energy >= bandGaps);
currentSC = -Constants.LightConstants.Q*...
        trapz(ss.Energy(energyInd),...
        ss.PhotonFlux(energyInd));      
IV = SolarCellIV.calc_IV2(bandGaps, currentSC, ss);
voltage = 0.8;

geometricalFactor = pi;
EVector = linspace(bandGaps, max(ss.Energy));
% current with no voltage
currentDark0 = Constants.LightConstants.Q*geometricalFactor*trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));


current = interp1(IV.Voltage, IV.CurrentLight, voltage)
% powerDensity = current*voltage  % Watts/m^2

figure(1);
clf;
IV.plot_IV;
axis([0 1 -1e3 1e3]);

tsc = TandemSolarCell(ss, bandGaps);

[Js, F0t] = tsc.calc_maximum_power_point;

voltage = tsc.BandGaps - Constants.LightConstants.k_B.*Constants.LightConstants.T_a;

%voltage = [0.8; 0.9]
[power, powerGradient] = TandemSolarCell.power_density(voltage, Js, F0t);



 