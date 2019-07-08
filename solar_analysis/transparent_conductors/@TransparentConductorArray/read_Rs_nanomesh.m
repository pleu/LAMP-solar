function [tcArray] = read_Rs_nanomesh(tcArray)
 
  for i = 1:tcArray.VariableArray.NumValues 
    tcArray.TransparentConductors(i) = tcArray.TransparentConductors(i).get_Rs_nanomesh;
    
  end
  
end



