classdef FrequencyDomainField
%FrequencyDomainFieldPower Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    Geometry;
    DatatoRecord;
    Spectral;
    Advanced;
  end
  
  methods
    function obj = FrequencyDomainField()
      if nargin == 0
 %      Default values
        obj.General = FrequencyDomainFieldGeneralTab();
        obj.Geometry = GeometryTab();
        obj.DatatoRecord = DataToRecordTab();
        obj.Spectral = SpectralTab();
        obj.Advanced = AdvancedTab();
      end
    end
  end
  
  methods(Static) 
    test();
  end
  
end
