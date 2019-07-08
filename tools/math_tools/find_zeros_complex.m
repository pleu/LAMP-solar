function [xGuess] = find_zeros_complex(xReal, xImag, z)
% This finds the zeros of a function where x is complex
% zeros are determined from where the function crosses from negative 
% to positive (or vice versa)
% and where the slope is the same in sign.
if length(xReal)~=size(z, 2)
  error('Lengths of xReal and z in dimension 2 should be the same');  
end
if length(xImag)~=size(z, 1)
  error('Lengths of xImag and z in dimension 1 should be the same');  
end

% finds zeros in the first dimension
dim = 2;
[coords1] = find_zeros_dim(z, dim);

% figure(1);
% clf; 
% contour3(xReal, xImag, real(z));
% hold on;
% plot(xReal(coords1(:, 2)), xImag(coords1(:, 1)), 'kx');


% finds zeros in the second dimension
dim = 1;
[coords2] = find_zeros_dim(z, dim);

% find zeros where approximately zero
[indI, indJ] = find(abs(z) <= eps(single(z(1))));
coords3 = [indI, indJ];
%[indI, indJ] = find(is_numerically_equal(z,0))
%coords = [indI, indJ];

coords = union(coords1, coords2, 'rows');
coords = union(coords, coords3, 'rows');
coords = unique(coords, 'rows');

%coords = intersect(coords1, coords2, 'rows');



xGuess = xReal(coords(:, 2))+1i*xImag(coords(:, 1));


function [coords] = find_zeros_dim(z, dim)
dZxReal = diff(z, 1, dim);
%dZdxImag = diff(z, 1, 2);

% real part in x should cross zero
% imaginary part 
nZxReal = size(z, dim);
%ndZxReal = size(dZxReal, dim);
%indGuess = intersect(find(z(1:
if dim == 2
  [indI, indJ] = find(z(:,1:nZxReal-1).*z(:,2:nZxReal)<= 0); % function changes sign
  %[indI2, indJ2] = find(dZxReal(:,1:ndZxReal-1).*dZxReal(:,2:ndZxReal)>= 0); % derivative is greater than 0
  % in the y-direction; 
  %indJ = indJ + 1;
  %indJ2 = indJ2 + 1;
else
  [indI, indJ] = find(z(1:nZxReal-1,:).*z(2:nZxReal,:)<= 0); % function changes sign
  %[indI2, indJ2] = find(dZxReal(1:ndZxReal-1,:).*dZxReal(2:ndZxReal,:)>= 0); % derivative is greater than 0
  %indI = indI + 1;
  %indI2 = indI2 + 1;
end
% 
%plot(indJ2, indI2, 'go')

coords1 = [indI, indJ];
if dim ==2 
  coords2 = [indI, indJ+1];
else
  coords2 = [indI+1, indJ];
end
coords = union(coords1, coords2, 'rows');
%coords2 = [indI2, indJ2];
%coords = [indJ, indI];
%coords = intersect(coords1, coords2, 'rows');
% figure(1);
% clf;
% contour(z)
% hold on;
% plot(coords(:, 2), coords(:, 1), 'x')

%coords = coords + 1;


