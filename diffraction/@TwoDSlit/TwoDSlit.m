classdef TwoDSlit < handle
  %ONEDSLIT Summary of this class goes here
  %   Detailed explanation goes here
   
  properties(Dependent)
    HoleWidth; % in nm
  end
  
  properties(Hidden)
    Dimensions = 2;
  end

  
  properties(Access = 'private')
    OneDSlitX; 
    OneDSlitY;
  end
  
  % store theta and normalized intensity
  
  methods
    function obj = TwoDSlit(holeWidth)
      obj.OneDSlitX = OneDSlit(holeWidth(1));
      obj.OneDSlitY = OneDSlit(holeWidth(2));
%      obj.Symmetry = '2D';
    end

    function holeWidth = get.HoleWidth(obj)
      holeWidth = [obj.OneDSlitX.HoleWidth; obj.OneDSlitY.HoleWidth];
    end


    function set.HoleWidth(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.OneDSlitX.HoleWidth = value;
      end
    end

    

    
  end
  
  methods(Static)
    test()
  end
  
end

