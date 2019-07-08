function H = ric_besselh_derivative(nu, K, x, flag)
% H = ric_besselh_derivative(nu, K, x) using the recursive relationship to
% calculate the first derivative of the Riccati-Bessel function
%
%
% H_{nu}(x) = \sqrt{\frac{\pi x}{2}} H_{nu+1/2}(x)
%
% nu         order of the riccati-Hankel's function. Must be a columne vector.
% K = 1      if it is Hankel's function of the first kind; K=2 if it is Hankel's function of the
%            second kind. 
% x          Must be a row evector
%
% flag      1 for the first order derivative; 2 for the second order derivative
%
    
    
%   $Rev:: 7                     $:
%   $Author:: kzhu               $:
%   $Date:: 2012-01-09 02:56:51 #$:



    if (nargin ==3)
        flag = 1;
    end
    
    if (K~=1 & K~=2)
        error('Improper kind of Hankel function. K must be either 1 or 2.');
    end
    
    if (K==1)
        H = ric_besselj_derivative(nu,x,flag) + j*ric_bessely_derivative(nu,x,flag);
    else
        H = ric_besselj_derivative(nu,x,flag) - j*ric_bessely_derivative(nu,x,flag);
    end
    
end

