classdef MaterialLayer
  %MATERIALLAYERS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    BandGap;
    VoltageM;
    CurrentM;
  end
  
  methods
    function obj = MaterialLayer(bandGap)
      if nargin ~= 0 
        m = size(bandGap, 1);
        n = size(bandGap, 2);
        obj(m, n) = MaterialLayer;
        for i = 1:m
          for j = 1:n
            obj(m, n).BandGap = bandGap;
          end
        end
      end
    end
  end
  
end

