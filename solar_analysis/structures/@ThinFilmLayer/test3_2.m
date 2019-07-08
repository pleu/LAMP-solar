% See page 114 in Photonics by Yariv and Yeh
% Works

thickness = 50;
lambda = 400;

op1 = OpticalProperties.create_constant_index(1);
op2 = OpticalProperties.create_constant_index(3.4);

ma1 = MaterialType.create('Air');
ma1.OpticalProperties = op1;

ma2 = MaterialType.create('Air');
ma2.OpticalProperties = op2;

tf(1) = ThinFilmLayer(ma1, thickness);
tf(2) = ThinFilmLayer(ma2, thickness);

[beta] = tf.calculate_waveguide_modes_from_lambda(lambda, 'TE');
%[beta] = tf.calculate_waveguide_modes_from_lambda(lambda, 'TE');

beta



