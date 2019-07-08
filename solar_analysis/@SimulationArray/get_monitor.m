function [monitor, monitorType] = get_monitor(sa, monitorType)

if strcmpi(monitorType, 'transmissionTotal')
  monitor = [sa.Simulations.TransmissionTotal];
  monitorType = 'TransmissionTotal';
elseif strcmpi(monitorType, 'haze')
  monitor = [sa.Simulations.Haze];
  monitorType = 'Haze';
elseif strncmpi(monitorType, 'r', 1)
  monitor = [sa.Simulations.ReflectionResults];
  monitorType = 'Reflection';
elseif strncmpi(monitorType, 't', 1)
  monitor = [sa.Simulations.TransmissionResults];
  monitorType = 'Transmission';
elseif strncmpi(monitorType, 'a', 1)
  monitor = [sa.Simulations.AbsorptionResults];
  monitorType = 'Absorption';
else
  error('monitor type not recognized');
end


%   monitor = Monitor.empty(sa.NumSimulations, 0);
%   if strncmpi(monitorType, 'r', 1)
%     for i = 1:sa.NumSimulations
%       monitor(i) = sa.FDTDSimulations(i).ReflectionResults;
%       monitorType = 'Reflection';
%     end    
%   elseif strncmpi(monitorType, 't', 1)
%     for i = 1:sa.NumSimulations
%       monitor(i) = sa.FDTDSimulations(i).TransmissionResults;
%       monitorType = 'Transmission';
%     end
%   elseif strncmpi(monitorType, 'a', 1)
%     for i = 1:sa.NumSimulations
%       monitor(i) = sa.FDTDSimulations(i).AbsorptionResults;
%       monitorType = 'Absorption';
%     end
%   else
%     error('monitor type not recognized');
%   end
end


