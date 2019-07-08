classdef ElectricalFieldData
% MONITOR class for simulation monitor results
% 
% See also 
%
% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh
  properties
    Type;       % E2 or Pabs
    ElectricalIntensity;  % elctrical intensity  
    %Loss; % absorption per unit volume
    X; % the values of X coordinate
    Z; % the values of Z coordinate
    Geo; % the geometric parameters of nanowire
  end
  
  methods
    function obj = ElectricalFieldData(type, electricalintensity,x,z,geo)
      if nargin > 0
        obj.Type = type;
        obj.ElectricalIntensity = electricalintensity;
        obj.X = x;
        obj.Z= z;
        obj.Geo= geo;
      end
    end
    
    function obj = set.Type(obj,type)
      if ~(strcmpi(type,'E2') || ...
          strcmpi(type,'Pabs'))
        error('Type must be  E2 or Pabs');
      end
      obj.Type = type;
    end
    
    
  end
  
end