function [xGuess] = find_zeros_complex_x_complex_y(xReal, xImag, z)

[xGuess1] = find_zeros_complex(xReal, xImag, real(z));
[xGuess2] = find_zeros_complex(xReal, xImag, imag(z));

[xGuess] = intersect(xGuess1, xGuess2);
xGuess = sort(xGuess);
[xGuessReal, ind] = sort(real(xGuess));
xGuess = xGuess(ind);


[xGuessReal, xGuessImag] = eliminate_contiguous_values(real(xGuess), imag(xGuess), xReal(2)-xReal(1), xImag(2)-xImag(1));
xGuess = xGuessReal + xGuessImag*1i;

% eliminate contiguous values

figure(1);
clf; 
contour3(xReal, xImag, real(z));
hold on;
plot(real(xGuess), imag(xGuess), 'ro');

%plot(real(xGuess1), imag(xGuess1), 'kx');

figure(2);
clf; 
contour3(xReal, xImag, imag(z));
hold on;
plot(real(xGuess), imag(xGuess), 'ro');

