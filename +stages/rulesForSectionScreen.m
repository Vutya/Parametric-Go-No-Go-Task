function rulesForSectionScreen(window, colors, settings, level)
%RULESFORSECTIONSCREEN Shows rules for the section, based on the level

% Define texts
title = 'Rules for this Section:';
mainText1_1 = 'Press the SPACEBAR every time you see the letter <b>"x"<b>, <b>"y"<b>, or\n<b>"z"<b>.\n\nIt does not matter what order you see them in.';
mainText1_2 = 'Do <b>NOT<b> press the SPACEBAR for any letter other than "x", "y",\nor "z".';
mainText2_1line1 = 'Press the SPACEBAR every time you see the letter <b>"x"<b> or the\n';
mainText2_1line2 = 'letter <b>"y"<b> BUT only if they are not repeating the previous target\nletter.\n\n';
mainText2_1line3 = 'Do <b>NOT<b> press the SPACEBAR for any other letter.';
mainText2_2 = 'You never want to respond to the same target twice in a row,\nso you need to remember the last target letter you responded to.';
mainText3_1line1 = 'Press the SPACEBAR every time you see the letter <b>"x"<b>, <b>"y"<b>, or\n';
mainText3_1line2 = '<b>"z"<b> BUT only if they are not repeating the previous target letter.\n\n';
mainText3_1line3 = 'Do <b>NOT<b> press the SPACEBAR for any other letter.';
mainText3_2 = 'You never want to respond to the same target twice in a row,\nso you need to remember the last target letter you responded to.';

% Saving text in the single cell array for easier indexing
instructions = {
    {mainText1_1, mainText1_2}, ...
    {[mainText2_1line1, mainText2_1line2, mainText2_1line3], mainText2_2}, ...
    {[mainText3_1line1, mainText3_1line2, mainText3_1line3], mainText3_2}
};

% Define an initial state in the block
state = 1;

% Start a loop for showing the block
while state < 3
    % Draw main text in the middle of the screen, depends on the state and
    % the current level
    Screen('TextSize', window, settings.mainTextSize);
    DrawFormattedText2(instructions{level}{state}, 'win', window, 'sx', 'center', 'sy', 'center', ...
        'xalign','center','yalign','center', 'baseColor', colors.black);

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

end