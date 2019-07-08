classdef ConeHoleArray < handle

%     properties
%         a; %pitch of the conehoel array;
%         n; %number of conehole per column - 1;
%     end
    properties(Dependent)
      ConeZSpan; % height of the cone         \m
      RTop;      % top radium of the cone     \m
      RBot;      % bottom radium of the cone    \m   
      ConeMaterial; % material of the cone     
      Volume;                                 %\m^3
%       X;            % x axis center of the cone
%       Y;            % y axis center of the cone
    end
    
%     properties
%       Cone;
%     end
%     

    properties(Access = 'private')
      Cone;
    end
  
  methods
    function obj = ConeHoleArray(ConezSpan, rtop, rbot)
      if nargin == 0
        obj.Cone = TruncatedConeHole;
      elseif nargin == 2
        obj.Cone = TruncatedConeHole(ConezSpan, rtop);
      elseif nargin == 3
        obj.Cone = TruncatedConeHole(ConezSpan, rtop, rbot);
      end
    end
    
%     
%      function X = get.X(obj)
%        X = obj.Cone.Properties.X;
%      end    
%      
%      function Y = get.Y(obj)
%        Y = obj.Cone.Properties.Y;
%      end    
     
     function ConeZSpan = get.ConeZSpan(obj)
       ConeZSpan = obj.Cone.Properties.ZSpanValue;
     end    
     
     function RTop = get.RTop(obj)
       RTop = obj.Cone.Properties.RTopValue;
     end
     
     function RBot = get.RBot(obj)
       RBot = obj.Cone.Properties.RBottomValue;
     end   
     
 
%      function set.X(obj, X)
%        obj.Cone.Properties.X= X;      
%      end    
%      
%      function set.Y(obj, Y)
%        obj.Cone.Properties.Y= Y;      
%      end   
     
     function ConeMaterial = get.ConeMaterial(obj)
       ConeMaterial = obj.Cone.Properties.MaterialValue;
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

   
     function set.ConeMaterial(obj, coneMaterial)
       obj.Cone.Properties.MaterialValue = coneMaterial;
     end


     function Volume = get.Volume(obj)
       Volume = obj.Cone.Properties.Volume;
     end

  end
  
  methods(Static)
    test();
    coneArray = create_withPitch(ConezSpan, rtop, rbot, a, n);
  end
  
end     

