classdef FilmConeHoleArrayBoth < handle
  
%     properties
%       ZSpan;     % thickness of the thin film
%       XSpan;     % pitch of the cone
%       ConeZSpan; % height of the cone
%       RTop;      % top radium of the cone
%       RBot;      % bottom radium of the cone
% %       Film;
% %       Cone;
%     end
%     properties
%         ntop; %number of conehole per column - 1;
%         nbot; %number of conehole per column - 1;
%     end
    
    properties(Dependent)
      ZSpan;     % thickness of the thin film \m
      XSpan;     % pitch of the cone          \m
      TopConeZSpan; % height of the cone         \m
      TopRTop;      % top radium of the cone     \m
      TopRBot;      % bottom radium of the cone    \m 
      TopConeZ;     % the position of the cone   \m
      BotConeZSpan; % height of the cone         \m
      BotRTop;      % top radium of the cone     \m
      BotRBot;      % bottom radium of the cone    \m 
      BotConeZ;
      FilmMaterial; % material of the film    
      TopConeMaterial; % material of the cone     
      BotConeMaterial;
      Volume;                                 %\m^3
      Area;                                   %\m^2 
      EquivalentThickness;                    %\m
    end
    
    
    properties(Access = 'private')
      Film;
      TopConeArray;
      BotConeArray;
    end
  
  methods
    %function obj = FilmConeHoleArrayBoth(zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, ntop, BotConezSpan, Botrtop, Botrbot, nbot)
    function obj = FilmConeHoleArrayBoth(zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, BotConezSpan, Botrtop, Botrbot)        
      if nargin == 0
        obj.Film = RectangleFDTD;
        obj.TopConeArray = TruncatedConeHole;
        obj.BotConeArray = TruncatedConeHole;
%       elseif nargin == 4
%         obj.Film = RectangleFDTD(zSpan, xSpan);
%         obj.TopCone = TruncatedConeHole(TopConezSpan, Toprtop);
%         obj.TopCone.Properties.Z = obj.ConeZ;
      elseif nargin == 8
        obj.Film = RectangleFDTD(zSpan, xSpan);
        obj.TopConeArray = TruncatedConeHole(TopConezSpan, Toprtop, Toprbot);
        obj.TopConeArray.Properties.Z = obj.TopConeZ;
        obj.TopConeArray.Properties.X = -obj.XSpan/2;
        obj.TopConeArray.Properties.Y = -obj.XSpan/2;
        obj.BotConeArray = TruncatedConeHole(BotConezSpan, Botrtop, Botrbot);
        obj.BotConeArray.Properties.Z = obj.BotConeZ;
        obj.BotConeArray.Properties.X = -obj.XSpan/2;
        obj.BotConeArray.Properties.Y = -obj.XSpan/2;
%         obj.ntop = ntop;
%         obj.nbot = nbot; 
      end
    end
    
%      function ntop = get.ntop(obj)
%        ntop = obj.ntop;
%      end    
%     
%      function nbot = get.nbot(obj)
%        nbot = obj.nbot;
%      end
%      
     function ZSpan = get.ZSpan(obj)
       ZSpan = obj.Film.Geometry.ZSpan;
     end    
     
     function XSpan = get.XSpan(obj)
       XSpan = obj.Film.Geometry.XSpan;
     end    
     
     function TopConeZSpan = get.TopConeZSpan(obj)
       TopConeZSpan = obj.TopConeArray.Properties.ZSpanValue;
     end    
     
     function TopRTop = get.TopRTop(obj)
       TopRTop = obj.TopConeArray.Properties.RTopValue;
     end
     
     function TopRBot = get.TopRBot(obj)
       TopRBot = obj.TopConeArray.Properties.RBottomValue;
     end   
     
     function TopConeZ = get.TopConeZ(obj)
       TopConeZ = obj.Film.Geometry.ZSpan/2 - obj.TopConeArray.Properties.ZSpanValue/2;
     end

     function FilmMaterial = get.FilmMaterial(obj)
       FilmMaterial = obj.Film.Material.OpticalMaterial;
     end
     
     function TopConeMaterial = get.TopConeMaterial(obj)
       TopConeMaterial = obj.TopConeArry.Properties.MaterialValue;
     end
     
     function BotConeMaterial = get.BotConeMaterial(obj)
       BotConeMaterial = obj.BotConeArray.Properties.MaterialValue;
     end
     
     
     function set.ZSpan(obj, zSpan)
       obj.Film.Geometry.ZSpan= zSpan;      
     end     
     
     function set.XSpan(obj, xSpan)
       obj.Film.Geometry.XSpan= xSpan;      
     end        
     
     function set.TopConeZSpan(obj, TopConezSpan)
       obj.TopConeArray.Properties.ZSpanValue= TopConezSpan;      
     end    
     
     function set.TopRTop(obj, ToprTop)
       obj.TopConeArray.Properties.RTopValue= ToprTop;      
     end 
     
     function set.TopRBot(obj, ToprBot)
       obj.TopConeArray.Properties.RBottomValue= ToprBot;      
     end  

     function set.TopConeZ(obj, TopconeZ)
       obj.Film.Geometry.ZSpan = 2*TopconeZ + obj.TopConeArray.Properties.ZSpanValue;
     end
     
     function set.FilmMaterial(obj, filmMaterial)
       obj.Film.Material.OpticalMaterial = filmMaterial;
     end
     
     function set.TopConeMaterial(obj, topConeMaterial)
       obj.TopConeArray.Properties.MaterialValue = topConeMaterial;
     end
     
     function BotConeZSpan = get.BotConeZSpan(obj)
       BotConeZSpan = obj.BotConeArray.Properties.ZSpanValue;
     end    
     
     function BotRTop = get.BotRTop(obj)
       BotRTop = obj.BotConeArray.Properties.RTopValue;
     end
     
     function BotRBot = get.BotRBot(obj)
       BotRBot = obj.BotConeArray.Properties.RBottomValue;
     end   
     
     function BotConeZ = get.BotConeZ(obj)
       BotConeZ = -obj.Film.Geometry.ZSpan/2 + obj.BotConeArray.Properties.ZSpanValue/2;
     end    
     
     function set.BotConeZSpan(obj, BotConezSpan)
       obj.BotConeArray.Properties.ZSpanValue= BotConezSpan;      
     end    
     
     function set.BotRTop(obj, BotrTop)
       obj.BotConeArray.Properties.RTopValue= BotrTop;      
     end 
     
     function set.BotRBot(obj, BotrBot)
       obj.BotConeArray.Properties.RBottomValue= BotrBot;      
     end  

     function set.BotConeMaterial(obj, botConeMaterial)
       obj.BotConeArray.Properties.MaterialValue = botConeMaterial;
     end
     
%      function set.ConeZ(obj, coneZ)
%        obj.Cone.Properties.Z = coneZ;
%      end
     

     function Volume = get.Volume(obj)
       %Volume = obj.Film.Geometry.Volume - obj.TopConeArray.Properties.Volume*obj.ntop - obj.BotConeArray.Properties.Volume*obj.nbot;
       Volume = obj.Film.Geometry.Volume - obj.TopConeArray.Properties.Volume*obj.ntop - obj.BotConeArray.Properties.Volume*obj.nbot;       
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
    filmConeHoleArray = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, ntop, Botrtop, Botrbot, nbot);
  end
  
end     

%     function ConeZ = get.ConeZ(obj)
%       ConeZ = obj.Film.ZSpan/2 - obj.Cone.Properties.ZSpanValue;
%     end
    
%     function set.ConeZ(obj, Conez)
%       (obj.Film.ZSpan/2 - obj.Cone.Properties.ZSpanValue) = Conez;
%     end



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
    
%     function ConerTop = get.ConerTop(obj)
%       ConerTop = obj.Cone.Properties.RTopValue;
%     end
%     
%     function ConerBot = get.ConerBot(obj)
%       ConerBot = obj.Cone.Properties.RBottomValue;
%     end   
%     
%     function ConeArea = get.ConeArea(obj)
%       ConeArea = obj.Cone.Properties.Area;
%     end
%     
%     function ConeH = get.ConeH(obj)
%       ConeH = obj.Area*(obj.Film.Geometry.ZSpan - obj.EquivalentT)/obj.ConeArea;
%     end
%     
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
    
%     function Area = get.Area(obj)
%       Area = obj.Area;
%     end
%     
%     function Volume = get.Volume(obj)
%       Volume = obj.Area*obj.Film.Geometry.ZSpan - obj.Cone.Properties.Volume;
%     end
      
%     function EquivalentT = get.EquivalentT(obj)
%       EquivalentT = obj.Volume/obj.Area;
%     end
%     
    
