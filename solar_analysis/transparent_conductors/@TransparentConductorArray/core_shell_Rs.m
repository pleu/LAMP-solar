function [tcArray] = core_shell_Rs( tcArray, shellThickness, coreMaterial, shellMaterial )
%CORE_SHELL_RS Summary of this function goes here
%   Detailed explanation goes here
  for i = 1:tcArray.VariableArray.NumValues 
%     Rs = load(char(strcat(tcArray.VariableArray.Filenames(i),'Rs.txt')));
%     
%     D = tcArray.VariableArray.Values(i,1);
%     d = tcArray.VariableArray.Values(i,1) - 2 * shellThickness;
%     a = tcArray.VariableArray.Values(i,2);
%     
    Rs = (4/pi) * (Constants.UnitConversions.NMtoM * tcArray.VariableArray.Values(i,2) * coreMaterial.Rho * shellMaterial.Rho)/...
        (shellMaterial.Rho * (Constants.UnitConversions.NMtoM * (tcArray.VariableArray.Values(i,1) - 2 * shellThickness))^2 + ...
        coreMaterial.Rho * ((Constants.UnitConversions.NMtoM * tcArray.VariableArray.Values(i,1))^2 - ...
        (Constants.UnitConversions.NMtoM * (tcArray.VariableArray.Values(i,1) - 2 * shellThickness))^2));
    
    tcArray.TransparentConductors(i).SheetResistance = Rs;
  end

end

