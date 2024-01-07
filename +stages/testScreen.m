function results = testScreen(window, colors, settings, level, trialSequence, trialCodes)
%TESTSCREEN Shows rule reminder and main task

% Define texts
title = 'Rule Reminder';
mainTextLine1 = {'1. Press SPACEBAR to <b>"x"<b>, <b>"y"<b> and <b>"z"<b>\n\n', ...
    '1. Press the SPACEBAR every time you see the letter <b>"x"<b> or the letter <b>"y"<b> BUT only\n\nif they are <b>not repeating<b> the previous target letter\n\n', ...
    '1. Press the SPACEBAR for <b>"x"<b>, <b>"y"<b> and <b>"z"<b> IF they are <b>not\n\nrepeating<b> the previous target\n\n'};
mainTextLine2 = '2. Do <b>NOT<b> press the SPACEBAR for any other letter\n\n\n';
testStartText = '<i>Test will start automatically<i>';

%% Rule Reminder block
% Draw main text in the middle of the screen, depends on the state and
% the current level
Screen('TextSize', window, settings.mainTextSize);
DrawFormattedText2(strcat(mainTextLine1{level}, mainTextLine2, testStartText), 'win', window, ...
    'sx', 'center', 'sy', 'center', 'xalign','center','yalign','center', 'baseColor', colors.black);

% Draw lines around the title
DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

% Draw title at the top of the screen
Screen('TextSize', window, settings.titleSize);
DrawFormattedText(window, title, 'center', settings.titlePosition, colors.black);

% Update the screen and show for 8 seconds
Screen('Flip', window);
WaitSecs(8);

%% Main block

% Draw cross trial for 1 second
Screen('TextSize', window, settings.trialTextSize);
DrawFormattedText(window, '+', 'center', 'center', colors.black);
Screen('Flip', window);
WaitSecs(1);

% Flag for pressed key
alreadyPressed = false;

% Lists to save responses and RTs (0 for not pressed, changed if pressed)
responses = zeros([1 numel(trialSequence)]);
RTs = zeros([1 numel(trialSequence)]);

% Go over trials
for i = 1:numel(trialSequence)
    % Draw letter
    DrawFormattedText(window, trialSequence(i), 'center', 'center', colors.black);
    Screen('Flip', window);

    % Display trial and save the response and RT if pressed
    startTime = GetSecs;
    while GetSecs - startTime < 0.5
        [keyIsDown,~, keyCode] = KbCheck;
        if alreadyPressed && ~keyIsDown
            alreadyPressed = false;
        end
        if keyCode(settings.responseKey)
            if ~alreadyPressed && keyIsDown
                alreadyPressed = keyIsDown;
                responses(i) = 1;
                RTs(i) = GetSecs - startTime;
            end
        end
    end
end

% Save results
allTargetResponses = responses(trialCodes==2);
allLureResponses = responses(trialCodes==3);

results.responses = responses;
results.level = level;
results.RTs = RTs;
results.trialSequence = trialSequence;
results.trialCodes = trialCodes;
results.meanRT = round(mean(RTs(RTs ~= 0)), 4);
results.correctTarget = round(sum(allTargetResponses)/numel(allTargetResponses), 4);
if level > 1
    results.correctSuppression = 1 - round(sum(allLureResponses)/numel(allLureResponses), 4);
end

end