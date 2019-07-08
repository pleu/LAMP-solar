function x = is_almost_equal(a,b,diff)
% returns whether two numbers are equal within diff
x = (abs(a-b) <= diff);

end

