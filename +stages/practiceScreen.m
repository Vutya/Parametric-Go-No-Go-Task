function practiceScreen(window, colors, settings, level)
%PRACTICESCREEN Shows rule reminder and practice before the main task for
%each level

% Define texts
titles = {'Practice', 'Rule Reminder'};
practiceText = '<b>Let''s practice this task.<b>\n\nFor practice the letters will be presented at a slightly slower\npace than during the actual test. Feedback and prompts will\nbe given during practice only.';
reminderLevelText = {'1. Press SPACEBAR to <b>"x"<b>, <b>"y"<b> and <b>"z"<b>\n\n', ...
    '1. Press SPACEBAR for <b>"x"<b> and <b>"y"<b> IF they are <b>not\nrepeating<b> the previous target.\n\n', ...
    '1. Press SPACEBAR for <b>"x"<b>, <b>"y"<b> and <b>"z"<b> if they are <b>not\nrepeating<b> the previous target.\n\n'};
reminderCommonText = '2. Don''t press the Spacebar for other letters.\n\n\n';
reminderBottomText = '<i>Press Spacebar to start practice.<i>';
positiveFeedback = 'Well done!';
negativeFeedback1 = 'You should have pressed the <SPACEBAR>'; 
negativeFeedback2 = 'You shouldn''t have pressed the <SPACEBAR>'; 
tooEarlyFeedback = 'Pressing the <SPACEBAR> was INCORRECT';
positiveCue = 'Press the SPACEBAR';
redCue = '!!!REPEAT. Do NOT respond!!!';
upperRedCue = 'Don''t press SPACEBAR for "';
contineKeyText = 'Press the ''C'' key to continue practice';

% target and non-target letters used in the task (separately for Level 2)
letters = 'a':'z';
nonTargets = letters(1:end-3);
if level == 2
    targets = 'xy';
else
    targets = 'xyz';
end

%% Rule Reminder block
% Define an initial state in the block
state = 1;

% Start a loop for showing the block
while state < 3
    % Draw main text in the middle of the screen, depends on the state and
    % the current level
    Screen('TextSize', window, settings.mainTextSize);
    switch state
        case 1
            DrawFormattedText2(practiceText, 'win', window, ...
                'sx', 'center', 'sy', 'center', 'xalign','center','yalign','center', 'baseColor', colors.black);
        case 2
            DrawFormattedText2(strcat(reminderLevelText{level}, reminderCommonText, reminderBottomText), 'win', window, ...
                'sx', 'center', 'sy', 'center', 'xalign','center','yalign','center', 'baseColor', colors.black);
    end

    % Draw lines around the title
    DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
    DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

    % Draw title at the top of the screen
    Screen('TextSize', window, settings.titleSize);
    DrawFormattedText(window, titles{state}, 'center', settings.titlePosition, colors.black);

    % Draw text with backward and forward buttons
    Screen('TextSize', window, settings.lowerTextSize);
    DrawFormattedText(window, settings.forwardKeyText, settings.lowerRightPosition, settings.lowerTextPosition, colors.black);
    if state > 1
        DrawFormattedText(window, settings.backwardKeyText, settings.lowerLeftPosition, settings.lowerTextPosition, colors.black);
    end

    % Check the pressed key
    [keyIsDown,~, keyCode] = KbCheck;

    if keyIsDown
        % Change state if necessary
        if keyCode(settings.backwardKey) && state > 1
            state = state - 1;
        elseif keyCode(settings.forwardKey)
            state = state + 1;
        end

        % waits until key is released, otherwise skips the instructions
        KbReleaseWait;
    end

    % Update the screen
    Screen('Flip', window);

end

%% Pracrice block
% Draw cross trial for 1 second
Screen('TextSize', window, settings.trialTextSize);
DrawFormattedText(window, '+', 'center', 'center', colors.black);
Screen('Flip', window);
WaitSecs(1);

% Define targets and total attempts for practice based on the level
switch level
    case 1
        targetsSequence = 'xyz';
        totalAttempts = 3;
    case 2
        targetsSequence = 'xyyx';
        totalAttempts = 4;
    case 3
        targetsSequence = 'xzzy';
        totalAttempts = 4;
end

% Counter for practice attempts
correctAttempts = 1;

while correctAttempts <= totalAttempts
    % Helping variable
    outcomeCode = 0;

    % Generate trials sequence so that there are no consequently repeated letters 
    numTrials = 1 + randi(4, 1);
    randomNonTargetIndices = randi(numel(nonTargets),[1 numTrials]);
    while min(abs(diff(randomNonTargetIndices))) == 0
        randomNonTargetIndices = randi(numel(nonTargets),[1 numTrials]);
    end
    practiceTrialSequence = strcat(nonTargets(randomNonTargetIndices), targetsSequence(correctAttempts));

    % Flag if previous letter is the same
    samePreviousLetter = (correctAttempts > 1) && (targetsSequence(correctAttempts) == targetsSequence(correctAttempts - 1));

    % Go through trials
    for i = 1:numel(practiceTrialSequence)
        % Draw letter
        letter = practiceTrialSequence(i);
        Screen('TextSize', window, settings.trialTextSize);
        DrawFormattedText(window, letter, 'center', 'center', colors.black);

        % Draw red cue above
        Screen('TextSize', window, settings.mainTextSize);
        if correctAttempts > 1 && level > 1
            currentRedCue = strcat(upperRedCue, targetsSequence(correctAttempts - 1),'"');
            DrawFormattedText(window, currentRedCue, 'center', settings.titlePosition, colors.red);
        end

        % Draw cue at the bottom of the screen for the last trial
        if i == numel(practiceTrialSequence)
            if samePreviousLetter
                DrawFormattedText(window, redCue, 'center', settings.lowerTextPosition, colors.red);
            else
                DrawFormattedText(window, positiveCue, 'center', settings.lowerTextPosition, colors.green);
            end
        end

        % Update screen
        Screen('Flip', window);

        % Draw practice trial for 1 second or until response
        tic
        while toc < 1  
            [~,~, keyCode] = KbCheck;

            if keyCode(settings.responseKey)
                if i == numel(practiceTrialSequence) && ~samePreviousLetter
                    outcomeCode = 1;
                elseif i == numel(practiceTrialSequence) && samePreviousLetter
                    outcomeCode = 2;
                elseif i < numel(practiceTrialSequence)
                    outcomeCode = 3;
                end
                break;
            end
        end

        % Stop the loop if the response is given
        if outcomeCode > 0
            break
        end
    end

    % Draw feedback screen
    switch outcomeCode
        case 0
            if samePreviousLetter
                DrawFormattedText(window, positiveFeedback, 'center', settings.titlePosition, colors.black);
            else
                DrawFormattedText(window, negativeFeedback1, 'center', settings.titlePosition, colors.black);
            end
        case 1
            DrawFormattedText(window, positiveFeedback, 'center', settings.titlePosition, colors.black);
        case 2
            DrawFormattedText(window, negativeFeedback2, 'center', settings.titlePosition, colors.black);
        case 3
            DrawFormattedText(window, tooEarlyFeedback, 'center', settings.titlePosition, colors.black);
    end

    % Additional helpful info for feedback
    if level > 1 && correctAttempts > 1
        helpText = strcat('you don''t want to respond to another "', practiceTrialSequence(end), '"', ...
            '\nuntil after you respond to another target letter.\n\nTargets:\n', targets);
        DrawFormattedText(window, helpText, 'center', 'center', colors.red);
    end

    % Draw text with continue key
    Screen('TextSize', window, settings.lowerTextSize);
    DrawFormattedText(window, contineKeyText, 'center', settings.lowerTextPosition, colors.black);

    % Update screen and wait for key press 'c'
    Screen('Flip', window);

    while 1
        [~,~, keyCode] = KbCheck;

        if keyCode(KbName('c'))
            if (outcomeCode == 1) || (outcomeCode == 0 && samePreviousLetter)
                correctAttempts = correctAttempts + 1;
            end
            break;
        end
    end
end

end
