function Y = ric_bessely_derivative(nu, x, flag)
% Y = ric_bessely_derivative(nu, x, flag) using the recursive relationship to
% calculate the first derivative of the Riccati-Neumann's function.
%
% The Riccati-Neumann's function is defined as
%
% Y_{nu}(x) = \sqrt{\frac{\pi x}{2}} Y_{nu+1/2}(x)
%
% nu         order of the riccati Bessel's function.  Must be a column vector.
% x          Must be a row vector.
% flat       1, first order derivative order; 2, second order derivative
%
    
    
%   $Rev:: 7                     $:
%   $Author:: kzhu               $:
%   $Date:: 2012-01-09 02:56:51 #$:


    if (nargin == 2)
        flag = 1;
    end

    x    = reshape(x, 1, length(x));
    nu   = reshape(nu, length(nu) ,1);

    temp = ones(length(nu), 1)*x;
    if (flag ==1)
        Y = 0.5*(              ric_bessely(nu-1, x) ...
                 + temp.^(-1).*ric_bessely(nu,   x) ...
                 -             ric_bessely(nu+1, x));
    elseif (flag ==2)
        Y = 0.5*(              ric_bessely_derivative(nu-1, x) ...
                 + temp.^(-1).*ric_bessely_derivative(nu,   x) ...
                 - temp.^(-2).*ric_bessely(nu, x) ...
                 -             ric_bessely_derivative(nu+1, x));
    else
        error('This script only handles first and second derivative.')
    end


    temp2 = ones(length(nu),1)*x;
    Y(temp2==0) = -inf; % x = 0, all zeros
    temp1 = nu*ones(1, length(x));
    if (flag ==1)
        Y(find(temp1==0 & temp2==0)) = 1;
    else
        Y(find(temp1==0 & temp2==0)) =-1;
    end

end

