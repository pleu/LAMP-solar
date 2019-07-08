AM0 = 1;
GLOBAL_AM1p5 = 2;
DIRECT_AND_CIRCUMSOLAR_AM1p5 = 3;

solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM1p5);
%MD = MaterialData('Si');
filename = 'SiNWTheta0Phi0';


sr = FDTDSimulationResults(filename, 'Si', solarSpectrum, 'wavelength');

sr.plot_results_versus_energy(0);

sr.plot_results_versus_wavelength(3)

UE=sr.UltimateEfficiency