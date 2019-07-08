classdef SolarCell
  %SOLARCELL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Acell;   % Cell area, m^2
    Lf;      % Finger length, m
    Wbuc;    % width busbar unit cell
    Wf;      % Finger width, m
    rhoC;    % contact resistivity, Ohm-m^2
    rhoM;    % metal resistivity, Ohm-m
    Rsh;     % sheet resistance, Ohm/sq
    Jmpp;    % current density at mpp
    Vmpp;    % voltage at mpp
  end
  
  methods
    
    function obj = SolarCellGridAnalysis()
      if nargin > 0
        if (size(frequency)== 1) ~= (size(data) ==1)
          data = data';
        end
  
        
        obj.Type = type;
        if size(frequency, 2) == 1
          obj.MonitorPhoton = ...
            Photon(Photon.ConvertFrequencyToWavelength(frequency'));
          obj.Data = data';
        else
          [frequency, ind] = sort(frequency);
          obj.MonitorPhoton = ...
            Photon(Photon.convert_frequency_to_wavelength(frequency));
          obj.Data = data(ind);
        end
      else
        obj.MonitorPhoton = ...
            Photon();
      end
    end
    
    
    tests
  end
  
end

