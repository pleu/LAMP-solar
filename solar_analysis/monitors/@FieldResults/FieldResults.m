classdef FieldResults < handle
  %FieldResults Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    X;
    Y;
    Z;
    OutputObj;
  end
  
  properties(Hidden = true)
    PhotonObj;
  end
    
  properties(Dependent)
    Wavelength;
  end
    
  methods
    function obj = FieldResults(x, y, z, f, output)
      obj.X = x;
      obj.Y = y;
      obj.Z = z;
      obj.PhotonObj = Photon(Photon.ConvertFrequencyToWavelength(f));
      obj.OutputObj = output;
    end
    
    function wavelength = get.Wavelength(obj)
      wavelength = obj.PhotonObj.Wavelength;
    end
    
    function set.Wavelength(obj, wavelength)
      obj.PhotonObj.Wavelength = wavelength;
    end
    
  end
  
  methods(Static) 
    function obj = create_vector(filename, vectorFieldSuffix)
      load([filename, 'X.mat']);
      load([filename, 'Y.mat']);
      load([filename, 'Z.mat']);
      load([filename, 'f.mat']);
      vec = VectorField.create([filename, vectorFieldSuffix]);
      obj = FieldResults(x, y, z, f, vec);
    end
    
    function obj = create_scalar(filename, scalarFieldSuffix)
      load([filename, 'X.mat']);
      load([filename, 'Y.mat']);
      load([filename, 'Z.mat']);
      load([filename, 'f.mat']);
      scalar = ScalarField.create([filename, scalarFieldSuffix]);
      if (strfind(filename,'Total') == [])
        obj = FieldResults(x, y, z, f, scalar);
      else
        obj = FieldResults(x_tot, y_tot, z_tot, f_tot, scalar);
      end
    end

  end
  
end

