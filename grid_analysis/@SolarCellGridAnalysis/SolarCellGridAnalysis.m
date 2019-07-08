classdef SolarCellGridAnalysis
  %SOLARCELL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    %Acell;   % Cell area, m^2
    Lcell;   % Cell length, m
    A;       % length unit cell
    Nbus;    % number of busbars
    Lf;      % Finger length, m
    Wf;      % Finger width, m
    Hf;      % Finger thickness, m
    
    Wbuc;    % width busbar unit cell    
    rhoC;    % contact resistivity, Ohm-m^2
    rhoM;    % metal resistivity, Ohm-m
    Rsh;     % sheet resistance, Ohm/sq
    Jmpp;    % current density at mpp
    Vmpp;    % voltage at mpp
    
    S;       % finger separation distance
    
    PeEmitter;
    PeFinger;
    PeEmitterContact;

  end
  
  properties (Dependent = true)
    Ps;
    PsBus;
    PsFinger;
    
    Pe;
    Ploss;
    
    R;
    
    Re;
    Rf;
    Rc;
    
    Effmpp;
    massMetal;
  end
  
  methods
    
    function obj = SolarCellGridAnalysis(inputStructure)
      if nargin > 0
        %obj.Acell = inputStructure.Acell;    
        obj.Lcell = inputStructure.Lcell; 
        obj.Wf=inputStructure.Wf;
        obj.Lf=inputStructure.Lf;               %length finger m
        obj.Hf=inputStructure.Hf;
        obj.Nbus=inputStructure.NBusbars;    % number of busbars
        
        obj.Wbuc= inputStructure.Wbuc;                 %1/2 width busbar (unit cell) m
        obj.Rsh=inputStructure.Rsh;                          %sheet resistance emitter Ohms/sq
        obj.A = inputStructure.A;            % length unit cell for two bus bars; 39e-3*4 = .156 m = 15.6 cm
        obj.rhoM = inputStructure.rhoM;       % conductivity of metal Ohms-meter
        obj.rhoC = inputStructure.rhoC;
        obj.S = inputStructure.S;        % finger separation distance in m
        
        obj.Jmpp=inputStructure.Jmpp;                          %current density active cell area A/m^2
        obj.Vmpp=inputStructure.Vmpp;                       %voltage at mpp V

        
      end
    end
    
    function massMetal = get.massMetal(obj)
      rhoMetal = 10.5*(100)^3;
      massMetal = obj.Wf*obj.Hf*(obj.Lcell)^2./obj.S*rhoMetal+obj.Nbus*(obj.Wbuc*2)*obj.Hf*obj.Lcell*rhoMetal;
    end

    
    function R = get.R(obj)
      R = obj.Re + obj.Rc + obj.Rf;
    end

    function Pe = get.Pe(obj)
      Pe = obj.PeEmitter + obj.PeFinger + obj.PeEmitterContact;
    end
    
    function Ploss = get.Ploss(obj)
      Ploss = obj.Pe+obj.Ps;
    end
    

    
    function Re = get.Re(obj)
      Re = 1/12*obj.Rsh*(obj.S- obj.Wf)/obj.Lf*obj.A.*obj.S;
    end

    function Rc = get.Rc(obj)
      Rc = obj.Rsh*obj.rhoC/obj.Lf*coth(obj.Wf/2*sqrt(obj.Rsh/obj.rhoC))*obj.A.*obj.S/2;
    end

    function Rf = get.Rf(obj)
      Rf = 1/3*obj.rhoM*obj.Lf/(obj.Hf*obj.Wf)*obj.A.*obj.S;
    end
    
    function effMpp = get.Effmpp(obj)
      incidentRadiation = 1000; %W/m^2
      effMpp = obj.Jmpp*obj.Vmpp/incidentRadiation;
    end
    
    function [obj] = calc_Pe(obj)
      obj.PeEmitterContact = calc_PeEmitterContact(obj);
      obj.PeEmitter = calc_PeEmitter(obj);
      obj.PeFinger = calc_PeFinger(obj);
    end

    function PeEmitterContact = calc_PeEmitterContact(obj)
      PeEmitterContact = obj.Jmpp./(obj.Vmpp+obj.R.*obj.Jmpp).*(1-obj.Ps).*obj.Rc;
    end
    
    function PeEmitter = calc_PeEmitter(obj)
      PeEmitter = obj.Jmpp./(obj.Vmpp+obj.R*obj.Jmpp).*(1-obj.Ps).*obj.Re;
    end

    function PeFinger = calc_PeFinger(obj)
      PeFinger = obj.Jmpp./(obj.Vmpp+obj.R*obj.Jmpp).*(1-obj.Ps).*obj.Rf;
%       Af = obj.Wf*obj.Hf;
%       rEff = 2/3*obj.rhoM*obj.Lf/Af;
%       iCell = obj.A*obj.S/2;
%       PeFinger = rEff*iCell^2;
    end

%     function PeEmitterContact = get.PeEmitterContact(obj)
%       %rEff = sqrt(obj.rhoC*obj.Rsk)/obj.Lf*coth(obj.Wf/2*sqrt(obj.Rsk;/obj.rhoC));
%       rEff = sqrt(obj.rhoC*obj.Rsh)/obj.Lf*coth(obj.Wf/2*sqrt(obj.Rsh/obj.rhoC));
%       iCell = obj.A*obj.S/2;
%       PeEmitterContact = rEff*iCell^2;
%     end

    
%     function PeEmitter = get.PeEmitter(obj)
%       rEff = 1/6*obj.Rsh*(obj.S-obj.Wf)/obj.Lf;
%       iCell = obj.A*obj.S/2;
%       PeEmitter = rEff*iCell^2;
%       
%       obj.Jmpp/(obj.Vmpp+
%       %p_eemitter = j_mpp/(V_mpp+r*j_mpp)*(1-p_s)*r_e
%     end

    
    function Ps = get.Ps(obj)
      Ps = obj.PsBus + obj.PsFinger;
    end
    
    function PsBus = get.PsBus(obj)
      PsBus = obj.Wbuc*obj.S./(obj.A*obj.S);
    end
    
    function PsFinger = get.PsFinger(obj)
      PsFinger = obj.Wf*obj.Lf./(obj.A*obj.S);
    end
    
    
  end
    
  methods(Static)
    test()
    
    test2()
    
    test3()
    
    test4()
    
    test5()
  end
    
    
end
  


