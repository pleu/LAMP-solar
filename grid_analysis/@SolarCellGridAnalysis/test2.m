clear;

% this solves first example in Table 3.2

% nBusBarsArray = [2 3 4];
% widthBusBarsArrays = [1e-3 1e-3 1e-3];

nBusBarsArray = [2 3 4 16];
widthBusBarsArrays = [1e-3 .75e-3 1.1e-3/2 1e-4];
%SC.NBusbars = 16;

nBusBarTypes = length(nBusBarsArray);
%SC.Wbuc= 1e-3;                 %width busbar (unit cell) m
%SC.Wbuc= 1e-3;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= .75e-3;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= 1.1e-3/2;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= 1e-4;                 %width busbar (unit cell) m; ; half the busbar width


%cellSide = .156;
SC.Lcell = .156;  % cell length in m
SC.Hf = 15e-6;


%SC.Acell = cellSide^2;
%Define model parms, zero means neglected




%SC.Lf=25.3e-3;               %length finger m 


wMin=10e-6;                          %Minimum width
wMax=120e-6;                         %Maximum width
nWidths = 50;    % number widths
widthArray=linspace(wMin, wMax, nWidths);       %Width vector



SC.Rsh=55;                          %sheet resistance emitter Ohms/sq
SC.rhoM = 3.2e-8;       % conductivity of metal Ohms-meter

SC.Jmpp=340;                          %current density active cell area A/m^2
SC.Vmpp=520e-3;                       %voltage at mpp V 


SC.rhoC = 0.5e-7;   % Ohm-m^2

SC.S = linspace(1e-4,5e-3, 200);
%SC.S = 2.5e-3;

%SCGA = SolarCellGridAnalysis(SC);

%SCGA= SCGA.calc_Pe;

powerLoss=zeros(nBusBarTypes,nWidths) ;                %Define empty efficiency 
optimumSpacing=zeros(nBusBarTypes, nWidths);             %and spacing matrices
powerLossOptical=zeros(nBusBarTypes, nWidths);             %and spacing matrices
powerLossElectrical=zeros(nBusBarTypes, nWidths); 
powerLossOpticalBus = zeros(nBusBarTypes, nWidths);
metalUsed = zeros(nBusBarTypes, nWidths);

for i = 1:nBusBarTypes
  SC.NBusbars = nBusBarsArray(i);
  SC.Wbuc = widthBusBarsArrays(i);
  SC.A = SC.Lcell/(2*SC.NBusbars);            % length unit cell for five bus bars; .156/8 =
  %SC.A = 26e-3;            % length unit cell for three bus bars; 26e-3*6 = .156 m = 15.6 cm

  SC.Lf=SC.A-SC.Wbuc;               %length finger m; Lf + Wbuc = A

  for j = 1:nWidths
    SC.Wf = widthArray(j); %120e-6;
  %heightArray = SC.Wf*ARArray;
    SCGA = SolarCellGridAnalysis(SC);
    SCGA= SCGA.calc_Pe;
    
    [minPloss, minInd] = min(SCGA.Ploss);
    %minPloss
    powerLossOpticalBus(i,j) = SCGA.PsBus(minInd);
    powerLoss(i,j) = minPloss;
    metalUsed(i,j) = SCGA.massMetal(minInd);
    optimumSpacing(i,j)=SCGA.S(minInd);
    powerLossOptical(i,j) = SCGA.Ps(minInd);
    powerLossElectrical(i,j) = SCGA.Pe(minInd);
  end
end

figure(1);
clf;

plot(widthArray*1e6, powerLoss*100);
xlabel('Finger Width (\mum)');
ylabel('Power Loss (%)');

legend('2 busbars', '3 busbars', '4 busbars', 'busbarless', 'Location', 'SouthEast');
legend boxoff;

figure(2);
clf;

plot(widthArray*1e6, metalUsed*100);
xlabel('Finger Width (\mum)');
ylabel('Metal Used (g)');

legend('2 busbars', '3 busbars', '4 busbars', 'busbarless', 'Location', 'SouthEast');
legend boxoff;
