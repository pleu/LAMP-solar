classdef OBJ_fitting_RsRsh
  
  properties
    
    Voltage;    % in Volts
    CurrentDark; % in Amps/m^2
    Area;
    I0;
    n;
    Rs;
    Rsh;
    J0;
    
  end
  
  properties(Hidden)

  end
  
  methods
    
    function iv = OBJ_fitting_RsRsh(voltage, currentDark, Area)
      if nargin > 0
        iv.Voltage = voltage;
        iv.CurrentDark = currentDark;
        iv.Area  = Area;
        iv = iv.Analyze;
      end
    end
    
  end
  
  methods(Hidden)
    
    function iv = Analyze(iv)
      if sum(iv.CurrentDark) == 0
%         iv.MinInd = nan;
%         iv.I0_guess = nan;
%         iv.n_guess = nan;
%         iv.Rs_guess = nan;
%         iv.Rsh_guess
      else
        %[~, iv.MinInd] = min(iv.Voltage);
        [iv.I0, iv.n, iv.Rs, iv.Rsh, iv.J0] = iv.fittingIV(iv.Voltage, iv.CurrentDark, iv.Area); 
      end
    end
    
  end
  
  methods(Static)
    
    function [I0, n, Rs, Rsh, J0] = fittingIV(voltage, current, Area)
      max_ind = length(current);
      min_ind = 1;
      offset = 5;
      
      Rs_guess = (voltage(max_ind)-voltage(max_ind-offset))/(current(max_ind)-current(max_ind-offset));
      Rsh_guess = (voltage(min_ind+offset)-voltage(min_ind))/(current(min_ind+offset)-current(min_ind));
      n_guess = 1000;
      I0_guess = abs(min(current));

      options = optimoptions(@lsqcurvefit,'StepTolerance', 1e-10,'MaxIter', 10000,'MaxFunEvals',10000, 'TolFun', 1e-9);
      F = @(x, voltage)ideal_diode_equation_Rsh(x, voltage);
      x0 = [I0_guess, n_guess, Rs_guess, Rsh_guess];
      lb = [0 0 0 0]; %eliminate negative and complex solutions
      ub = [1 50 1000 10000000];
      
      [x,resnorm,residual,exitflag,output] = lsqcurvefit(F,x0,voltage,current,lb,ub,options);
      
      I0 = x(1)
      J0 = x(1)/Area
      n = x(2)
      Rs = x(3)
      Rsh = x(4)
      exitflag
      
      
      
    end
    
  end
  
end
