classdef PNJunction_darkIV < handle
% SolarCellIV class for solar cell
% Analyzes IV characteristics of a solar cell
% 
% Copyright 2012
% Paul Leu 
  properties
    Voltage;    % in Volts
    CurrentDark; % in Amps
    Area; % in m^2
  end
  
  properties(Hidden)
    VoltageFit;
    CurrentFit;
  end
  
  properties(SetAccess = private)
    I0; % current when voltage = 0
    Rs; % series resistance
    n;    % ideality factor
    Rsh;
  end
  
  properties(Dependent)
    J0;
  end
  
  
  methods
    
    function iv = PNJunction_darkIV(voltage, currentDark, area)  
      if nargin > 0
        [iv.Voltage, ind] = sort(voltage);
        iv.CurrentDark = currentDark(ind);
        iv.Area = area;
      end
    end
  
    function iv = fit(iv, equation)
      equationOptions = {'Rs', 'Rs_Rsh'};
      if nargin == 1
        equation = 'Rs';
      else
        check_option(equationOptions, equation);
      end
      current = iv.CurrentDark;
      voltage = iv.Voltage;

      if sum(iv.CurrentDark) == 0
        iv.MinInd = nan;
        iv.I0guess = nan;
        iv.Rs = nan;
        iv.n = nan;
      else
        % equation
        
        max_ind = length(current);
        min_ind = 1;
        offset = 5;
        
        Rs_guess = (voltage(max_ind)-voltage(max_ind-offset))/(current(max_ind)-current(max_ind-offset));
        Rsh_guess = (voltage(min_ind+offset)-voltage(min_ind))/(current(min_ind+offset)-current(min_ind));
        n_guess = 2; 
        I0_guess = abs(min(current));
        
        
        options = optimoptions(@lsqcurvefit,'StepTolerance', 1e-10,'MaxIter', 10000,'MaxFunEvals',10000, 'TolFun', 1e-9, 'Display', 'iter-detailed');
        
        if strcmp(equation, 'Rs')
          F = @(x, voltage)PNJunction_darkIV.ideal_diode_equation_Rs(x, voltage);
          x0 = [I0_guess, n_guess, Rs_guess];
          lb = [0 0 0]; %eliminate negative and complex solutions
          ub = [1 50 1000];
        elseif strcmp(equation, 'Rs_Rsh')
          F = @(x, voltage)PNJunction_darkIV.ideal_diode_equation_Rs_Rsh(x, voltage);
          x0 = [I0_guess, n_guess, Rs_guess, Rsh_guess];
          lb = [0 0 0 0]; %eliminate negative and complex solutions
          ub = [1 50 1000 10000000];
        end
        
        % plot initial guess
        voltageGuess = linspace(min(voltage), max(voltage));
        currentGuess = F(x0, voltageGuess);
        figure(1);
        clf;
        plot(voltage, current, 'b-', voltageGuess, currentGuess, 'ro');
        %
        
        
        [x,resnorm,residual,exitflag,output] = lsqcurvefit(F,x0,voltage,current,lb,ub,options);
        
        %if exitflag == 1
        iv.I0 = x(1);
        iv.n = x(2);
        iv.Rs = x(3);
        if strcmp(equation, 'Rs_Rsh')
          iv.Rsh = x(4);
        end
        
        iv.VoltageFit = linspace(min(voltage), max(voltage));
        iv.CurrentFit = F(x, iv.VoltageFit);
        
      end
      
    end

    
    function J0 = get.J0(obj)
      J0 = obj.I0/obj.Area;
    end
    
  end
  
  
  
    
  
  
  methods(Static)
          
    function Rs = calc_Rs(voltage, current)
      [~, ind] = max(voltage);
      indices = [ind-1, ind, ind+1];
      indices = indices(indices > 0 & indices <=length(voltage));
      Rs = mean(diff(voltage(indices))./diff(current(indices)));
    end
   
  
    
    function [current] = ideal_diode_equation_Rs(x, voltage)

      vThermal =  Constants.LightConstants.k_B*Constants.LightConstants.T_a; % Thermal Voltage; about .026 mV
      
      I0 = x(1);
      n = x(2);
      Rs = x(3);
      
      current = I0*(n*vThermal/(I0*Rs)*lambertw(I0*Rs/(n*vThermal)*exp((voltage+I0*Rs)/(n*vThermal)))-1);

    end
    
    
    function [current] = ideal_diode_equation_Rs_Rsh(x, voltage)

      vThermal =  Constants.LightConstants.k_B*Constants.LightConstants.T_a; % Thermal Voltage; about .026 mV

      I0 = x(1);
      n = x(2);
      Rs = x(3);
      Rsh = x(4);
      
      current = n*vThermal/Rs*lambertw(I0*Rs*Rsh/(n*vThermal*(Rsh+Rs))*exp((Rsh*(voltage+I0*Rs)/(n*vThermal*(Rsh+Rs)))))+((voltage-I0*Rsh)/(Rsh+Rs));
    end



    
%     function [VOC] = calc_VOC(voltage, current)
%        [~, ind] = min(abs(current));
%        indices = [ind-1 ind ind+1];
%        indices = indices(indices > 0 & indices <= length(current));
%        h = diff(current(indices));
%        if any(h == 0)
%          VOC = nan;
%        else
%          VOC = interp1(current(indices), voltage(indices), 0);       
%        end
%     end

    test()
    test2()
  end
  
end

