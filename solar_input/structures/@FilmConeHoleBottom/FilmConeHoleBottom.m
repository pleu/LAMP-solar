% classdef FilmConeHoleBottom < FilmConeHoleTop
%   properties(Dependent)
%     ConeZ;
%   end
%   methods
%      function ConeZ = get.ConeZ(obj)
%        ConeZ = obj.Film.Geometry.ZSpan/2 - obj.Cone.Properties.ZSpanValue/2;
%      end
%   end
%   
%   methods(Static)
%     test();
%     filmConeHole = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, rtop, rbot);
%   end
% end
classdef FilmConeHoleBottom < handle
  
    properties(Dependent)
      ZSpan;     % thickness of the thin film \m
      XSpan;     % pitch of the cone          \m
      ConeZSpan; % height of the cone         \m
      RTop;      % top radium of the cone     \m
      RBot;      % bottom radium of the cone    \m 
      ConeZ;     % the position of the cone   \m
      FilmMaterial; % material of the film    
      ConeMaterial; % material of the cone     
      Volume;                                 %\m^3
      Area;                                   %\m^2 
      EquivalentThickness;                    %\m
    end
    
    properties(Access = 'private')
      Film;
      Cone;
    end
  
  methods
    function obj = FilmConeHoleBottom(zSpan, xSpan, ConezSpan, rtop, rbot)
      if nargin == 0
        obj.Film = RectangleFDTD;
        obj.Cone = TruncatedConeHole;
      elseif nargin == 4
        obj.Film = RectangleFDTD(zSpan, xSpan);
        obj.Cone = TruncatedConeHole(ConezSpan, rtop);
        obj.Cone.Properties.Z = obj.ConeZ;
      elseif nargin == 5
        obj.Film = RectangleFDTD(zSpan, xSpan);
        obj.Cone = TruncatedConeHole(ConezSpan, rtop, rbot);
        obj.Cone.Properties.Z = obj.ConeZ;
      end
    end
    
     function ZSpan = get.ZSpan(obj)
       ZSpan = obj.Film.Geometry.ZSpan;
     end    
     
     function XSpan = get.XSpan(obj)
       XSpan = obj.Film.Geometry.XSpan;
     end    
     
     function ConeZSpan = get.ConeZSpan(obj)
       ConeZSpan = obj.Cone.Properties.ZSpanValue;
     end    
     
     function RTop = get.RTop(obj)
       RTop = obj.Cone.Properties.RTopValue;
     end
     
     function RBot = get.RBot(obj)
       RBot = obj.Cone.Properties.RBottomValue;
     end   
     
     function ConeZ = get.ConeZ(obj)
       ConeZ = -obj.Film.Geometry.ZSpan/2 + obj.Cone.Properties.ZSpanValue/2;
     end

     function FilmMaterial = get.FilmMaterial(obj)
       FilmMaterial = obj.Film.Material.OpticalMaterial;
     end
     
     function ConeMaterial = get.ConeMaterial(obj)
       ConeMaterial = obj.Cone.Properties.MaterialValue;
     end
     
     function set.ZSpan(obj, zSpan)
       obj.Film.Geometry.ZSpan= zSpan;      
     end     
     
     function set.XSpan(obj, xSpan)
       obj.Film.Geometry.XSpan= xSpan;      
     end        
     
     function set.ConeZSpan(obj, ConezSpan)
       obj.Cone.Properties.ZSpanValue= ConezSpan;      
     end    
     
     function set.RTop(obj, rTop)
       obj.Cone.Properties.RTopValue= rTop;      
     end 
     
     function set.RBot(obj, rBot)
       obj.Cone.Properties.RBottomValue= rBot;      
     end  
     
     function set.FilmMaterial(obj, filmMaterial)
       obj.Film.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.ConeMaterial(obj, coneMaterial)
       obj.Cone.Properties.MaterialValue = coneMaterial;
     end
     
     function set.ConeZ(obj, coneZ)
       obj.Film.Geometry.ZSpan = -2*coneZ + obj.Cone.Properties.ZSpanValue;
     end
%      
%      function set.ConeZ(obj, coneZ)
%        obj.Cone.Properties.Z = coneZ;
%      end
     

     function Volume = get.Volume(obj)
       Volume = obj.Film.Geometry.Volume - obj.Cone.Properties.Volume;
     end
     
     function Area = get.Area(obj)
       Area = obj.Film.Geometry.Area;
     end
     
     function EquivalentThickness = get.EquivalentThickness(obj)
       EquivalentThickness = obj.Volume/obj.Area;
     end
     
  end
  
  methods(Static)
    test();
    filmConeHole = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, rtop, rbot);
  end
  
end     
