function [beta] = plot_light_line(op, varargin)

beta = op.N.*op.AngularFrequency./Constants.LightConstants.C;

plot(real(beta), op.AngularFrequency, varargin{:});
xlabel('Wave vector (m^{-1})');
ylabel('Frequency (Hz)');


