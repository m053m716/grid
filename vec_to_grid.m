function [G, idx] = vec_to_grid(v)
%VEC_TO_GRID  Swap vector format to grid format.
%
% Syntax:
%   [G, idx] = grid.vec_to_grid(v);
%
% Inputs:
%   v - Vector (numeric or string or whatever)
%
% Output:
%   G -   Gridded arrangement of elements of vector, where first element
%         starts at bottom left and last element goes into the top-right.
%   idx - Indices of elements of `v` in G (also arranged as a grid).
%
% See also: Contents, grid, 
%   grid.array_to_grid, grid.grid_to_vec, grid.grid_to_array

if numel(v) ~= 64
    error('This only works for 8x8 grids (64 elements!)');
end

idx = flipud(reshape(1:64, 8, 8));
G = v(idx);

end