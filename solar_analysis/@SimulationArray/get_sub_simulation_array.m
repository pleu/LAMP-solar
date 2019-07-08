function [sa2, varIndexOut] = get_sub_simulation_array(sa, varString, value)
% creates variableArray where varString == value
% elseif strcmpi(varString, 'Energy')
%
% else
[va2, varIndexOut] = get_sub_variable_array(sa.VariableArray, varString, value);
sa2 = SimulationArray(va2, sa.Simulations(varIndexOut));
% end

end

