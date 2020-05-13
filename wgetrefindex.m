function refIndex = wgetrefindex(foreignKey, refKey)
% get_refindex    Returns index of `refKey` referred by `foreignKey`
%
% This file is a part of BrainDecoderToolbox2.
%
% Inputs:
%
% - foreignKey
% - refKey
%
% Outputs:
%
% - refIndex
%

%% Input check
if ~isvector(foreignKey)
    error('Foreign key must be a vector');
end
if ~isvector(refKey)
    error('Referenced key must be a vector');
end

if length(refKey) ~= length(unique(refKey))
    error('Referenced keys should be a primary keys (i.e., they should be unique each other)');
end

%% Main
refIndex = nan(size(foreignKey));

if iscellstr(refKey)
    for i = 1:length(foreignKey)
        hitIndex = find(strcmp(refKey, foreignKey{i}));
        refIndex(i) = hitIndex;
    end
else
    for i = 1:length(foreignKey)
        hitIndex = find(refKey == foreignKey(i));
        refIndex(i) = hitIndex;
    end
end
