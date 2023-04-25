function [T, channel] = grid_to_tensor(Gt)
%GRID_TO_TENSOR  Swap grid format to tensor format.
%
% Syntax:
%   [T, channel] = grid.grid_to_tensor(Gt);
%
% Inputs:
%   Gt -   Gridded arrangement of elements of vector, where first element
%         starts at bottom left and last element goes into the top-right.
%         This should be a 4-D matrix, where the last dimension represents
%         a new trial or data frame or something. The third dimension is
%         time samples. The first two are rows and columns (spatially on a
%         grid). 
%
% Output:
%   T       - Tensor (numeric or string or whatever, should be 64 x nSamples x nTrials). 
%   channel - Can be used to confirm that channels are returned as expected
%
% See also: Contents, grid, 
%   grid.array_to_grid, grid.vec_to_grid, grid.grid_to_array

if size(Gt,1)*size(Gt,2) ~= 64
    error('This only works for 8x8 grids (64 elements!)');
end

ch = flipud(reshape(1:64, 8, 8));
channel = repelem(ch, 1, size(Gt,3), size(Gt,4));
% [row,col] = meshgrid(8:-1:1,1:8);
T = nan(64, size(Gt,3), size(Gt,4));
% T = reshape(Gt(row(ch(:)),col(ch(:)),:,:), 64, size(Gt,3), size(Gt,4));
for ii = 1:64
%     idx = find(ch == ii, 1, 'first');
    T(ii,:,:) = reshape(Gt(channel == ii), 1, size(Gt,3), size(Gt,4));
end





end