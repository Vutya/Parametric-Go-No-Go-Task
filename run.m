function run(subjectNumber)
%RUN Prepares and runs the whole experiment as a sequence of screens

%% Some preparation beforehand
% if there is subject with this number then assertion
dirname = fullfile('data', 'subj_' + string(subjectNumber));
assert(~exist(dirname, 'dir'), 'Subject with this number already exists!');
mkdir(dirname);

% Display message claiming task preparation
disp('The task is being prepared...');

% generate task structure for all 3 levels
taskStructure = generateTaskStructure(subjectNumber);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(1);

% Select Screen
screenNr  = min(Screen('Screens'));

% Define colors
colors = struct('black', [0, 0, 0], 'white', [255, 255, 255], ...
    'red', [255, 0  , 0  ], 'green', [0  , 120, 0  ]);

% Synchronization tests for better timing
Screen('Preference', 'SyncTestSettings', 0.001);

% Open an on screen window and color it white
[window, ~] = PsychImaging('OpenWindow', screenNr, colors.white);

% Hiding mouse cursor
HideCursor(screenNr);

% Get Screen settings (font size, text positions, etc)
settings = tools.getScreenSettings(window);

%% Main sequence of Screens in the experiment
stages.introductionScreen(window, colors, settings);
stages.rulesForSectionScreen(window, colors, settings, 1)
stages.practiceScreen(window, colors, settings, 1);
stages.testStartScreen(window, colors, settings);
results{1} = stages.testScreen(window, colors, settings, 1, taskStructure.trialSequence1, taskStructure.codeIndices1);
stages.ruleChangeScreen(window, colors, settings);
stages.rulesForSectionScreen(window, colors, settings, 2)
stages.practiceScreen(window, colors, settings, 2);
stages.testStartScreen(window, colors, settings);
results{2} = stages.testScreen(window, colors, settings, 2, taskStructure.trialSequence2, taskStructure.codeIndices2);
stages.ruleChangeScreen(window, colors, settings);
stages.rulesForSectionScreen(window, colors, settings, 3)
stages.practiceScreen(window, colors, settings, 3);
stages.testStartScreen(window, colors, settings);
results{3} = stages.testScreen(window, colors, settings, 3, taskStructure.trialSequence3, taskStructure.codeIndices3);
stages.feedbackScreen(window, colors, settings, results);
stages.thanksScreen(window, colors, settings);

% Clear screen at the end of the task
sca;

%% Saving the results
save(fullfile(dirname, "results.mat"), "results");

end
