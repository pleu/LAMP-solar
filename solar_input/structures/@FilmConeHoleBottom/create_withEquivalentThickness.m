function filmConeHole = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, rtop, rbot)
  if nargin == 4
    ConezSpan = xSpan^2*(zSpan- equivalentThickness)/pi/(rtop^2);
    filmConeHole = FilmConeHoleBottom(zSpan, xSpan, ConezSpan, rtop);    
  elseif nargin == 5
    ConezSpan = 3*xSpan^2*(zSpan- equivalentThickness)/pi/(rtop^2+rtop*rbot+rbot^2);
    filmConeHole = FilmConeHoleBottom(zSpan, xSpan, ConezSpan, rtop, rbot);
  end
end
