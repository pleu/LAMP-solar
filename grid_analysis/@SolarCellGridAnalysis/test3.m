clear;

% this solves first example in Table 3.2

SC.Acell = .156^2;
%Define model parms, zero means neglected
SC.Lf=38e-3;               %length finger m 
SC.Hf = 1e-6;
SC.Wf = 100e-6;


SC.Wbuc= 1e-3;                 %width busbar (unit cell) m
SC.Rsh=90;                          %sheet resistance emitter Ohms/sq
SC.A = 39e-3;            % length unit cell for two bus bars; 39e-3*4 = .156 m = 15.6 cm
SC.rhoM = 3.2e-8;       % conductivity of metal Ohms-meter

SC.Jmpp=340;                          %current density active cell area A/m^2
SC.Vmpp=520e-3;                       %voltage at mpp V 

SC.rhoC = 0.5e-7;   % Ohm-m^2

SC.S = linspace(1e-4,5e-3);
%SC.S = 2.2e-3;

SCGA = SolarCellGridAnalysis(SC);
SCGA= SCGA.calc_Pe;


figure(1);
clf;
plot(SC.S, SCGA.Ploss)

[minPloss, minInd] = min(SCGA.Ploss);
minPloss
SC.S(minInd)