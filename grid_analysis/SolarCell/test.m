clear;

%Define model parms, zero means neglected
SC.Lf=38e-3;               %length finger m 
SC.widthbuc= 0.5e-3;                 %1/2 width busbar (unit cell) m
SC.Rsh=55;                          %sheet resistance emitter Ohms/sq
SC.A = 39e-3;            % length unit cell for two bus bars; 39e-3*4 = .156 m = 15.6 cm
SC.rhoM = 3.2e-8;       % conductivity of metal Ohms-meter

SC.jmpp=340;                          %current density active cell area A/m^2
SC.Va=520e-3;                       %voltage at mpp V 


SCGA = SolarCellGridAnalysis(SC);