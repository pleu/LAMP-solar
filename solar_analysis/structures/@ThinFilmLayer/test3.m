% See page 114 in Photonics by Yariv and Yeh
% Works

thickness = 5000;
lambda = 1550;


op1 = OpticalProperties.create_constant_index(1.5);
op2 = OpticalProperties.create_constant_index(1.6);

ma1 = MaterialType.create('Air');
ma1.OpticalProperties = op1;

ma2 = MaterialType.create('Air');
ma2.OpticalProperties = op2;

tf(1) = ThinFilmLayer(ma1, thickness);
tf(2) = ThinFilmLayer(ma2, thickness);

[beta] = tf.calculate_waveguide_modes_from_lambda(lambda, 'TM');
%[beta] = tf.calculate_waveguide_modes_from_lambda(lambda, 'TE');

beta



