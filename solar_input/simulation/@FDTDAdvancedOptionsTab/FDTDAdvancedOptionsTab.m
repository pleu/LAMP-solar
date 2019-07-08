classdef FDTDAdvancedOptionsTab < handle
    properties
        ForceSymmetricXMesh;
        ForceSymmetricYMesh;
        ForceSymmetricZMesh;
        OverrideSimulationBandwidthForMeshGeneration;
        SnapPertoYeeCellBoundary;
        AlwaysUseComplexField;
        UseEarlyShutoff;
        AutoShutoff;
        UseDivergenceChecking;
        AutoShutoffMax;
        DownSmapleTime;
        PmlKappa;
        PmlSigma;
        MinimumPmlLayers;
        MaximumPmlLayers;
        PmlPolynomial;
        TypeofPml;
        ExtendStructureThroughPML;
        MaxSourceTimeSignalLength;
        SetProcessGrid;
        Nx;
        Ny;
        Nz;
    end
    
    properties (Dependent)
        WavelengthMin;
        WavelengthMax;
        WavelengthCenter;
        WavelengthSpan;       % in microns
        FrequencyMin;
        FrequencyMax;
        FrequencyCenter;
        FrequencySpan;
    end
    
    properties(Access = 'private')
        WavelengthCoordinates; % Coordinates object
        FrequencyCoordinates; % Coordinates object
    end    

    methods
        function obj = FDTDAdvancedOptionsTab(pmlKappa, pmlSigma, minimumPmlLayers)
            if nargin == 0
                obj.ForceSymmetricXMesh = 0;
                obj.ForceSymmetricYMesh = 0;
                obj.ForceSymmetricZMesh = 0;
                obj.OverrideSimulationBandwidthForMeshGeneration = 0;
                obj.WavelengthCoordinates = Coordinates();
                obj.FrequencyCoordinates = Coordinates();                
                obj.SnapPertoYeeCellBoundary = 0;
                obj.AlwaysUseComplexField = 0;
                obj.UseEarlyShutoff = 1;
                obj.AutoShutoff = 1e-5;
                obj.UseDivergenceChecking = 1;
                obj.AutoShutoffMax = 1e5;
                obj.DownSmapleTime = 100;
                obj.PmlKappa = 2;
                obj.PmlSigma = 0.25;
                obj.MinimumPmlLayers = 12;
                obj.MaximumPmlLayers = 64;
                obj.PmlPolynomial = 3;
                obj.TypeofPml = 'standard';
                obj.ExtendStructureThroughPML = 1;
                obj.MaxSourceTimeSignalLength = 32768;
                obj.SetProcessGrid = 0;
                obj.Nx = 1;
                obj.Ny = 1;
                obj.Nz = 1;
            else
                obj.ForceSymmetricXMesh = 0;
                obj.ForceSymmetricYMesh = 0;
                obj.ForceSymmetricZMesh = 0;
                obj.OverrideSimulationBandwidthForMeshGeneration = 0;
                obj.WavelengthCoordinates = Coordinates();
                obj.FrequencyCoordinates = Coordinates();
                obj.SnapPertoYeeCellBoundary = 0;
                obj.AlwaysUseComplexField = 0;
                obj.UseEarlyShutoff = 1;
                obj.AutoShutoff = 1e-5;
                obj.UseDivergenceChecking = 1;
                obj.AutoShutoffMax = 1e5;
                obj.DownSmapleTime = 100;
                obj.PmlKappa = pmlKappa;
                obj.PmlSigma = pmlSigma;
                obj.MinimumPmlLayers = minimumPmlLayers;
                obj.MaximumPmlLayers = 64;
                obj.PmlPolynomial = 3;
                obj.TypeofPml = 'standard';
                obj.ExtendStructureThroughPML = 1;
                obj.MaxSourceTimeSignalLength = 32768;
                obj.SetProcessGrid = 0;  
                obj.Nx = 1;
                obj.Ny = 1;
                obj.Nz = 1;                
            end
        end
        
        function set.ForceSymmetricXMesh(obj, forceSymmetricXMesh)
            obj.ForceSymmetricXMesh = set_check_box(forceSymmetricXMesh);
        end
        
        function set.ForceSymmetricYMesh(obj, forceSymmetricYMesh)
            obj.ForceSymmetricYMesh = set_check_box(forceSymmetricYMesh);
        end

        function set.ForceSymmetricZMesh(obj, forceSymmetricZMesh)
            obj.ForceSymmetricZMesh = set_check_box(forceSymmetricZMesh);
        end
        
        function wavelengthCenter = get.WavelengthCenter(obj)
          wavelengthCenter = obj.WavelengthCoordinates.Center;
        end

        function wavelengthSpan = get.WavelengthSpan(obj)
          wavelengthSpan = obj.WavelengthCoordinates.Span;
        end

        function wavelengthMin = get.WavelengthMin(obj)
          wavelengthMin = obj.WavelengthCoordinates.Min;
        end

        function wavelengthMax = get.WavelengthMax(obj)
          wavelengthMax = obj.WavelengthCoordinates.Max;
        end 

        function frequencyCenter = get.FrequencyCenter(obj)
          frequencyCenter = obj.FrequencyCoordinates.Center;
        end

        function frequencySpan = get.FrequencySpan(obj)
          frequencySpan = obj.FrequencyCoordinates.Span;
        end

        function frequencyMin = get.FrequencyMin(obj)
          frequencyMin = obj.FrequencyCoordinates.Min;
        end

        function frequencyMax = get.FrequencyMax(obj)
          frequencyMax = obj.FrequencyCoordinates.Max;
        end

        function set.WavelengthCenter(obj, wavelengthCenter)
          obj.WavelengthCoordinates.Center = wavelengthCenter;
        end

        function set.WavelengthSpan(obj, wavelengthSpan)
          obj.WavelengthCoordinates.Span = wavelengthSpan;
        end

        function set.WavelengthMin(obj, wavelengthMin)
          obj.WavelengthCoordinates.Min = wavelengthMin;
          obj.FrequencyCoordinates.Max = Photon.ConvertWavelengthToFrequency(wavelengthMin*...
              Constants.UnitConversions.MicronstoNM)*Constants.UnitConversions.HztoTHz;
        end

        function set.WavelengthMax(obj, wavelengthMax)
          obj.WavelengthCoordinates.Max = wavelengthMax;
          obj.FrequencyCoordinates.Min = Photon.ConvertWavelengthToFrequency(wavelengthMax*...
              Constants.UnitConversions.MicronstoNM)*Constants.UnitConversions.HztoTHz;      
        end


        function set.FrequencyCenter(obj, frequencyCenter)
          obj.FrequencyCoordinates.Center = frequencyCenter;
        end

        function set.FrequencySpan(obj, frequencySpan)
          obj.FrequencyCoordinates.Span = frequencySpan;
        end

        function set.FrequencyMin(obj, frequencyMin)
          obj.FrequencyCoordinates.Min = frequencyMin;
          obj.WavelengthCoordinates.Max = Photon.ConvertFrequencyToWavelength(frequencyMin*...
              Constants.UnitConversions.THztoHz)*Constants.UnitConversions.NMtoMicrons;
        end

        function set.FrequencyMax(obj, frequencyMax)
          obj.FrequencyCoordinates.Max = frequencyMax;
          obj.WavelengthCoordinates.Min = Photon.ConvertFrequencyToWavelength(frequencyMax*...
              Constants.UnitConversions.THztoHz)*Constants.UnitConversions.NMtoMicrons;
        end
        
        function set.AlwaysUseComplexField(obj, alwaysUseComplexField)
            obj.AlwaysUseComplexField = set_check_box(alwaysUseComplexField);
        end   
        
        function set.UseEarlyShutoff(obj, useEarlyShutoff)
            obj.UseEarlyShutoff = set_check_box(useEarlyShutoff);
        end     
        
        function set.UseDivergenceChecking(obj, useDivergenceChecking)
            obj.UseDivergenceChecking = set_check_box(useDivergenceChecking);
        end        
        
        function set.TypeofPml(obj, typeofPml)
            options = {'standard', 'stablized'};
            obj.TypeofPml = set_value_from_list(options, typeofPml);
        end    
        
        function set.ExtendStructureThroughPML(obj, extendStructureThroughPML)
            obj.ExtendStructureThroughPML = set_check_box(extendStructureThroughPML);
        end   
        
        function set.SetProcessGrid(obj, setProcessGrid)
            obj.SetProcessGrid = set_check_box(setProcessGrid);
        end           
    end
    
    methods(Static)
        test();
    end
    

  
end