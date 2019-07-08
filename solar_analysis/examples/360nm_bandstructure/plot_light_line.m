function [] = plot_light_line(kx)
% PLOTLIGHTLINE
% plot the light line
% input kx is the value of the unit of vector k
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh

X_point=kx; % x value of point X
M_point=2*kx; % x value of point M
length_M_Gamma=sqrt(2)*kx;
Gamma_point=M_point+length_M_Gamma; % x value of point Gamma 
Gamma_X=linspace(0,X_point); % vecotr from point Gamma to point X
lightline_G_X=Gamma_X; % light line section of from point Gamma to point X
X_M=linspace(X_point,M_point); % vector from point X to point M
lightline_X_M=sqrt(X_M.*X_M-X_M+kx); % light line section of from  point X to point M
M_Gamma=[M_point Gamma_point]; % vector from point M to point Gamma
lightline_M_G=[length_M_Gamma 0]; % light line section of from  point M to point Gamma
plot(Gamma_X,lightline_G_X);
hold on;
plot(X_M, lightline_X_M);
plot(M_Gamma, lightline_M_G);
gtext('Lightline');
axis([0 Gamma_point 0 1]);
set(gca,'XTick',[0 X_point M_point Gamma_point]);

