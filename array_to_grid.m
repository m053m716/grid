function [G, idx] = array_to_grid(A)
%ARRAY_TO_GRID  Swap sample array format to grid (tensor) format.
%
% Syntax:
%   [G, idx] = grid.array_to_grid(A);
%
% Example:
%   A = repmat((1:64)', 1, 5) + (0.1:0.1:0.5); % Decimal indicates sample
%   [G, idx] = grid.array_to_grid(A);
%
% Inputs:
%   A - Array (numeric or string or whatever); it should be arranged as
%       nChannels x nSamples.
%
% Output:
%   G -   Gridded arrangement of elements of array, where first element
%         starts at bottom left and last element goes into the top-right.
%   idx - Indices of elements of `v` in G (also arranged as a grid).
%
% See also: Contents, grid, 
%   grid.array_to_grid, grid.grid_to_vec, grid.grid_to_array

if size(A, 1) ~= 64
    A = pagetranspose(A);
    if size(A,1) ~= 64
        error('This only works for 8x8 grids (64 elements!)');
    end
end
idx = flipud(reshape(1:64, 8, 8));
% Reshape so we have an indexing grid of identical elements (through time),
% and then add a "step" array to the third dimension (so, time), which
% steps the sample increment by 64 elements for each time-sample such that
% the indexing works correctly:
idx = repmat(idx, 1, 1, size(A, 2)) + ... % This is the "address" of each row from the sample matrix (nChannels x nSamples)
             reshape(0:64:((size(A,2)-1)*64), 1, 1, size(A, 2)); % This is the spot in our (nRow x nColumn x nSamples) grid array (tensor) where each sample should go.
switch numel(size(A))
    case 2 % nChannels x nSamples
        G = A(idx);
    case 3 % nChannels x nSamples x nTrials
        idx = repmat(idx, 1, 1, 1, size(A, 3)) + ...
            reshape(0:(64 * size(A, 2)):((size(A,3)-1)*64*size(A,2)), 1, 1, 1, size(A, 3));
        G = A(idx);
    otherwise
        error('Unexpected number of dimensions on input array (%d)', numel(size(A)));
end

end
