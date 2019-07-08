clear;
f = @(x) Cylinder.simple_test2(x);
nX = 100;
nXImag = 100;
xTryUnit = linspace(-10,10, nX);
xTryUnitImag = linspace(-10,10, nXImag);
xTry = combvec(xTryUnit, xTryUnitImag)';

xTry = xTry(:, 1) + xTry(:, 2)*1i;
eqn = feval(f, xTry);

eqn = vec2mat(eqn, nX); % row at a time; check
xReal = xTryUnit;
xImag = xTryUnitImag;

figure(1);
clf;
contour3(xReal, xImag, real(eqn));
roots = [0 0; 0 2*pi; 0 -2*pi];
hold on;
plot(roots(:, 1), roots(:, 2), 'o');

figure(2);
clf;

contour3(xReal, xImag, imag(eqn));
hold on;
plot(roots(:, 1), roots(:, 2), 'o');

[xGuess] = find_zeros_complex_x_complex_y(xReal, xImag, eqn);

%kmeans(xguess);

% figure(1);
% [xGuess] = find_zeros_complex(xReal, xImag, real(eqn))
% 
plot(real(xGuess), imag(xGuess), 'x');
% 
% figure(2);
% [xGuess2] = find_zeros_complex(xReal, xImag, imag(eqn))
% plot(real(xGuess2), imag(xGuess2), 'x');
% 
% [xBoth] = intersect(xGuess, xGuess2);
% plot(real(xBoth), imag(xBoth), 'd');

resonances = zeros(length(xGuess),1);

for m = 1:length(xGuess)
  % cannot use fzero because x must be real and function evaluation
  % must be real
  %[resonancesOut, fVal, exitFlag] = fzero(f, kGuess(m));
  [resonancesOut, fVal, exitFlag] = fsolve(f, xGuess(m));
  if exitFlag > 0
    resonances(m) = resonancesOut;
    % resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
  else
    resonances(m) = nan;
  end  
end
