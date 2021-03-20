classdef Module < handle
  %UNTITLED5 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Betas;    % slopes in degrees 
    BetaFractionFlag = 0; % if set to 1, then Betas is betaFraction;
    BetaFraction; 
    Gammas;   % surface azimuth angles in degrees  
    NormX; % module normal, size is numBeta x numGamma
    NormY; % module normal
    NormZ; % module normal
    
  end
  
  properties(Dependent)
    NumBetas;
    NumGammas;
  end
  
  
  properties(Dependent = true,Hidden)
    BetaRad; % slope in radians
    GammaRad; % surface azimuth angle in radians
  end
  
  methods
    function obj = Module(beta,gamma)
      %UNTITLED5 Construct an instance of this class
      %   Detailed explanation goes here
      obj.Betas = beta;
      obj.Gammas = gamma;
      obj = calc_module_normal(obj);
    end
    
    function numBetas = get.NumBetas(rb)
      numBetas = length(rb.Betas);
    end
    
    function numGammas = get.NumGammas(rb)
      numGammas = length(rb.Gammas);
    end
    
    function betaRad = get.BetaRad(obj)
      betaRad = deg2rad(obj.Betas);
    end
    
    function gammaRad = get.GammaRad(obj)
      gammaRad = deg2rad(obj.Gammas);
    end
    
    function [obj] = calc_module_normal(obj)
      [betaMat, gammaMat] = ndgrid(obj.BetaRad,obj.GammaRad); %
      [obj.NormX, obj.NormY, obj.NormZ] = sph2cart(gammaMat, pi/2-betaMat, 1);
    end
  end
  
  methods(Static)
    function [obj] = create_module_betaFraction(betaFraction, gamma)
      obj = Module([], gamma);
      obj.BetaFraction = betaFraction;
    end
    
    test()
    test2()
  end
end

