function coneArray = create_withConeHeight(ConeHeight, rtop, rbot)
 if nargin == 2
    ConezSpan = ConeHeight;
    coneArray = Nanocone(ConezSpan, rtop);
 elseif nargin == 3
    ConezSpan = ConeHeight;
    coneArray = Nanocone(ConezSpan, rtop, rbot);
end
