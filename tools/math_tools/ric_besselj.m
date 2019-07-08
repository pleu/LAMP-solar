function J = ric_besselj(nu,x)
% J = ric_besselj(nu, x) implements the Riccati-Bessel functions.
% 
% J_{nu}(x) = \sqrt{\frac{\pi x}{2}} J_{nu+1/2}(x)
% 
% where
% nu  order of the Bessel's function. Must be a column vector.
% x   must  be a row complex vector
%

%   $Rev:: 7                                                  $
%   $Author:: kzhu                                            $
%   $Date:: 2012-01-09 02:56:51 -0500 (Mon, 09 Jan 2012)      $

x  = reshape(x, 1, length(x));
nu = reshape(nu, length(nu) ,1);

a = besselj(nu+0.5,x);
if (length(x) == 1)
    a = reshape(a, length(nu), 1);
elseif (length(nu) == 1)
    a = reshape(a, 1, length(x));
else
    a = transpose(a);
end

J = sqrt(pi/2.*(ones(length(nu),1)*x)).*a;


