function [v, idx] = grid_to_vec(G)
%GRID_TO_VEC  Swap grid format to vector format.
%
% Syntax:
%   [v, idx] = grid.grid_to_vec(G);
%
% Inputs:
%   G -   Gridded arrangement of elements of vector, where first element
%         starts at bottom left and last element goes into the top-right.
%
% Output:
%   v   - Vector (numeric or string or whatever)
%   idx - Indices of elements of `G` in v (also arranged as a vector).
%
% See also: Contents, grid, 
%   grid.array_to_grid, grid.vec_to_grid, grid.grid_to_array

if numel(G) ~= 64
    error('This only works for 8x8 grids (64 elements!)');
end

idx = flipud(reshape(1:64, 8, 8));
idx = idx(:);
v = G(idx);
end