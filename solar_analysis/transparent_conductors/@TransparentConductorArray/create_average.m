function [tcArrayAvg] = create_average(tcArray1, tcArray2)
%AVERAGE 
%  isequal(tcArray1.TransparentConductors, tcArray2.TransparentConductors);
  tcArrayAvg = TransparentConductorArray(tcArray1.TransparentConductors,...
      tcArray1.VariableArray);  
  tcArrayAvg.Transmission = (tcArray1.Transmission + tcArray2.Transmission)/2;
  tcArrayAvg.SheetResistance = (tcArray1.SheetResistance +... 
    tcArray2.SheetResistance)/2;

end

