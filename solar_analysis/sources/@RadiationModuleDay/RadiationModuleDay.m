classdef RadiationModuleDay < handle
  %UNTITLED9 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Module;
    RadiationBeamDay;
    IbmD; % daily module incident direct beam insolation (in kW-h/m^2/day); dim-1 is latitude, dim-2 is days, 3. beta, 4. gamma 
    IdmD; % daily module incident diffuse beam insolation (in kW-h/m^2/day)
    ITmD; % daily module incident total beam insolation (in kW-h/m^2/day)
  end
  
  properties(Dependent)
    Omegas;
    Latitudes;
    Days;
    Betas;
    Gammas;
    NumOmega;
    NumLatitudes;
    NumDays;
    NumBetas;
    NumGammas;
  end
  
  
  methods
    function obj = RadiationModuleDay(module,radiationBeamDay)
      obj.Module = module;
      obj.RadiationBeamDay = radiationBeamDay;
    end
    
    function [rb] = calculate_daily_module_insolation(rb)
      IbNormx = rb.RadiationBeamDay.IbNormx; % size is numOmega x numLatitudes x numDays
      IbNormy = rb.RadiationBeamDay.IbNormy;
      IbNormz = rb.RadiationBeamDay.IbNormz;
      moduleX = rb.Module.NormX; % size is numBeta x numGamma
      moduleY = rb.Module.NormY;
      moduleZ = rb.Module.NormZ;
      
      % need to make both same size to multiply
      IbNormXRep = repmat(IbNormx, 1, 1, 1, rb.NumBetas, rb.NumGammas);
      IbNormYRep = repmat(IbNormy, 1, 1, 1, rb.NumBetas, rb.NumGammas);
      IbNormZRep = repmat(IbNormz, 1, 1, 1, rb.NumBetas, rb.NumGammas);
      Ib = repmat(rb.RadiationBeamDay.Ib, 1, 1, 1, rb.NumBetas, rb.NumGammas);
      moduleXMat(1, 1, 1, :, :) = moduleX;
      moduleYMat(1, 1, 1, :, :) = moduleY;
      moduleZMat(1, 1, 1, :, :) = moduleZ;
      
      moduleXRep = repmat(moduleXMat, rb.NumOmega, rb.NumLatitudes, rb.NumDays, 1, 1);
      moduleYRep = repmat(moduleYMat, rb.NumOmega, rb.NumLatitudes, rb.NumDays, 1, 1);
      moduleZRep = repmat(moduleZMat, rb.NumOmega, rb.NumLatitudes, rb.NumDays, 1, 1);
      cosThetaTiltMat = (IbNormXRep.*moduleXRep+IbNormYRep.*moduleYRep+IbNormZRep.*moduleZRep);
      
      Ibtilt = Ib.*cosThetaTiltMat;
      Ibtilt(Ibtilt<0) = 0;
      betaMat(1, 1, 1, :, 1) = rb.Module.Betas;
      betaMatRep = repmat(betaMat, rb.NumOmega, rb.NumLatitudes, rb.NumDays, 1, rb.NumGammas);
      Id = 0.1.*Ib;
      Idtilt = (1+cos(betaMatRep))./2.*Id;
      
      rb.IbmD = reshape(12/pi*trapz(rb.RadiationBeamDay.Omegas, Ibtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);
      rb.IdmD = reshape(12/pi.*trapz(rb.RadiationBeamDay.Omegas, Idtilt, 1), rb.NumLatitudes, rb.NumDays, rb.NumBetas, rb.NumGammas);

      rb.ITmD = rb.IbmD + rb.IdmD;
    end
    
    function omega = get.Omegas(rb)
      omega = rb.RadiationBeamDay.Omegas;
    end
    
    function latitude = get.Latitudes(rb)
      latitude = rb.RadiationBeamDay.Latitudes;
    end
    
    function days = get.Days(rb)
      days = rb.RadiationBeamDay.Days;
    end
    
    function betas = get.Betas(rb)
      betas = rb.Modulel.Betas;
    end
    
    function gammas = get.Gammas(rb)
      gammas = rb.Modulel.Gammas;
    end
    
    function numOmega = get.NumOmega(rb)
      numOmega = rb.RadiationBeamDay.NumOmega;
    end
    
    function numLatitudes = get.NumLatitudes(rb)
      numLatitudes = rb.RadiationBeamDay.NumLatitudes;
    end
    
    function numDays = get.NumDays(rb)
      numDays = rb.RadiationBeamDay.NumDays;
    end
    
    function numBetas = get.NumBetas(rb)
      numBetas = rb.Module.NumBetas;
    end
    
    function numGammas = get.NumGammas(rb)
      numGammas = rb.Module.NumGammas;
    end
  end
  
  
  
  methods(Static)
    test()
  end
end

