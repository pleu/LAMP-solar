syms a;
a1 = [a 0];
a2 = [a/2 sqrt(3)*a/2];

A = 2*pi*inv([a1; a2]);



a1 = [a 0];
a2 = [-a/2 sqrt(3)*a/2];

A = 2*pi*inv([a1; a2]);


mMax = 10;
nMax = 10;
ourIndex = zeros(mMax+1,nMax+1);
thiolIndex = zeros(mMax+1, nMax+1);
for m = 0:mMax
  for n = 0:nMax
    ourIndex(m+1, n+1) = m^2 - m*n + n^2;
    thiolIndex(m+1, n+1) = m^2 + m*n + n^2;
  end
end

