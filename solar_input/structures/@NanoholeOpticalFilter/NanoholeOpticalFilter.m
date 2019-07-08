classdef NanoholeOpticalFilter < handle
  
%     properties
%       ZSpan;     % thickness of the thin film
%       XSpan;     % pitch of the cone
%       ConeZSpan; % height of the cone
%       RTop;      % top radium of the cone
%       RBot;      % bottom radium of the cone
% %       Film;
% %       Cone;
%     end

  
    properties(Dependent)
      ZSpan;     % thickness of the thin film \m
      XSpan;     % pitch of the cone          \m
      RTop;      % top radium of the cone     \m
      RBot;      % bottom radium of the cone    \m 
%       Radius;  % diameter of the hole      \m
      ConeZ;     % the position of the cone   \m'
      Cone1ZSpan;
      Cone2ZSpan;
      Cone3ZSpan;
      Cone4ZSpan;
      Cone5ZSpan;
      FilmMaterial; % material of the film    
      ConeMaterial; % material of the cone     
    end
    
    properties(Access = 'private')
      Film;
      Cone1;
      Cone2;
      Cone3;
      Cone4;
      Cone5;
    end
  
   methods
    function obj = NanoholeOpticalFilter(zSpan, xSpan, ySpan, rTop, rBot)
      if nargin == 0
        obj.Film = RectangleFDTD;
        obj.Cone1 = TruncatedConeHole;
        obj.Cone2 = TruncatedConeHole;
        obj.Cone3 = TruncatedConeHole;
        obj.Cone4 = TruncatedConeHole;
        obj.Cone5 = TruncatedConeHole;
      elseif nargin == 5
        obj.Film = RectangleFDTD(zSpan, xSpan, ySpan);
        obj.Cone1 = TruncatedConeHole(zSpan, rTop, rBot);
        obj.Cone2 = TruncatedConeHole(zSpan, rTop, rBot, xSpan/2, ySpan/2);
        obj.Cone3 = TruncatedConeHole(zSpan, rTop, rBot, -xSpan/2, ySpan/2);
        obj.Cone4 = TruncatedConeHole(zSpan, rTop, rBot, xSpan/2, -ySpan/2);
        obj.Cone5 = TruncatedConeHole(zSpan, rTop, rBot, -xSpan/2, -ySpan/2);
        obj.Cone1.Properties.Z = obj.ConeZ;
        obj.Cone2.Properties.Z = obj.ConeZ;
        obj.Cone3.Properties.Z = obj.ConeZ;
        obj.Cone4.Properties.Z = obj.ConeZ;
        obj.Cone5.Properties.Z = obj.ConeZ;
      end
    end
    
     function ZSpan = get.ZSpan(obj)
       ZSpan = obj.Film.Geometry.ZSpan;
     end    
     
     function XSpan = get.XSpan(obj)
       XSpan = obj.Film.Geometry.XSpan;
     end    
     
     function Cone1ZSpan = get.Cone1ZSpan(obj)
       Cone1ZSpan = obj.Cone1.Properties.ZSpanValue;
     end
     
     function Cone2ZSpan = get.Cone2ZSpan(obj)
       Cone2ZSpan = obj.Cone2.Properties.ZSpanValue;
     end
     
     function Cone3ZSpan = get.Cone3ZSpan(obj)
       Cone3ZSpan = obj.Cone3.Properties.ZSpanValue;
     end
     
     function Cone4ZSpan = get.Cone4ZSpan(obj)
       Cone4ZSpan = obj.Cone4.Properties.ZSpanValue;
     end
     
     function Cone5ZSpan = get.Cone5ZSpan(obj)
       Cone5ZSpan = obj.Cone5.Properties.ZSpanValue;
     end  
     
     function RTop = get.RTop(obj)
       RTop = obj.Cone1.Properties.RTopValue;
     end
     
     function RBot = get.RBot(obj)
       RBot = obj.Cone1.Properties.RBottomValue;
     end  
     
%      function Diameter = get.Radius(obj)
%        Diameter = obj.Cone.Properties.Radius;
%      end
     
     function ConeZ = get.ConeZ(obj)
       ConeZ = 0;
     end

     function FilmMaterial = get.FilmMaterial(obj)
       FilmMaterial = obj.Film.Material.OpticalMaterial;
     end
     
     function HoleMaterial = get.ConeMaterial(obj)
       HoleMaterial = obj.Cone1.Properties.MaterialValue;
     end
     
     function set.ZSpan(obj, zSpan)
       obj.Film.Geometry.ZSpan= zSpan;      
     end     
     
     function set.XSpan(obj, xSpan)
       obj.Film.Geometry.XSpan= xSpan;      
     end        
     
     function set.Cone1ZSpan(obj, zSpan)
       obj.Cone1.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone2ZSpan(obj, zSpan)
       obj.Cone2.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone3ZSpan(obj, zSpan)
       obj.Cone3.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone4ZSpan(obj, zSpan)
       obj.Cone4.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone5ZSpan(obj, zSpan)
       obj.Cone5.Properties.ZSpanValue= zSpan;      
     end
     
     function set.RTop(obj, rTop)
       obj.Cone1.Properties.RTopValue= rTop;      
       obj.Cone2.Properties.RTopValue= rTop;      
       obj.Cone3.Properties.RTopValue= rTop;      
       obj.Cone4.Properties.RTopValue= rTop;      
       obj.Cone5.Properties.RTopValue= rTop;      
     end 
     
     function set.RBot(obj, rBot)
       obj.Cone1.Properties.RBottomValue= rBot;      
       obj.Cone2.Properties.RBottomValue= rBot;      
       obj.Cone3.Properties.RBottomValue= rBot;      
       obj.Cone4.Properties.RBottomValue= rBot;      
       obj.Cone5.Properties.RBottomValue= rBot;      
     end  

%      function set.Radius(obj, radius)
%        obj.Hole.Properties.Radius = radius;
%      end
     
     function set.FilmMaterial(obj, filmMaterial)
       obj.Film.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.ConeMaterial(obj, holeMaterial)
       obj.Cone1.Properties.MaterialValue = holeMaterial;
       obj.Cone2.Properties.MaterialValue = holeMaterial;
       obj.Cone3.Properties.MaterialValue = holeMaterial;
       obj.Cone4.Properties.MaterialValue = holeMaterial;
       obj.Cone5.Properties.MaterialValue = holeMaterial;
     end
     
     function set.ConeZ(obj, coneZ)
       obj.Cone1.Properties.HoleZ = 0;
       obj.Cone2.Properties.HoleZ = 0;
       obj.Cone3.Properties.HoleZ = 0;
       obj.Cone4.Properties.HoleZ = 0;
       obj.Cone5.Properties.HoleZ = 0;
     end
     

     
  end
  
  methods(Static)
    test();
    opticalFilter = create(zSpan, xSpan, ySpan, rTop, rBot);
  end
end