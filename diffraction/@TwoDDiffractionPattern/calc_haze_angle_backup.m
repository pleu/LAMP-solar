function [obj] = calc_haze_angle(obj, angleCutoff, howCalcHaze)
%CALC_HAZE_ANGLE Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  angleCutoff = 2.5;
  howCalcHaze = 'trapz';
elseif nargin == 2
  howCalcHaze = 'trapz';
end

if ~isequal(size(obj.ThetaX), size(obj.ThetaY))
  % This matrix should be 400 by 200
  thetaXMatrix = ones(length(obj.ThetaY), 1)*obj.ThetaX;
  thetaYMatrix = obj.ThetaY'*ones(1, length(obj.ThetaX));
else
  thetaXMatrix = obj.ThetaX;
  thetaYMatrix = obj.ThetaY;
end


indMatrix = thetaXMatrix.^2+thetaYMatrix.^2 >= angleCutoff.^2;

%indMatrixCheck = obj.ThetaX'*obj.ThetaX+obj.ThetaY'*obj.ThetaY >= angleCutoff.^2;


%indMatrixCheck = obj.ThetaX'*obj.ThetaX+obj.ThetaY'*obj.ThetaY < angleCutoff.^2;

%[indexPosX,indexPosY] = find(obj.ThetaX'*obj.ThetaX+obj.ThetaY'*obj.ThetaY >= angleCutoff.^2);
%indexNeg = find(obj.Theta <= -angleCutoff);

if strcmp(howCalcHaze, 'trapz')
  hazeAnglePositive = trapz(obj.ThetaY, trapz(obj.ThetaX, obj.NormalizedIntensity.*indMatrix, 2));
  
  
  %   hazeAngleDirect = trapz(obj.ThetaY, trapz(obj.ThetaX, obj.NormalizedIntensity.*indMatrixCheck, 2));
  hazeAngleTotal = trapz(obj.ThetaX, trapz(obj.ThetaY, obj.NormalizedIntensity));
%   (hazeAnglePositive+hazeAngleDirect)/hazeAngleTotal
%  hazeAngleNegative = trapz(obj.Theta(indexNeg), obj.NormalizedIntensity(indexNeg));
%   obj.HazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
%     trapz(obj.Theta, obj.NormalizedIntensity);
  obj.HazeAngle = hazeAnglePositive/hazeAngleTotal;
elseif strcmp(howCalcHaze, 'sum')
  % only use this if delta functions
  hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos));
  %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
  obj.HazeAngle = hazeAnglePositive/...
    sum(obj.NormalizedIntensity);
%   obj.HazeAngle = (hazeAnglePositive+hazeAngleNegative)/...
%     sum(obj.NormalizedIntensity);
% elseif strcmp(howCalcHaze, 'trapzSpherical') 
%   hazeAnglePositive = trapz(obj.Theta(indexPos).*sin(deg2rad(obj.Theta(indexPos))), obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
%   %hazeAngleNegative = sum(obj.NormalizedIntensity(indexNeg));
%   obj.HazeAngle = hazeAnglePositive/...
%     trapz(obj.Theta.*sin(deg2rad(obj.Theta)), obj.NormalizedIntensity.*sin(deg2rad(obj.Theta)));
% elseif strcmp(howCalcHaze, 'sumSpherical')
%   hazeAnglePositive = sum(obj.NormalizedIntensity(indexPos).*sin(deg2rad(obj.Theta(indexPos))));
%   obj.HazeAngle = hazeAnglePositive/...
%     sum(obj.NormalizedIntensity.*sin(deg2rad(obj.Theta(indexPos))));
end


end

