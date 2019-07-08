classdef FrequencyDomainFieldPower
%FrequencyDomainFieldPower Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    Geometry;
    DataToRecord;
    Spectral;
    Advanced;
  end
  
  methods
    function obj = FrequencyDomainFieldPower()
      if nargin == 0
        % Default values
        obj.General = FrequencyDomainFieldPowerGeneralTab();
        obj.Geometry = GeometryMonitorTab();
        obj.DataToRecord = DataToRecordTab();
        obj.Spectral = SpectralTab();
        obj.Advanced = AdvancedMonitorTab();
      end
    end
  end
  
  methods(Static) 
    test();
  end
  
end
