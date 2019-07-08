clear;

% this solves first example in Table 3.2
SC.NBusbars = 3;
SC.Wbuc= 1e-3;                 %width busbar (unit cell) m
%SC.Wbuc= 1e-3;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= .75e-3;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= 1.1e-3/2;                 %width busbar (unit cell) m; ; half the busbar width
%SC.Wbuc= 1e-4;                 %width busbar (unit cell) m; ; half the busbar width


%cellSide = .156;
SC.Lcell = .156;  % cell length in m

%SC.Acell = cellSide^2;
%Define model parms, zero means neglected
SC.A = SC.Lcell/(2*SC.NBusbars);            % length unit cell for five bus bars; .156/8 = 
%SC.A = 26e-3;            % length unit cell for three bus bars; 26e-3*6 = .156 m = 15.6 cm

SC.Lf=SC.A-SC.Wbuc;               %length finger m; Lf + Wbuc = A


%SC.Lf=25.3e-3;               %length finger m 



%Define loop + array constants:
hMin=1e-6;                           %Minimum aspect ratio; 
hMax=15e-6;                           %Maximum aspect ratio
nH=50;                              % number aspect ratio


wMin=10e-6;                          %Minimum width
wMax=120e-6;                         %Maximum width
nWidths = 50;    % number widths

hArray=linspace(hMin, hMax, nH);        %Aspect ratio vector
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

powerLoss=zeros(nWidths, nH) ;                %Define empty efficiency 
optimumSpacing=zeros(nWidths, nH);             %and spacing matrices
powerLossOptical=zeros(nWidths, nH);             %and spacing matrices
powerLossElectrical=zeros(nWidths, nH); 
powerLossOpticalBus = zeros(nWidths, nH);
for i = 1:nWidths
  SC.Wf = widthArray(i); %120e-6;
  %heightArray = SC.Wf*ARArray;
  for j = 1:nH
    SC.Hf = hArray(j);
    SCGA = SolarCellGridAnalysis(SC);
    SCGA= SCGA.calc_Pe;
    
    [minPloss, minInd] = min(SCGA.Ploss);
    %minPloss
    powerLossOpticalBus(i,j) = SCGA.PsBus(minInd);
    powerLoss(i,j) = minPloss;
    optimumSpacing(i,j)=SCGA.S(minInd);
    powerLossOptical(i,j) = SCGA.Ps(minInd);
    powerLossElectrical(i,j) = SCGA.Pe(minInd);
  end
end

[widthArrayMatrix,hArrayMatrix] = meshgrid(widthArray*1e6,hArray*1e6)

figure(1);
clf;
%[widthArrayMatrix,ARArrayMatrix] = meshgrid(widthArray,ARArray)
%[C, h] = contourf(widthArrayMatrix, ARArrayMatrix, powerLoss, 100); 
[C, h] = contourf(widthArrayMatrix, hArrayMatrix, powerLoss'*100, 100); 



colormap(flipud(parula));

shading flat;
set(h, 'edgecolor', 'none');


colorbar;
xlabel('Width (\mum)');
ylabel('Height (\mum)');
caxis('manual')

hold on
[C, h] = contour(widthArrayMatrix, hArrayMatrix, optimumSpacing*1e6)
clabel(C,h,'FontSize',18,'Color','black')

figure(2);
[C, h] = contourf(widthArrayMatrix, hArrayMatrix, powerLossOptical'*100, 100); 
colormap(flipud(parula));
shading flat;
set(h, 'edgecolor', 'none');
colorbar;
xlabel('Width (m)');
ylabel('Height');

figure(3);
%[widthArrayMatrix,hArrayMatrix] = meshgrid(widthArray,hArray)
[C, h] = contourf(widthArrayMatrix, hArrayMatrix, powerLossElectrical'*100, 100); 
colormap(flipud(parula));
shading flat;
set(h, 'edgecolor', 'none');
colorbar;
xlabel('Width (mm)');
ylabel('Height (m)');


interp2(widthArrayMatrix, hArrayMatrix, powerLoss*100', 120, 15)
interp2(widthArrayMatrix, hArrayMatrix, powerLossOptical*100', 120, 15)
interp2(widthArrayMatrix, hArrayMatrix, powerLossElectrical', 120, 15)

interp2(widthArrayMatrix, hArrayMatrix, powerLoss', 40, 15)
interp2(widthArrayMatrix, hArrayMatrix, powerLossOptical', 40, 15)
interp2(widthArrayMatrix, hArrayMatrix, powerLossElectrical', 40, 15)

%interp2(widthArrayMatrix, hArrayMatrix, powerLoss', 10, 10)


