clear;
A = [1 2; 3 4; 5 6];
B = [1 2; 3 4; 5 7];
%A(:, :, 2) = [1 1; 1 1; 1 1];

%B = [1 2; 3 4; 5 6];
%B(:, :, 2) = [0 0; 0 0; 0 0];



y = linspaceNDim(A, B, 10); 

% new dimensions is always between 0 and 1


omega = linspace(0, 3*pi/4, 10);
%days = linspace(0, 365, 10);

days = [0 10 20 30 40 50 60 70 80 90];

%[omegaMat, daysMat] = ndgrid(omega, days);

%omega = omega_s.*linspace(0, 1, numOmega);



