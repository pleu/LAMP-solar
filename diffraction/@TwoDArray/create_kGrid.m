function [kxGrid, kyGrid, kroneckerDelta, deltaInd] = create_kGrid(obj, wavelength)
%CREATE_KGRID Summary of this function goes here
%   Detailed explanation goes here
% numThetaPoints = 181;
% numPhiPoints = 91;

numThetaPoints = 180*2+1;
numPhiPoints = 90*2+1;

k = 2*pi/wavelength;

% create vector up to minN
minN = zeros(2, 1);
for i = 1:2
  minN(i) = floor(2*obj.Pitch*norm(obj.Lattice(i, :))/wavelength);
end

latticePoints = combvec(-minN(1):1:minN(1), -minN(2):1:minN(2))';
kPts1 = latticePoints*obj.ReciprocalLattice; % in k_x and k_y

kPts1 = kPts1(kPts1(:, 1).^2+kPts1(:, 2).^2 < k^2, :);
%theta1 = rad2deg(asin(kPts1./k));
%theta = unique([theta theta1(:, 1)' theta1(:, 2)']);
%kx = unique([kx kPts1(:, 1)' kPts1(:, 2)']);

[theta1, sinPhi1] = cart2pol(kPts1(:,1)./k, kPts1(:, 2)./k);
phi1 = asin(sinPhi1);

thetaVec = linspace(0,2*pi,numThetaPoints);
phiVec = linspace(0,pi/2,numPhiPoints);


% thetaVec = linspace(0,2*pi,361);
% phiVec = linspace(0,pi/2,181);
theta1(theta1< 0) = theta1(theta1 < 0) + 2*pi;
% thetaVec = linspace(0,2*pi,361);
% phiVec = linspace(0,pi/2,181);
minDiff = 1e-6;
thetaVec = unique([thetaVec theta1']);
phiVec = unique([phiVec phi1']);
phiVec = [phiVec(diff(phiVec)> minDiff) phiVec(numel(phiVec))];
thetaVec = [thetaVec(diff(thetaVec)> minDiff) thetaVec(numel(thetaVec))];

[theta,phi] = meshgrid(thetaVec,phiVec);
[kxGrid,kyGrid] = pol2cart(theta,k*sin(phi));

kPoints = [kxGrid(:) kyGrid(:)];

kroneckerDelta = zeros(size(kxGrid));

%ismember(kPts1, kPoints, 'rows')
[deltaInd] = knnsearch(kPoints, kPts1);  % use this because of numerical error
kroneckerDelta(deltaInd) = 1;
kroneckerDelta(kxGrid == 0 & kyGrid == 0) = 1;
[deltaInd2] = find(kxGrid == 0 & kyGrid == 0);
deltaInd = unique([deltaInd; deltaInd2]);


% 
% figure(1);
% clf;
% plot(kPoints(:, 1), kPoints(:, 2), '.');
% hold on;
% plot(kPts1(:, 1), kPts1(:,2), 'ro');


end

