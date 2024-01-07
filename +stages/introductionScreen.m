function introductionScreen(window, colors, settings)
%INTRODUCTIONSCREEN Shows first 3 introduction screens (possible to switch between them)

% Define texts
title = 'Introduction';
mainText1 = 'You will see a stream of letters flashed onto the screen one at\na time at a fast pace.';
mainText2line1 = 'Some of these letters require you to press the SPACEBAR.\n';
mainText2line2 = 'These letters are called <b>"targets".<b>\n\n';
mainText2line3 = 'Other letters require you to simply wait for the next letter.';
mainText3line1 = 'You will be asked to work through different tasks that have\nslightly different rules when to press the SPACEBAR.\n\n';
mainText3line2 = 'You will always be told the rules and you will always get the\nchance to practice each new rule before the test.\n\n';
mainText3line3 = 'Press Spacebar to learn about your first task.';

% Define an initial state in the Introduction block
state = 1;

% Start a loop for showing the introduction part
while state < 4
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

    % Draw main text in the middle of the screen, depends on the state
    Screen('TextSize', window, settings.mainTextSize);
    switch state
        case 1
            DrawFormattedText(window, mainText1, 'center', 'center', colors.black);
        case 2
            DrawFormattedText2([mainText2line1 mainText2line2 mainText2line3], 'win', window, 'sx', 'center', 'sy', 'center', ...
                'xalign','center','yalign','center', 'xlayout','center', 'baseColor', colors.black);
        case 3
            DrawFormattedText(window, [mainText3line1 mainText3line2 mainText3line3], 'center', 'center', colors.black);    
    end

    % Draw lines around the title
    DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
    DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

    % Draw title at the top of the screen
    Screen('TextSize', window, settings.titleSize);
    DrawFormattedText(window, title, 'center', settings.titlePosition, colors.black);

    % Draw text with backward and forward buttons
    Screen('TextSize', window, settings.lowerTextSize);
    DrawFormattedText(window, settings.forwardKeyText, settings.lowerRightPosition, settings.lowerTextPosition, colors.black);
    if state > 1
        DrawFormattedText(window, settings.backwardKeyText, settings.lowerLeftPosition, settings.lowerTextPosition, colors.black);
    end

    % Update the screen
    Screen('Flip', window);

end

end