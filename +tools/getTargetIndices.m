function [targetIndices, lureIndices, codeIndices] = getTargetIndices(totalNumTrials, totalTargets, numLures)
%GETTARGETINDICES Generates indices of all targets (including lure trials)
%   Generates trials indices and their codes.
%
%   Codes of trials in code indices:
%   1 - non-target trial
%   2 - target trial
%   3-  lure trial
%
%   INPUT: totalNumTrials, totalTargets (lure + targets), numLureTrials
%   OUTPUT: targetIndices - list of all targets' indices (including lures), 
%   lureIndices - list of all lure indices, codeIndices - codes for all
%   trials

% generate all targets' indices so that the first target comes no earlier
% than 4th trial, there is some space in the end, and there are no less
% than 2 trials between targets
% NOTE: might take some time, but reasonable
newIndex = randi(totalNumTrials, 1);
while (newIndex < 4) || (newIndex > totalNumTrials - 3)
    newIndex = randi(totalNumTrials, 1);
end
targetIndices = newIndex;
for i = 2:totalTargets
    newIndex = randi(totalNumTrials, 1);
    while (newIndex < 4) || (newIndex > totalNumTrials - 3) || (min(diff(sort([targetIndices newIndex]))) <= 2)
        newIndex = randi(totalNumTrials, 1);
    end
    targetIndices = sort([targetIndices newIndex]);
end

% get a subsample from target indices to mark them as lure trials
if numLures > 0
    lureIndices = sort(randsample(targetIndices(2:end), numLures));
else
    lureIndices = [];
end

% creating codes for trials based on indices
codeIndices = ones(1,totalNumTrials);
codeIndices(targetIndices) = codeIndices(targetIndices) + 1;
codeIndices(lureIndices) = codeIndices(lureIndices) + 1;

end