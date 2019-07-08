function doubleNanomesh = create(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, rTop, rBottom)
  if nargin == 6
    doubleNanomesh = DoubleNanomesh(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, xSpan*sqrt(3), rTop, rBottom);    
%   elseif nargin == 4
%     opticalFilter = OpticalFilter(zSpan, xSpan, ySpan, radius);
  end
end
