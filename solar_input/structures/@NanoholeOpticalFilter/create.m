function opticalFilter = create(zSpan, xSpan, ySpan, radius)
  if nargin == 3
    opticalFilter = OpticalFilter(zSpan, xSpan, xSpan*sqrt(3), radius);    
  elseif nargin == 4
    opticalFilter = OpticalFilter(zSpan, xSpan, ySpan, radius);
  end
end
