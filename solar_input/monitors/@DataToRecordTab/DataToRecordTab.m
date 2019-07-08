classdef DataToRecordTab < handle    
    properties
        StandardFourierTransform;
        PartialSpectralAverage;
        TotalSpectralAverage;
        OutputEx;
        OutputEy;
        OutputEz;
        OutputHx;
        OutputHy;
        OutputHz;
        OutputPx;
        OutputPy;
        OutputPz;
        OutputPower;
    end
    
    methods
        function obj = DataToRecordTab(varargin)
            if nargin == 0;
                obj.StandardFourierTransform = 1;
                obj.PartialSpectralAverage = 0;
                obj.TotalSpectralAverage =0;
                obj.OutputEx = 1;
                obj.OutputEy = 1;
                obj.OutputEz = 1;
                obj.OutputHx = 1;
                obj.OutputHy = 1;
                obj.OutputHz = 1;
                obj.OutputPx = 0;
                obj.OutputPy = 0;
                obj.OutputPz = 0;
                obj.OutputPower = 1;   
            end
        end
        
        function set.StandardFourierTransform(obj, standardFourierTransform)
          obj.StandardFourierTransform = set_check_box(standardFourierTransform);
        end
        
        function set.PartialSpectralAverage(obj, partialSpectralAverage)
          obj.PartialSpectralAverage = set_check_box(partialSpectralAverage);
        end
        
        function set.TotalSpectralAverage(obj, totalSpectralAverage)
          obj.TotalSpectralAverage = set_check_box(totalSpectralAverage);
        end
        
        function set.OutputEx(obj, outputEx)
          obj.OutputEx = set_check_box( outputEx);
        end 

        function set.OutputEy(obj, outputEy)
          obj.OutputEy = set_check_box(outputEy);
        end 
        
        function set.OutputEz(obj, outputEz)
          obj.OutputEz = set_check_box(outputEz);
        end 
        
        function set.OutputHx(obj, outputHx)
          obj.OutputHx = set_check_box(outputHx);
        end 
        
        function set.OutputHy(obj, outputHy)
          obj.OutputHy = set_check_box(outputHy);
        end 
        
        function set.OutputHz(obj, outputHz)
          obj.OutputHz = set_check_box(outputHz);
        end 
        
        function set.OutputPx(obj, outputPx)
          obj.OutputPx = set_check_box(outputPx);
        end 
        
        function set.OutputPy(obj, outputPy)
          obj.OutputPy = set_check_box(outputPy);
        end 
        
        function set.OutputPz(obj, outputPz)
          obj.OutputPz = set_check_box(outputPz);
        end 
        
        function set.OutputPower(obj, outputPower)
          obj.OutputPower = set_check_box(outputPower);
        end         
        
    end
    
        
    
    methods(Static)
        test();
    end
end