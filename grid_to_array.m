function [A, idx] = grid_to_array(G)
%GRID_TO_ARRAY  Swap grid format to array format (nChannels x nSamples).
%
% Syntax:
%   [A, idx] = grid.grid_to_array(G);
%
% Inputs:
%   G -   Gridded arrangement of elements of vector, where first element
%         starts at bottom left and last element goes into the top-right.
%
% Output:
%   A   - Array (numeric or string or whatever, should be 64 x nSamples array). 
%   idx - Indices of elements of `G` in V (also arranged as an array).
%
% See also: Contents, grid, 
%   grid.array_to_grid, grid.vec_to_grid, grid.grid_to_array

if size(G,1)*size(G,2) ~= 64
    error('This only works for 8x8 grids (64 elements!)');
end

idx = flipud(reshape(1:64, 8, 8));
idx = repmat(idx(:), 1, size(G, 3)) + ... % Create copies for each time sample
      repmat(0:64:((size(G, 3)-1)*64), 64, 1);  % Need to advance the indexing through time though.
A = G(idx);
end