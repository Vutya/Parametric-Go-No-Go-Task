function taskStructure = generateTaskStructure(subjectNumber)
%GENERATETASKSTRUCTURE Generates trial sequence with the subject number as
%random seed.
%   Returns structure with trial sequences and their codes for levels 1, 2,
%   and 3.

% set subject number as a random seed number for reproducibility
rng(subjectNumber);

%% INFO ON THE NUMBER OF STIMULI PER LEVEL AND TARGET/NON-TARGET LETTERS
% number of trials per level and type of trials (i.e., target-non-target, or lure trials)
NUM_TARGETS_LEVEL_1 = 33;
NUM_NONTARGETS_LEVEL_1 = 181;

NUM_TARGETS_LEVEL_2 = 33;
NUM_NONTARGETS_LEVEL_2 = 170;
NUM_LURES_LEVEL_2 = 9;

NUM_TARGETS_LEVEL_3 = 52;
NUM_NONTARGETS_LEVEL_3 = 256;
NUM_LURES_LEVEL_3 = 14;

% target and non-target letters used in the task (separately for Level 2)
letters = 'a':'z';
nonTargets = letters(1:end-3);
targets = letters(end-2:end);
targets2 = letters(end-2:end-1);

%% Generate trial sequeces for all 3 Levels and save to structure
[trialSequence1, codeIndices1] = tools.generateTrialSequence(targets, nonTargets, ...
    NUM_TARGETS_LEVEL_1, NUM_NONTARGETS_LEVEL_1);
[trialSequence2, codeIndices2] = tools.generateTrialSequence(targets2, nonTargets, ...
    NUM_TARGETS_LEVEL_2, NUM_NONTARGETS_LEVEL_2, NUM_LURES_LEVEL_2);
[trialSequence3, codeIndices3] = tools.generateTrialSequence(targets, nonTargets, ...
    NUM_TARGETS_LEVEL_3, NUM_NONTARGETS_LEVEL_3, NUM_LURES_LEVEL_3);

taskStructure = struct('trialSequence1', trialSequence1, 'codeIndices1', codeIndices1, ...
    'trialSequence2', trialSequence2, 'codeIndices2', codeIndices2, ...
    'trialSequence3', trialSequence3, 'codeIndices3', codeIndices3);

end