function [tcArray] = read_Rs(tcArray)
 
  for i = 1:tcArray.VariableArray.NumValues 
    Rs = load(char(strcat(tcArray.VariableArray.Filenames(i),'Rs.txt')));
    tcArray.TransparentConductors(i).SheetResistance = Rs;
  end
  
end



