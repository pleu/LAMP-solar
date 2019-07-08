function plot(va, yValues, yLabel, varargin)
  
  optionplot(va.Values, yValues, varargin{:});
  xlabel(va.VariableAxisLabels);
  ylabel(yLabel);  

end

