function coneArray = create_withPitch(ConezSpan, rtop, rbot, a)
 if nargin == 2
    coneArray = ConeHoleArray(ConezSpan, rtop);
 elseif nargin == 3
    coneArray = ConeHoleArray(ConezSpan, rtop, rbot);
 elseif nargin == 5
    coneArray = ConeHoleArray(ConezSpan, rtop, rbot);
    coneArray.Cone.Properties.X = -a/2;
    coneArray.Cone.Properties.Y = a/2;
end
