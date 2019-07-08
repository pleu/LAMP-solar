function x = is_numerically_equal(a,b)
% returns whether two numbers are equal within floating point accuracy
x = (abs(a-b) <= eps(single(b)));

end

