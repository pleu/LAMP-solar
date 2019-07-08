classdef FilmCylinder < handle
  properties
    Film;
    Cone;
    %SimulationCell;
%     FilmzMin;
%     FilmzSpan;
%    FilmzMax;
%     Conez;
    ConerTop;
    ConerBot;
    ConeArea;      %area of cone hole
%     ConezMin;
%     ConezMax;
    CheckError;
    Area;
    Volume;
    EquivalentT;
    ConeH;     %calculated height of the cone
  end
  
  properties(Dependent)
    FilmzMax;
    %ConezSpan;
  end
  
  methods
    function obj = FilmCylinder(EquivalentT)
      if nargin == 0
        obj.Film = RectangleFDTD;
        obj.Cone = TruncatedConeHole;
        %obj.SimulationCell = FDTD();
        obj.EquivalentT = 1000e-9;
      else
        obj.Film = RectangleFDTD;
        obj.Cone = TruncatedConeHole;
        %obj.SimulationCell = FDTD();
        obj.EquivalentT = EquivalentT;
      end
    end
    
%     function FilmzMin = get.FilmzMin(obj)
%       FilmzMin = obj.Film.Geometry.zMin;
%     end
    
%     function FilmzMax = get.FilmzMax(obj)
%       FilmzMax = obj.Film.Geometry.zMax;
%     end
    
%     function FilmzSpan = get.FilmzSpan(obj)
%       FilmzSpan = obj.Film.Geometry.ZSpan;
%     end
%     
%     function Conez = get.Conez(obj)
%       Conez = obj.Cone.Properties.z;
%     end
    
%     function ConezSpan = get.ConezSpan(obj)
%       ConezSpan = obj.Cone.Properties.zSPan;
%     end
    
    function ConerTop = get.ConerTop(obj)
      ConerTop = obj.Cone.Properties.RTopValue;
    end
    
    function ConerBot = get.ConerBot(obj)
      ConerBot = obj.Cone.Properties.RBottomValue;
    end   
    
    function ConeArea = get.ConeArea(obj)
      ConeArea = obj.Cone.Properties.Area;
    end
    
    function ConeH = get.ConeH(obj)
      ConeH = obj.Area*(obj.EquivalentT - obj.Film.Geometry.ZSpan)/obj.ConeArea;
    end
    
%     function ConezMin = get.ConezMin(obj)
%       ConezMin = obj.Conez - obj.ConezSpan/2;
%     end
%     
%     function ConezMax = get.ConezMax(obj)
%       ConezMax = obj.Conez + obj.ConezSpan/2;
%     end
    
%     function CheckError = get.CheckError(obj)
%       if obj.ConezMax ~= obj.FilmzMax || obj.ConezMin < obj.FilmzMin
%         CheckError = 1;
%         disp('PLEASE CHECK THE GEOMETRY!');
%       end
%     end
    
%     function set.FilmzMax(obj, filmzMax)
%       obj.Film.Geometry.zMax = filmzMax;
%       obj.Cone.Properties.zMax = filmzMax;
%     end
    
%     function set.ConezSpan(obj, conezSpan)
%       obj.Cone.Properties.zSpan = conezSpan;
%       obj.ConeH = conezSpan;
%     end
    
%     function set.ConezMax(obj, conezMax)
%       obj.Cone.Properties.zMax = conezMax;
%       obj.Film.Geometry.zMax = conezMax;
%     end
    
%     function Area = get.Area(obj)
%       Area = obj.SimulationCell.Geometry.Area;
%     end
    
    function Area = get.Area(obj)
      Area = obj.Area;
    end
    
    function Volume = get.Volume(obj)
      Volume = obj.Area*obj.Film.Geometry.ZSpan - obj.Cone.Properties.Volume;
    end
      
%     function EquivalentT = get.EquivalentT(obj)
%       EquivalentT = obj.Volume/obj.Area;
%     end
%     
    
  end
  
  methods(Static)
    test();
  end
end