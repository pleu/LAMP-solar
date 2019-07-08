classdef FilmCone < handle
  properties
    Film;
    Cone;
    FilmzMin;
%    FilmzMax;
%     ConerTop;
%     ConerBot;
    ConezSpan;
    Conez;
    ConezMax;
    CheckError;
    Area;
    Volume;
    EquivalentT;
  end
  
  properties(Dependent)
    ConezMin;
    FilmzMax;
  end
  
  methods
    function obj = FilmCone(varargin)
      if nargin == 0
        obj.Film = RectangleFDTD;
        obj.Cone = TruncatedCone;
      end
    end
    
    function FilmzMin = get.FilmzMin(obj)
      FilmzMin = obj.Film.Geometry.zMin;
    end
    
    function FilmzMax = get.FilmzMax(obj)
      FilmzMax = obj.Film.Geometry.zMax;
    end
    
    function Conez = get.Conez(obj)
      Conez = obj.Cone.Properties.z;
    end
    
    function ConezSpan = get.ConezSpan(obj)
      ConezSpan = obj.Cone.Properties.zSPan;
    end
    
    function ConezMin = get.ConezMin(obj)
      ConezMin = obj.Conez - obj.ConezSpan/2;
    end
    
    function ConezMax = get.ConezMax(obj)
      ConezMax = obj.Conez + obj.ConezSpan/2;
    end    
    
    function CheckError = get.CheckError(obj)
      if obj.ConezMin ~= obj.FilmzMax 
        CheckError = 1;
        disp('PLEASE CHECK THE GEOMETRY!');
      end
    end
    
    function set.FilmzMax(obj, filmzMax)
      obj.Film.Geometry.zMax = filmzMax;
      obj.Cone.Properties.zMin = filmzMax;
    end
    
    function set.ConezMin(obj, conezMin)
      obj.Cone.Properties.zMin = conezMin;
      obj.Film.Geometry.zMax = conezMin;
    end
    
    function Area = get.Area(obj)
      Area = obj.Film.Geometry.Area;
    end
    
    function Volume = get.Volume(obj)
      Volume = obj.Film.Geometry.Volume + obj.Cone.Properties.Volume;
    end
      
    function EquivalentT = get.EquivalentT(obj)
      EquivalentT = calculate_EquivalentT(obj.Volume, obj.Area);
    end
    
    
  end
  
  methods(Static)
    test();
  end
end