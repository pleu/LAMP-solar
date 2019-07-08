classdef OneDSlit < handle  % & DiffractionStructure
  %ONEDSLIT Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    HoleWidth@double; % in nm
    %OneDDiffractionPattern;
  end
  
  properties(Hidden)
    Dimensions = 1;
  end
  
  % store theta and normalized intensity
  
  methods
    function obj = OneDSlit(holeWidth)
      if nargin ~= 0
        %if length(holeWidth) > 1
          obj(length(holeWidth)) = OneDSlit;
          for i = 1:length(holeWidth)
            obj(i).HoleWidth = holeWidth(i);
          end
%         else
%           obj.HoleWidth = holeWidth;
%         end
      end
      %obj.Symmetry = '1D';
    end
    
    function set.HoleWidth(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.HoleWidth = value;
      end
    end

    
  end
  
  methods(Static)
    test()
%     function [objs] = create_array(holeWidths)
%       objs(length(holeWidths)) = OneDSlit(holeWidths(length(holeWidths));
%       for i = 1:length(holeWidths)
%         objs(i) = OneDSlit(holeWidth);
%       end
%     end
    
  end
  
end

