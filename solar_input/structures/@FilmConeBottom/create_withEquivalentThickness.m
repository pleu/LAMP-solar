function filmCone = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, rtop, rbot)
  if nargin == 4
    ConezSpan = xSpan^2*(equivalentThickness - zSpan)/pi/(rtop^2);
    filmCone = FilmConeBottom(zSpan, xSpan, ConezSpan, rtop);    
  elseif nargin == 5
    ConezSpan = 3*xSpan^2*(equivalentThickness - zSpan)/pi/(rtop^2+rtop*rbot+rbot^2);
    filmCone = FilmConeBottom(zSpan, xSpan, ConezSpan, rtop, rbot);
  end
end
