function ruleChangeScreen(window, colors, settings)
%RULECHANGESCREEN Shows the 'Rule Change' screen

% Define texts
title = 'Rule Change!';
mainText = 'Read the instructions for the next section carefully as the rules\nwill change.';

% Draw main text in the middle of the screen
Screen('TextSize', window, settings.mainTextSize);
DrawFormattedText(window, mainText, 'center', 'center', colors.black);

% Draw lines around the title
DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

% Draw title at the top of the screen
Screen('TextSize', window, settings.titleSize);
DrawFormattedText(window, title, 'center', settings.titlePosition, colors.red);

% Draw text with forward button
Screen('TextSize', window, settings.lowerTextSize);
DrawFormattedText(window, settings.forwardKeyText, settings.lowerRightPosition, settings.lowerTextPosition, colors.black);

% Update the screen
Screen('Flip', window);

% Waits until forward key is pressed
while 1
    [~,~, keyCode] = KbCheck;
    if keyCode(settings.forwardKey)
        KbReleaseWait;
        break
    end
end

end