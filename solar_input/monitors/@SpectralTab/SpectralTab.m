classdef SpectralTab < handle & matlab.System
    
    properties
        Delta;
        Apodization;
        ApodizationCenter;    % in fs
        ApodizationTimeWidth; % in fs
        % ApodizationFrequencyWidth; % need to figure out; seems like
        % 441.271/(time width)
    end
    
    properties (Dependent)
        
    end
    
    methods(Access = protected)
        function flag = isInactivePropertyImpl(obj, propertyName)
          if getnameidx({'Apodization','Delta'}, propertyName)
            flag = false;
          else
            if getnameidx({'Full', 'Start', 'End'}, obj.Apodization)
              if getnameidx({'ApodizationCenter', 'ApodizationTimeWidth'}, propertyName)
                flag = false;
              else
                flag = true;
              end
            else
              flag = true;
            end
          end
        end        
    end
    
    methods
        function obj = SpectralTab(apodizationCenter, apodizationTimeWidth)
            if nargin == 0
                obj.Delta = 10e12; % in THz
                obj.Apodization = 'None';
                obj.ApodizationCenter = 500e-15; % in fs
                obj.ApodizationTimeWidth = 100e-15; % in fs
            else
                obj.Delta = 10e12; % in THz
                obj.Apodization = 'None';
                obj.ApodizationCenter = apodizationCenter; % in fs
                obj.ApodizationTimeWidth = apodizationTimeWidth; % in fs                
            end
        end
        
        function set.Apodization(obj, apodization)
            options = {'None', 'Full', 'Start', 'End'};
            obj.Apodization = set_value_from_list(options, apodization);
        end    
    end
    
    methods(Static)
        test();
    end
end
