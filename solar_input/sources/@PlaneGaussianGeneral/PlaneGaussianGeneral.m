classdef PlaneGaussianGeneral < handle
  %PLANEGAUSSIANGENERAL Summary of this class goes here
  %   Detailed explanation goes here
  properties
    SourceShape;  % 1: Gaussian, 2: Plane-wave, 3: Cauchy-Lorentzian
    Amplitude;     
    Phase;       % degrees
    Direction;    % 1: backward, 2: forward
    AngleTheta;  % degrees
    AnglePhi;    % degrees
    PolarizationAngle; % degrees 
    
    Geometry;
  end
  
  properties(Dependent)
    InjectionAxis; % 1: x-axis, 2: y-axis, 3: z-axis
  end
  
  methods
    function obj = PlaneGaussianGeneral(varargin)
      if nargin == 0
        % Default values
        obj.SourceShape = 'Plane wave';
        obj.Amplitude = 1;
        obj.Phase = 0;
        obj.Direction = 'Forward';
        obj.AngleTheta = 0;
        obj.AnglePhi = 0;
        obj.PolarizationAngle = 0;   
        
        obj.Geometry = GeometryTab();
      end
    end
    
    function set.SourceShape(obj, sourceShape)
      options = {'Gaussian', 'Plane wave', 'Cauchy-Lorentzian'};
      obj.SourceShape = set_value_from_list(options, sourceShape);
    end    
    
    function set.InjectionAxis(obj, injectionAxis)
      obj.Geometry.InjectionAxis = injectionAxis;
    end    

    function injectionAxis = get.InjectionAxis(obj)
      injectionAxis = obj.Geometry.InjectionAxis;
    end
    
    function set.Direction(obj, direction)
      options = {'Forward', 'Backward'};
      obj.Direction = set_value_from_list(options, direction);
    end  
  end
end

