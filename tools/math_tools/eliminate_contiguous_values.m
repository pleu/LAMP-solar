function [x, y] = eliminate_contiguous_values(x, y, gridDistanceX, gridDistanceY)
% Input:
%   X: d x n data matrix
data = [x; y]';

gridDistance = sqrt(gridDistanceX^2 + gridDistanceY^2);
% 
% D = pdist(data);
% Z = linkage(D);
% 
% Z = Z(Z(:, 3) < gridDistance, :);

T = clusterdata(data,'cutoff', gridDistance, 'criterion', 'distance');
dataKeep = ones(length(data), 1);
for ind = 1:max(T)
  indRemove = find(T == ind);
  dataKeep(indRemove(2:length(indRemove))) = 0;
end

x = x(dataKeep==1);
y = y(dataKeep==1);


%T = cluster(Z,'cutoff',0.2)

%G = graph(Z(:, 1), Z(:, 2));



