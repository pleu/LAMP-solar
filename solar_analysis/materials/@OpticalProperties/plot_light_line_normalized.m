function [] = plot_light_line_normalized(op, varargin)

beta = op.N.*op.AngularFrequency;

plot(real(beta), op.AngularFrequency, varargin{:});
xlabel('Wave vector');
ylabel('Angular Frequency');
