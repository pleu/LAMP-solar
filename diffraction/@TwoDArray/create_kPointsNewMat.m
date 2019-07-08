function [kPointsNewMat] = create_kPointsNewMat(obj, kxGrid, kyGrid)
%CREATE_KPOINTSNEWMAT Summary of this function goes here
%   Detailed explanation goes here
kPoints = [kxGrid(:) kyGrid(:)];

kPointsNew = (obj.ReciprocalLattice'\kPoints')';
kPointsNewMat(:, :, 1) = reshape(kPointsNew(:, 1), size(kxGrid));
kPointsNewMat(:, :, 2) = reshape(kPointsNew(:, 2), size(kxGrid));


end

