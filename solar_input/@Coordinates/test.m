co = Coordinates(0, 3);
co.Min = -3;
assert(co.Max == 1.5);
co.Min = 3;
assert(co.Span == 0);


co2 = Coordinates;