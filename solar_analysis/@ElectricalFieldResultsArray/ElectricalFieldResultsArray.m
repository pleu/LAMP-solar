classdef ElectricalFieldResultsArray
  properties
    Filename;
%    FilenameSuffix;
    NumSimulations;       % same as numEnergy
    SolarSpectrum;        % SolarSpectrum object
    MinCutoffWavelength;  % minimum cutoff wavelength
    MaxCutoffWavelength;  % maximum cutoff wavelength
  end
    properties (SetAccess = private)
      ElectricalFieldAtEnergy; % suffix: E2 
                             % electrical field intensity
                             % size nX by nZ by numEnergy
      Epsilon_i;            % suffix EpsI 
                            % imaginary part of dielectric constant
      PhotonWavelength;           % in nm, suffix Lambda
                            % photon wavelength of simulation files; same as nE
      PositionX;            % in nm; suffix X
      PositionZ;            % in nm; suffix Z
%      ShapeCorners;         % object of corner positions; 
                          % another object
      SourcePower;          % Watts; suffix SourcePower
                             % from the simulation; nE long vector
      SimulationArea;      % suffix SimArea
      
      % these are calculated; 
%      Position;  % grid of nX by nZ 
                % SolarSpectrum object
      AbsorptionAtEnergy; % A(r, e); numX by numZ by numSimulations (numE)
      Absorption          % A(r); 
      GenerationAtEnergy;   % G(r, e) (1/(cm^3sec)); generation at position; 
                          % size nPosition by numEnergy; 
      Generation;           % G(r) (1/(cm^3sec)); this is normalized by source power 
                            % and then weighted by solar spectrum 
                            % contour plots this one
      ElectricalField;      % |E(r)|^2 (V/m)^2; same as above
      PhotonEnergy;   % this converts read-in wavelength to energy (in eV);
      
      ElectricalFieldVector; % save the Electrical intensity at single fixed position 
                             % by numSimulations after cutoff
      AbsorptionVector;      % same as up
      Shape;                 % parameters define the shape of the cross section of the cylinders
    end
    
    properties (Dependent = true)
      NumX;
      NumZ;
      Ind;
      NumInd;
%      NumPosition;   % numX x numZ
%      Filename;
    end
methods
    
    function obj = ElectricalFieldResultsArray(filename,...
        numSimulations, solarSpectrum, minCutoffWavelength,...
        maxCutoffWavelength)
      if nargin == 5
        obj.Filename = filename;
        obj.NumSimulations = numSimulations;
        obj.SolarSpectrum = solarSpectrum;
        obj.MinCutoffWavelength = minCutoffWavelength;
        obj.MaxCutoffWavelength = maxCutoffWavelength;
      end
      obj = obj.ReadFiles;
      obj = obj.CalculateProperties;
%      obj = obj.Integration;
    end

    
    %function obj = CalcAbsorption

    function obj = ReadFiles(obj)
      obj.PositionX = load([obj.Filename, 'X']);
      obj.PositionZ = load([obj.Filename, 'Z']);
      obj.SimulationArea = load('SimulationArea');
      obj.Shape = load('Shape');
      load('lambdaVector');
      obj.PhotonWavelength = lambdaVector;
      obj.PhotonEnergy = Photon.ConvertWavelengthToEnergy(obj.PhotonWavelength);
      obj.SourcePower = load('SourcePower');
      obj.ElectricalFieldAtEnergy = zeros(obj.NumX, obj.NumZ,...
        obj.NumSimulations);
      obj.AbsorptionAtEnergy = zeros(obj.NumX, obj.NumZ,...
        obj.NumSimulations);
      for i = 1:obj.NumSimulations
        obj.ElectricalFieldAtEnergy(:, :, i) = load([obj.Filename, 'E2_',...
          num2str(i)]);
      end
      for i = 1:obj.NumSimulations
        obj.AbsorptionAtEnergy(:, :, i) = load([obj.Filename, 'Pabs_',...
          num2str(i)]);
      end
      
    end
    
    function obj = CalculateProperties(obj)
%       obj = obj.GenerationAtEnergy;
%      % obj = obj.Calc;
% 
%     end
%     function obj = CalcGenerationAtEnergy(obj)
      obj.GenerationAtEnergy = zeros(obj.NumX, obj.NumZ,...
      obj.NumSimulations);
      for i=1:obj.NumSimulations
        obj.GenerationAtEnergy(:,:,i) = obj.AbsorptionAtEnergy(:,:,i)./(obj.PhotonEnergy(i)*Constants.LightConstants.Q)...
          *(Constants.UnitConversions.MperCM)^3;  %(in 1/(cm^3*sec)
      end
      
      irradianceInterp = interp1(obj.SolarSpectrum.Energy, obj.SolarSpectrum.Irradiance, obj.PhotonEnergy(obj.Ind));
      obj.Generation = trapz(obj.PhotonEnergy(obj.Ind),...
        reshape(repmat(irradianceInterp', obj.NumX*obj.NumZ, 1), obj.NumX, obj.NumZ, obj.NumInd)...    
        .*obj.GenerationAtEnergy(:, :, obj.Ind)./...
        reshape(repmat(obj.SourcePower(obj.Ind)', obj.NumX*obj.NumZ, 1), obj.NumX, obj.NumZ, obj.NumInd), 3)*obj.SimulationArea;
      obj.ElectricalField = trapz(obj.PhotonEnergy(obj.Ind),...
        reshape(repmat(irradianceInterp', obj.NumX*obj.NumZ, 1), obj.NumX, obj.NumZ, obj.NumInd)...    
        .*obj.ElectricalFieldAtEnergy(:, :, obj.Ind)./...
        reshape(repmat(obj.SourcePower(obj.Ind)', obj.NumX*obj.NumZ, 1), obj.NumX, obj.NumZ, obj.NumInd), 3)*obj.SimulationArea;
 
    
    end
    
   
    
    function ind=get.Ind(obj)
      ind=find(obj.PhotonWavelength >= obj.MinCutoffWavelength & ...
        obj.PhotonWavelength <= obj.MaxCutoffWavelength);
    end
    
    function numInd = get.NumInd(obj)
      numInd = size(obj.Ind, 1);
    end
    
    function numX = get.NumX(obj)
      numX = size(obj.PositionX, 1);
    end
        
    function numZ = get.NumZ(obj)
      numZ = size(obj.PositionZ, 1);
    end
    
  end
end



