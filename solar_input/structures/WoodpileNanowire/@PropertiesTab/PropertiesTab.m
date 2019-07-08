classdef PropertiesTab < handle

  properties
    Radius;  % radius of the nanohole
    Pitch;   % pitch of the nanohole
    NLayer;  % number of layer of the photonic crystal
    Material;
    Thickness; % thickness of the photonic cyrstal
    Center;
    Volume; % volume of all the nanohole
  end

  % Maybe we need to create a new function which we can use to create
  % objects (like index, material...) in properties tab and edit the
  % types and value of them. 

  methods
    function obj = PropertiesTab(Radius, Pitch, NLayer)
      if nargin == 0
        obj.Radius = 500e-9;
        obj.Pitch = 1500e-9;
        obj.NLayer = 1;
        obj.Material = 'etch';
      elseif nargin == 2
        obj.Radius = Radius;
        obj.Pitch = Pitch;
        obj.NLayer = 1;
        obj.Material = 'etch';
      elseif nargin == 3
        obj.Radius = Radius;
        obj.Pitch = Pitch;
        obj.NLayer = NLayer;
        obj.Material = 'etch';
      end
    end
     
    function Thickness = get.Thickness(obj)
      Thickness = 8*obj.NLayer*obj.Radius;
    end
    
    function Center = get.Center(obj)
        Center = obj.Thickness/2;
    end
    
    function Volume = get.Volume(obj)
      Volume = 4*obj.NLayer*pi*obj.Radius^2*obj.Pitch;
    end

  end
    
  methods(Static)
    test();
  end
end