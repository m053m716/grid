function D = apply_double_differential_to_tensor(T)
%APPLY_DOUBLE_DIFFERENTIAL_TO_TENSOR Applies double-differential along columns of tensor channels.
%
% Syntax:
%   D = grid.apply_double_differential_to_tensor(T);
%
% Inputs:
%   T - nChannels x nSamples x nTrials or nSamples x nChannels x nTrials
%           tensor of data that you want to apply double-differential to.
%
% Output:
%   D - The differential signal. First and last "rows" of channels are set
%       to NaN to preserve the number of apparent channels in the matrix.

apply_transpose = size(T, 1)~=64;
if apply_transpose
    T = pagetranspose(T);
end
G = grid.array_to_grid(T); % This works for array or tensor.
dd = vertcat(nan(1,8,size(G,3),size(G,4)), diff(G, 2, 1), nan(1,8,size(G,3),size(G,4)));
D = grid.grid_to_tensor(dd);
if apply_transpose
    D = pagetranspose(D);
end

end