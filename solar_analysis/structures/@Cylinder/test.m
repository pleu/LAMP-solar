clear;
f = @(x) Cylinder.simple_test(x);
nX = 20;
nXImag = 20;
xTryUnit = linspace(-2,2, nX);
xTryUnitImag = linspace(-2,2, nXImag);
xTry = combvec(xTryUnit, xTryUnitImag)';

xTry = xTry(:, 1) + xTry(:, 2)*1i;
eqn = feval(f, xTry);

eqn = vec2mat(eqn, nX); % row at a time; check
xReal = xTryUnit;
xImag = xTryUnitImag;


figure(2);
clf;
roots = [1 0; -1/2 sqrt(3)/2; -1/2 -sqrt(3)/2];

contour3(xReal, xImag, imag(eqn));
hold on;
plot(roots(:, 1), roots(:, 2), 'o');

[xGuess] = find_zeros_complex_x_complex_y(xReal, xImag, eqn);


%xGuess = [real(xGuess); imag(xGuess)];
%label = kmeans(xGuess);




% [xGuess] = find_zeros_complex_x_complex_y(xReal, xImag, eqn);
% 
% figure(1);
% clf; 
% contour3(xReal, xImag, real(eqn));
% hold on;
% plot(roots(:, 1), roots(:, 2), 'o');
% [xGuess] = find_zeros_complex(xReal, xImag, real(eqn))
% % 
%plot(xGuessReal, xGuessImag, 'bx');

plot(real(xGuess), imag(xGuess), 'bx');
% % 
% figure(2);
% [xGuess2] = find_zeros_complex(xReal, xImag, imag(eqn))
% plot(real(xGuess2), imag(xGuess2), 'bx');
% % 
% % [xBoth] = intersect(xGuess, xGuess2);
% % plot(real(xBoth), imag(xBoth), 'd');
% 
% resonances = zeros(length(xGuess),1);
% 
% for m = 1:length(xGuess)
%   % cannot use fzero because x must be real and function evaluation
%   % must be real
%   %[resonancesOut, fVal, exitFlag] = fzero(f, kGuess(m));
%   [resonancesOut, fVal, exitFlag] = fsolve(f, xGuess(m));
%   if exitFlag > 0
%     resonances(m) = resonancesOut;
%     % resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
%   else
%     resonances(m) = nan;
%   end  
% end
% 




