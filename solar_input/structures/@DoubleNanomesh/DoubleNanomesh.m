classdef DoubleNanomesh < handle
% NANOHOLEOPTICALFILTER class defines hexagonal nanohole array for 
% optical filters
  
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
      ActiveFilmZSpan;     % thickness of the active thin film      \m
      TopFilmZSpan; % thickness of the top nanomesh                 \m
      BottomFilmZSpan; % thickness of the bottom nanomesh           \m
      XSpan;     % pitch of the mesh                                \m
      RTop;      % top radium of the cone                           \m
      RBot;      % bottom radium of the cone                        \m 
      Cone1ZSpan;
      Cone2ZSpan;
      Cone3ZSpan;
      Cone4ZSpan;
      Cone5ZSpan;
      Cone6ZSpan;
      Cone7ZSpan;
      Cone8ZSpan;
      Cone9ZSpan;
      TopFilmMaterial; % material of the top nanomesh    
      BottomFilmMaterial; % material of the bottom nanomesh
      ActiveFilmMaterial; % material of the active nanomesh
      ConeMaterial; % material of the cone     
    end
    
    properties(Access = 'private')
      TopFilm; % top metal nanomesh
      BottomFilm; % bottom metal nanomesh
      ActiveFilm; % active film, such as Si etc.
      Cone1;
      Cone2;
      Cone3;
      Cone4;
      Cone5; 
      Cone6;
      Cone7;
      Cone8;
      Cone9;
    end
  
   methods
    function obj = DoubleNanomesh(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, ySpan, rTop, rBottom)
      if nargin == 0
        obj.TopFilm = RectangleFDTD;
        obj.BottomFilm = RectangleFDTD;
        obj.ActiveFilm = RectangleFDTD;
        obj.Cone1 = TruncatedConeHole;
        obj.Cone2 = TruncatedConeHole;
        obj.Cone3 = TruncatedConeHole;
        obj.Cone4 = TruncatedConeHole;
        obj.Cone5 = TruncatedConeHole;
        obj.Cone6 = TruncatedConeHole;
        obj.Cone7 = TruncatedConeHole;
        obj.Cone8 = TruncatedConeHole;
        obj.Cone9 = TruncatedConeHole;
      elseif nargin == 7
        obj.TopFilm = RectangleFDTD(topFilmzSpan, xSpan, ySpan, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.BottomFilm = RectangleFDTD(bottomFilmzSpan, xSpan, ySpan, -activeFilmzSpan/2 - bottomFilmzSpan/2);
        obj.ActiveFilm = RectangleFDTD(activeFilmzSpan, xSpan, ySpan);
        obj.Cone1 = TruncatedConeHole(topFilmzSpan, rTop, 0, 0, rTop, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.Cone2 = TruncatedConeHole(topFilmzSpan, rTop, xSpan/2, ySpan/2, rTop, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.Cone3 = TruncatedConeHole(topFilmzSpan, rTop, -xSpan/2, ySpan/2, rTop, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.Cone4 = TruncatedConeHole(topFilmzSpan, rTop, xSpan/2, -ySpan/2, rTop, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.Cone5 = TruncatedConeHole(topFilmzSpan, rTop, -xSpan/2, -ySpan/2, rTop, activeFilmzSpan/2 + topFilmzSpan/2);
        obj.Cone6 = TruncatedConeHole(bottomFilmzSpan, rBottom, xSpan/2, 0, rBottom, -activeFilmzSpan/2 - bottomFilmzSpan/2);
        obj.Cone7 = TruncatedConeHole(bottomFilmzSpan, rBottom, -xSpan/2, 0, rBottom, -activeFilmzSpan/2 - bottomFilmzSpan/2);
        obj.Cone8 = TruncatedConeHole(bottomFilmzSpan, rBottom, 0, -ySpan/2, rBottom, -activeFilmzSpan/2 - bottomFilmzSpan/2);
        obj.Cone9 = TruncatedConeHole(bottomFilmzSpan, rBottom, 0, ySpan/2, rBottom, -activeFilmzSpan/2 - bottomFilmzSpan/2);
%         obj.Cone1.Properties.Z = obj.ConeZ;
%         obj.Cone2.Properties.Z = obj.ConeZ;
%         obj.Cone3.Properties.Z = obj.ConeZ;
%         obj.Cone4.Properties.Z = obj.ConeZ;
%         obj.Cone5.Properties.Z = obj.ConeZ;
      end
    end
    
     function ActiveFilmZSpan = get.ActiveFilmZSpan(obj)
       ActiveFilmZSpan = obj.ActiveFilm.Geometry.ZSpan;
     end
     
     function TopFilmZSpan = get.TopFilmZSpan(obj)
       TopFilmZSpan = obj.TopFilm.Geometry.ZSpan;
     end
     
     function BottomFilmZSpan = get.BottomFilmZSpan(obj)
       BottomFilmZSpan = obj.BottomFilm.Geometry.ZSpan;
     end    
     
     function XSpan = get.XSpan(obj)
       XSpan = obj.BottomFilm.Geometry.XSpan;
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
     
     function Cone6ZSpan = get.Cone6ZSpan(obj)
       Cone6ZSpan = obj.Cone6.Properties.ZSpanValue;
     end
     
     function Cone7ZSpan = get.Cone7ZSpan(obj)
       Cone7ZSpan = obj.Cone7.Properties.ZSpanValue;
     end
     
     function Cone8ZSpan = get.Cone8ZSpan(obj)
       Cone8ZSpan = obj.Cone8.Properties.ZSpanValue;
     end
     
     function Cone9ZSpan = get.Cone9ZSpan(obj)
       Cone9ZSpan = obj.Cone9.Properties.ZSpanValue;
     end
     
     function RTop = get.RTop(obj)
       RTop = obj.Cone1.Properties.RTopValue;
     end
     
     function RBot = get.RBot(obj)
       RBot = obj.Cone6.Properties.RTopValue;
     end
     
     
%      function RBot = get.RBot(obj)
%        RBot = obj.Cone1.Properties.RBottomValue;
%      end  
     
%      function Diameter = get.Radius(obj)
%        Diameter = obj.Cone.Properties.Radius;
%      end
     
%      function ConeZ = get.ConeZ(obj)
%        ConeZ = 0;
%      end

     function ActiveFilmMaterial = get.ActiveFilmMaterial(obj)
       ActiveFilmMaterial = obj.ActiveFilm.Material.OpticalMaterial;
     end
     
     function TopFilmMaterial = get.TopFilmMaterial(obj)
      TopFilmMaterial = obj.TopFilm.Material.OpticalMaterial;
     end
     
     function BottomFilmMaterial = get.BottomFilmMaterial(obj)
       BottomFilmMaterial = obj.BottomFilm.Material.OpticalMaterial;
     end
     
     function HoleMaterial = get.ConeMaterial(obj)
       HoleMaterial = obj.Cone1.Properties.MaterialValue;
     end
     
     function set.ActiveFilmZSpan(obj, activeFilmzSpan)
       obj.ActiveFilm.Geometry.ZSpan= activeFilmzSpan;      
     end
     
     function set.TopFilmZSpan(obj, topFilmzSpan)
       obj.TopFilm.Geometry.ZSpan= topFilmzSpan;      
     end
     
     function set.BottomFilmZSpan(obj, bottomFilmzSpan)
       obj.BottomFilm.Geometry.ZSpan= bottomFilmzSpan;      
     end     
     
     function set.XSpan(obj, xSpan)
       obj.ActiveFilm.Geometry.XSpan= xSpan; 
       obj.TopFilm.Geometry.XSpan= xSpan; 
       obj.BottomFilm.Geometry.XSpan= xSpan;      
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
     
     function set.Cone6ZSpan(obj, zSpan)
       obj.Cone6.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone7ZSpan(obj, zSpan)
       obj.Cone7.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone8ZSpan(obj, zSpan)
       obj.Cone8.Properties.ZSpanValue= zSpan;      
     end
     
     function set.Cone9ZSpan(obj, zSpan)
       obj.Cone9.Properties.ZSpanValue= zSpan;      
     end
     
     function set.RTop(obj, rTop)
       obj.Cone1.Properties.RTopValue= rTop;      
       obj.Cone2.Properties.RTopValue= rTop;      
       obj.Cone3.Properties.RTopValue= rTop;      
       obj.Cone4.Properties.RTopValue= rTop;      
       obj.Cone5.Properties.RTopValue= rTop;      
     end
     
     function set.RBot(obj, rBot)
       obj.Cone1.Properties.RBotValue= rBot;      
       obj.Cone2.Properties.RBotValue= rBot;      
       obj.Cone3.Properties.RBotValue= rBot;      
       obj.Cone4.Properties.RBotValue= rBot;      
       obj.Cone5.Properties.RBotValue= rBot;      
     end 
     
%      function set.RBot(obj, rBot)
%        obj.Cone1.Properties.RBottomValue= rBot;      
%        obj.Cone2.Properties.RBottomValue= rBot;      
%        obj.Cone3.Properties.RBottomValue= rBot;      
%        obj.Cone4.Properties.RBottomValue= rBot;      
%        obj.Cone5.Properties.RBottomValue= rBot;      
%      end  

%      function set.Radius(obj, radius)
%        obj.Hole.Properties.Radius = radius;
%      end
     
     function set.ActiveFilmMaterial(obj, filmMaterial)
       obj.ActiveFilm.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.TopFilmMaterial(obj, filmMaterial)
       obj.TopFilm.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.BottomFilmMaterial(obj, filmMaterial)
       obj.BottomFilm.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.ConeMaterial(obj, holeMaterial)
       obj.Cone1.Properties.MaterialValue = holeMaterial;
       obj.Cone2.Properties.MaterialValue = holeMaterial;
       obj.Cone3.Properties.MaterialValue = holeMaterial;
       obj.Cone4.Properties.MaterialValue = holeMaterial;
       obj.Cone5.Properties.MaterialValue = holeMaterial;
       obj.Cone6.Properties.MaterialValue = holeMaterial;
       obj.Cone7.Properties.MaterialValue = holeMaterial;
       obj.Cone8.Properties.MaterialValue = holeMaterial;
       obj.Cone9.Properties.MaterialValue = holeMaterial;
     end
     
%      function set.ConeZ(obj, coneZ)
%        obj.Cone1.Properties.HoleZ = 0;
%        obj.Cone2.Properties.HoleZ = 0;
%        obj.Cone3.Properties.HoleZ = 0;
%        obj.Cone4.Properties.HoleZ = 0;
%        obj.Cone5.Properties.HoleZ = 0;
%      end
     

     
  end
  
  methods(Static)
    test();
    doubleNanomesh = create(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, rTop, rBottom);
  end
end