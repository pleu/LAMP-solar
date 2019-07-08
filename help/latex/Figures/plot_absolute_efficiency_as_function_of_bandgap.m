clear;
ss = SolarSpectrum.global_AM1p5;

thetaX = Constants.LightConstants.theta_s;
thetaE = thetaX;
[absoluteEfficiency] = ss.plot_absolute_efficiency_versus_energy(thetaX,thetaE);  
hold on;
plot(1.12, interp1(ss.Energy, absoluteEfficiency, 1.12), 'ko');

mTextBox = uicontrol('style','text')
set(mTextBox,'String','Si')
set(mTextBox, 'FontSize', 26);
set(mTextBox, 'BackgroundColor', [1 1 1]);
set(mTextBox,'Position', [215 375 30 25]);
%  set(mTextBox,'Position', [50 50 60 20]);

mTextBoxPosition = get(mTextBox,'Position')