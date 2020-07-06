classdef LightConstants  
  properties (Constant)
    Q = 1.60217646e-19; % Coulombs
    C = 2.99792458e8; % m/sec
    Cnm = 2.99792458e17; % nm/sec
    HC=1.239841716682783e+003;  % Planck constant times speed of light (eV-nm)
    T_a = 300;   % room Temperature
    T_c = 298.15; % standard cell testing temperature
    T_sun = 5760;
    H = 4.135666804142161e-15; %eV*sec; Planck constant
    Hbar = Constants.LightConstants.H/(2*pi); %eV*sec; reduced plack constant
    F_a = pi;  % geometric constant for hemisphere
    k_B = 8.617343e-5; % Botlzmann constant in eV/K
    a=600e-9; % The lattice constant of the nanowire arrays
    theta_s = 16/60*pi/180;
    F_s = pi*sin(Constants.LightConstants.theta_s)^2; % geometric constant for sun as seen from earth
    Z0 = 377; % free space impedance (in Ohms)
  end  
end

