function [Xt, triggers, iBad] = triggered_array(X, triggers, n_pre, n_post)
%TRIGGERED_ARRAY  Convert X from array to triggered array snippets
%
% Syntax:
%   Xt = grid.triggered_array(X, triggers, n_pre, n_post);
%
% Inputs:
%   X - nSamples x nChannels array
%   triggers - Sample indices array of which samples to use as triggers
%   n_pre - Number of samples before trigger to use
%   n_post - Number of samples after each trigger to use
%
% Output:
%   Xt - nChannels x [nPre + nPost + 1] x nTriggers tensor of samples
%        in array around each trigger (stimulus)
%
% See also: Contents

vec = -n_pre : n_post;
triggers = reshape(triggers, numel(triggers), 1);
idx = (vec + triggers)';
iBad = any(idx < 1, 1) | any(idx > size(X, 1), 1);
idx(:, iBad) = [];
triggers(iBad) = [];

nSamples = size(X, 1);
nChannels = size(X, 2);
nEpoch = numel(vec);
nTrigs = numel(triggers);

idx = reshape(idx, 1, nEpoch, nTrigs);
Xt = nan(nChannels, nEpoch, nTrigs);

for iCh = 1:nChannels
    Xt(iCh, :, :) = X(idx + nSamples * (iCh - 1));
end

end