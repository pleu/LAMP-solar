classdef GaussianGeneralTab < PlaneGaussianGeneral
  %GENERAL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end

  methods
    function obj = GaussianGeneral()
      if nargin == 0
        % Default values
        obj.SourceShape = 'Gaussian';
      end
    end
  end

  methods(Static) 
    test();
  end
end

