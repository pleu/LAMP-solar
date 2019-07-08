clear;

% this solves first example in Table 3.2

SC.Acell = .156^2;
%Define model parms, zero means neglected
SC.Lf=38e-3;               %length finger m 



%Define loop + array constants:
ARMin=0.1;                           %Minimum aspect ratio; 
ARMax=1;                           %Maximum aspect ratio
nAR=40;                              % number aspect ratio



wMin=10e-6;                          %Minimum width
wMax=100e-6;                         %Maximum width
nWidths = 40;    % number widths

ARArray=linspace(ARMin, ARMax, nAR);        %Aspect ratio vector
widthArray=linspace(wMin, wMax, nWidths);       %Width vector


SC.Wbuc= 1e-3;                 %width busbar (unit cell) m
SC.Rsh=90;                          %sheet resistance emitter Ohms/sq
SC.A = 39e-3;            % length unit cell for two bus bars; 39e-3*4 = .156 m = 15.6 cm
SC.rhoM = 3.2e-8;       % conductivity of metal Ohms-meter

SC.Jmpp=340;                          %current density active cell area A/m^2
SC.Vmpp=520e-3;                       %voltage at mpp V 


SC.rhoC = 0.5e-7;   % Ohm-m^2

SC.S = linspace(1e-4,5e-3, 200);
%SC.S = 2.5e-3;

%SCGA = SolarCellGridAnalysis(SC);

%SCGA= SCGA.calc_Pe;

powerLoss=zeros(nWidths, nAR) ;                %Define empty efficiency 
optimumSpacing=zeros(nWidths, nAR);             %and spacing matrices
powerLossOptical=zeros(nWidths, nAR);             %and spacing matrices
powerLossElectrical=zeros(nWidths, nAR); 

for i = 1:nWidths
  SC.Wf = widthArray(i); %120e-6;
  heightArray = SC.Wf*ARArray;
  for j = 1:nAR
    SC.Hf = heightArray(j);
    SCGA = SolarCellGridAnalysis(SC);
    SCGA= SCGA.calc_Pe;
    
    [minPloss, minInd] = min(SCGA.Ploss);
    minPloss
    powerLoss(i,j) = minPloss;
    optimumSpacing(i,j)=SCGA.S(minInd);
    powerLossOptical(i,j) = SCGA.Ps(minInd);
    powerLossElectrical(i,j) = SCGA.Pe(minInd);
  end
end

figure(1);
%[widthArrayMatrix,ARArrayMatrix] = meshgrid(widthArray,ARArray)
%[C, h] = contourf(widthArrayMatrix, ARArrayMatrix, powerLoss, 100); 
[C, h] = contourf(widthArray, ARArray, powerLoss', 100); 

colormap(flipud(parula));

shading flat;
set(h, 'edgecolor', 'none');
colorbar;
xlabel('Width (mm)');
ylabel('AR');

figure(2);
[widthArrayMatrix,ARArrayMatrix] = meshgrid(widthArray,ARArray)
[C, h] = contourf(widthArrayMatrix, ARArrayMatrix, powerLossOptical', 100); 
colormap(flipud(parula));
shading flat;
set(h, 'edgecolor', 'none');
colorbar;
xlabel('Width (mm)');
ylabel('AR');

figure(3);
[widthArrayMatrix,ARArrayMatrix] = meshgrid(widthArray,ARArray)
[C, h] = contourf(widthArrayMatrix, ARArrayMatrix, powerLossElectrical', 100); 
colormap(flipud(parula));
shading flat;
set(h, 'edgecolor', 'none');
colorbar;
xlabel('Width (mm)');
ylabel('AR');


