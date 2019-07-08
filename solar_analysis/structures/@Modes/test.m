thickness = 100;


ma1 = MaterialType.create('Air');
ma1.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');

ma2 = MaterialType.create('Si');
ma2.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');

%ma2.OpticalProperties = OpticalProperties('Si3N4 (FDTD)');

tf(1) = ThinFilmLayer(ma1, thickness);
tf(2) = ThinFilmLayer(ma2, thickness);

%tf = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes_on_metal(tf);

mo = Modes('TEM', lambdaResonances, []);
