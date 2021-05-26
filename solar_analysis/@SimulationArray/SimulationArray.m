classdef SimulationArray
  %SIMULATIONARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    VariableArray;
    Simulations;
  end
  
  properties
    NumSimulations;
  end
  
  methods
    function obj = SimulationArray(variableArray, simulations)
      if nargin~=0
        obj.VariableArray = variableArray;
        obj.Simulations = simulations;
      end
    end
    
    function numSimulations = get.NumSimulations(tca)
      numSimulations = tca.VariableArray.NumValues;
    end
    
    
  end
  
  methods(Static)
    function obj = read_RCWA_file(filename)
      inputData = load(filename);
      theta = inputData(:,2);
      uniqueTheta = unique(theta);
      
      phi = inputData(:, 3);
      uniquePhi = unique(phi);
      
      va = VariableArray.create_variable_combinations({'Theta', 'Phi'}, {'deg', 'deg'}, {uniqueTheta', uniquePhi'});
      
      simResults = SimulationResults.empty(va.NumValues, 0);
      ind = 1;
      for i = 1:length(uniqueTheta)
        for j = 1:length(uniquePhi)
          angleTheta = uniqueTheta(i);
          anglePhi = uniquePhi(j);
          simulationIndices = find(inputData(:, 2) == angleTheta & inputData(:, 3) == anglePhi);
          wavelengths = inputData(simulationIndices, 1)*Constants.UnitConversions.MicronstoNM; % convert from microns to nm
          
          transmissionData=inputData(simulationIndices, 4);
          reflectionData=inputData(simulationIndices, 5);
          absorptionData=inputData(simulationIndices, 6);
          
          simResults(ind) = SimulationResults(wavelengths, reflectionData, transmissionData, absorptionData);
          ind = ind+1;
        end
      end
      
      obj = SimulationArray(va, simResults);
      
    end
    
    function [var_names, var_units, var_values] = read_scaps_batch_paramers(fid)
      index = 1;
      tline = fgetl(fid);
      while ~isempty(tline)
        var_name_line = strsplit(tline, ':');
        var_name_units = var_name_line{1};
        var_name_split = strsplit(var_name_units, '[');
        var_names{index} = var_name_split{1};
        units = extractBetween(var_name_units,'[',']');
        var_units{index} = units{:};
        var_values(index) = str2double(strtrim(var_name_line{2}));
        index = index + 1;
        tline = fgetl(fid);
      end
    end
    
    function [variable, value] = read_scaps_value(tline)
      var_name_line = strsplit(tline, ':');
      variable = var_name_line{1};
      split_string = strsplit(var_name_line{2}, '\t');
      value = str2double(split_string{2});
    end
      
    function [solarCellIV, var_names, var_units, var_values] = read_scaps_simulation(fid) % read total number of simulations
      % read until Power from spectrum
      tline = fgetl(fid);
      while isempty(tline) || ~strncmp(tline, 'Power', 5)
        tline = fgetl(fid);
      end
      [variable, powerDensity] = SimulationArray.read_scaps_value(tline);

      % read until **Batch parameters**
      while isempty(tline) || tline(1) ~= '*'
        tline = fgetl(fid);
      end
      %disp(tline)
      %tline = fgetl(fid);
       
      [var_names, var_units, var_values] = SimulationArray.read_scaps_batch_paramers(fid);
      
      % read in iv
      index = 1;
      tline = fgetl(fid);
      tline = fgetl(fid);
      tline = fgetl(fid);
      %tline = fgetl(fid);
      while ~isempty(tline)
        %tline = fgetl(fid);
        data(index, :) = sscanf(tline, '%f %f %f %f %f %f %f %f %f %f %f');
        %data(index, :)=fscanf(fid,'%f %f %f %f %f %f %f %f %f %f %f');
        index = index + 1;
        tline = fgetl(fid);
      end
      
      voltage = data(:, 1);
      current = data(:, 2);
      solarCellIV = SolarCellIV(voltage, current, powerDensity);
      %numVars = index - 1;
    
    end
      
    function [obj] = read_scaps1d_file(filename)
      fid = fopen(filename);
      % read header lines
      tline = fgetl(fid);
      tline = fgetl(fid);
      
      tline = fgetl(fid);
      tline_split = strsplit(tline);
      numSims = str2double(tline_split{end});

      scIV = SolarCellIV.empty(numSims, 0);
      var_names_array = cell(numSims, 1);
      var_units_array = cell(numSims, 1);
      var_values_array = cell(numSims, 1);
      
      %var_names = SolarCellIV.empty(numSims, 0);
      for simIndex = 1:numSims
        [scIV(simIndex), var_names_array{simIndex}, var_units_array{simIndex}, var_values_array{simIndex}] = SimulationArray.read_scaps_simulation(fid);
      end

      %va = VariableArray(var_names, var_units, RT.theta);
      var_values_array_number = cell2mat(var_values_array);
      fclose(fid);
      va = VariableArray(var_names_array{1}, var_units_array{1}, var_values_array_number);
      %va = VariableArray('Theta', 'deg', RT.theta);

      obj = SimulationArray(va, scIV);
      
    end
    
    function [objS, objP] = read_TMM_file(filename)
      load(filename);      
      va = VariableArray('Theta', 'deg', RT.theta);
      
      
      
      simResultsS = SimulationResults.empty(length(RT.theta), 0);
      simResultsP = SimulationResults.empty(length(RT.theta), 0);
      wavelengths = RT.lambda*Constants.UnitConversions.MtoNM; % convert from microns to nm
      for i = 1:length(RT.theta)
        if RT.theta(i) == 90 || RT.theta(i) == -90
          reflectionDataS=ones(length(RT.Rs(:,:,:,i)), 1);
          transmissionDataS=zeros(length(RT.Ts(:,:,:,i)), 1);          
          reflectionDataP=ones(length(RT.Rs(:,:,:,i)), 1);
          transmissionDataP=zeros(length(RT.Ts(:,:,:,i)), 1);          

        else
        
          reflectionDataS=RT.Rs(:,:,:,i);
          transmissionDataS=RT.Ts(:,:,:,i);
          transmissionDataS(isnan(transmissionDataS)) = 0;
          transmissionDataS(transmissionDataS>1) = 0;
          
          
          
          reflectionDataP=RT.Rp(:,:,:,i);
          transmissionDataP=RT.Tp(:,:,:,i);
          transmissionDataP(isnan(transmissionDataP)) = 0;
          transmissionDataP(transmissionDataP>1) = 0;
        end
        absorptionDataS = 1 - reflectionDataS - transmissionDataS;
        absorptionDataP = 1 - reflectionDataP - transmissionDataP;

        %absorptionData=inputData(angles==uniqueAngles(i), 5);
        simResultsS(i) = SimulationResults(wavelengths, reflectionDataS(:), transmissionDataS(:), absorptionDataS(:));
        simResultsP(i) = SimulationResults(wavelengths, reflectionDataP(:), transmissionDataP(:), absorptionDataP(:));
      end
      
      objS = SimulationArray(va, simResultsS);
      objP = SimulationArray(va, simResultsP);

    end
    
  end
  
  
end

