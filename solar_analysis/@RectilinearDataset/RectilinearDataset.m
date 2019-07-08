classdef RectilinearDataset < dynamicprops
  % ElectricalFieldResults class for Electrical Field Results
  % Input
  % rectilineardataset(x, y, z) creates empty rectilinear dataset
  % rectilineardataset("Name", x, y, z) creates empty rectilinear dataset

  % Copyright 2013
  % Paul Leu
  % LAMP, University Pittsburgh  
  properties
    Name;
    X;
    Y;
    Z;
  end
  
  methods    
    function obj = RectilinearDataset(varargin)
    % Constructor
      errorMsg = 'Error: the argument list for rectilinear dataset is incorrect';
      if nargin < 3
        error(errorMsg);
      elseif nargin == 3
        if ~isnumeric(varargin{1}) || ~isnumeric(varargin{2}) || ~isnumeric(varargin{3})
          error(errorMsg);
        end
        obj.X = varargin{1};
        obj.Y = varargin{2};
        obj.Z = varargin{3};
      elseif nargin == 4
        if ~ischar(varargin{1}) || ~isnumeric(varargin{2}) || ~isnumeric(varargin{3}) || ~isnumeric(varargin{4})
          error(errorMsg);
        end
        obj.X = varargin{2};
        obj.Y = varargin{3};
        obj.Z = varargin{4};
      end
    end
  end
  
  methods(Static) 
    test()
  end  
end

