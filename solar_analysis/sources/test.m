clear;
gammaSMat = pi/4;
alphaSMat = pi/3;
betaMat = pi/4;
gammaMat = 0;
thetaZMat = pi/2-alphaSMat;
cosThetaZMat = cos(thetaZMat);


[IbNormx, IbNormy, IbNormz] = sph2cart(gammaSMat, alphaSMat, 1);
Ib = [IbNormx, IbNormy, IbNormz];
test = [sin(thetaZMat).*cos(gammaSMat) sin(thetaZMat).*sin(gammaSMat) cos(thetaZMat)];

[moduleX, moduleY, moduleZ] = sph2cart(gammaMat, pi/2-betaMat, 1);
module = [moduleX, moduleY, moduleX]
test2 = [sin(pi/2-betaMat).*cos(gammaMat) sin(pi/2-betaMat).*sin(gammaMat) cos(pi/2-betaMat)];
cosThetaTiltMat = (IbNormx.*moduleX+IbNormy.*moduleY+IbNormz.*moduleZ);

cosThetaTiltMatCheck = cosThetaZMat.*cos(betaMat)+sin(thetaZMat).*sin(betaMat).*cos(gammaSMat - gammaMat);