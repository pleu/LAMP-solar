function [y] = remove_largest_y_shift_value(x, y, region, minX, maxX)
% identifies a transition region and a shift region
% shifts the y values in the shift region up
% shifts the values in the transition to match that at the end of the 
% transition region
% for before
% | ----   shift region ----- | ---- transition region-- | final region

% for after
% | ----   beginning region ----- | ---- transition region-- | shift region


% currently only shifts region before jump upward;

descending = 0;
if x(2) < x(1)
  descending = 1;
  x = x(end:-1:1);
  y = y(end:-1:1);
  % ascending
%[x,xInd] = sort(x);
%y = y(xInd);
end

if nargin == 3
  minX = min(x);
  maxX = max(x);
end

ySmaller = y(x <= minX);
yLarger = y(x >= maxX);

xFind = x(x > minX & x < maxX);
yFind = y(x > minX & x < maxX);

if strcmpi(region, 'before')
  dY = diff(yFind);
  [maxVal, maxInd] = max(dY);
  valuesNear = 5;
  dYNear = dY(maxInd-valuesNear:maxInd+valuesNear);
  
  indCross = find(dYNear(1:end-1).*dYNear(2:end) < 0); % get points where sign changes
  distance = valuesNear+1 - indCross;
  [firstCross] = min(distance(distance > 0));
  [secondCross] = max(distance(distance < 0));
  
  firstCrossLocal = valuesNear+1-firstCross;
  secondCrossLocal = valuesNear+1-secondCross;
  transitionLocal = firstCrossLocal:secondCrossLocal;
  
  shiftVal = sum(dYNear(transitionLocal));
  transitionRegion = maxInd-firstCross+1:maxInd-secondCross+1;
  shiftRegion = 1:maxInd-firstCross;

  yFind(shiftRegion) = yFind(shiftRegion)+shiftVal;
  yFind(transitionRegion) = yFind(max(transitionRegion)+1);
elseif strcmpi(region, 'after')
  % find differences in Y
  dY = diff(yFind);
  [maxVal, maxInd] = max(abs(dY));
  valuesNear = 5;
  dYNearInd = maxInd-valuesNear:maxInd+valuesNear;
  dYNear = dY(dYNearInd);
  
  
  
  figure(6);
  clf;
  plot(xFind(1:end-1), dY, 'o')
  plot(xFind(maxInd-valuesNear:maxInd+valuesNear), dY(maxInd-valuesNear:maxInd+valuesNear), '-o');
  
  figure(7);
  clf;
  %plot(xFind(1, dY, 'o')
  plot(xFind(maxInd-valuesNear:maxInd+valuesNear), yFind(maxInd-valuesNear:maxInd+valuesNear), '-o');

  
  indCross = find(dYNear(1:end-1).*dYNear(2:end) < 0); % get points where sign changes
  [maxValNear, maxIndNear] = max(abs(dYNear));
  
  distance = maxIndNear - indCross;
  [firstCross] = min(distance(distance > 0));
  %   [secondCross] = max(distance(distance < 0));
  %
  firstCrossLocal = maxIndNear-firstCross;
  %   secondCrossLocal = valuesNear+1-secondCross;
  transitionLocalInd = firstCrossLocal:maxIndNear;
  %shiftLocalInd = maxIndNear+1:length(dYNearInd);

  %crossBeforeMaxInd = max
  %shiftVal = sum(dYNear(transitionLocalInd));
  transitionRegionInd = dYNearInd(transitionLocalInd);
  %transitionRegion = maxInd-firstCross+1:maxInd-secondCross+1;
  %shiftRegion = 1:maxInd-firstCross;
  %shiftRegion = maxInd-firstCross:length(yFind);
  shiftRegionInd = dYNearInd(maxIndNear+1):length(yFind);
  
  shiftAverageIndex = 5;
  % instead of shifting maximum y change; maybe average over the region 
  shiftAfter = mean(yFind(shiftRegionInd(1):shiftRegionInd(1)+shiftAverageIndex));
  shiftBefore = mean(yFind(transitionRegionInd(end)-5:transitionRegionInd(end)));
  shiftVal = shiftAfter - shiftBefore;
  yFind(shiftRegionInd) = yFind(shiftRegionInd)-shiftVal;
  yFind(transitionLocalInd) = yFind(shiftRegionInd(1));
end
yLarger = yLarger - shiftVal;

y = [ySmaller yFind yLarger];

if descending
  y = y(end:-1:1);
end

