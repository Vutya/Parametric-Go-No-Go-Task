function thanksScreen(window, colors, settings)
%THANKSSCREEN Shows last thanks screen

% Define texts
mainText = 'Thank you!';
lowerText = '<press spacebar to exit>';

% define a key for exit
exitKey = KbName('space');

% Draw text in the middle of the screen
Screen('TextSize', window, settings.titleSize);
DrawFormattedText(window, mainText, 'center', 'center', colors.black);

% Text in the bottom of the screen
Screen('TextSize', window, settings.lowerTextSize);
DrawFormattedText(window, lowerText, 'center', settings.lowerTextPosition, colors.black);

% Update the screen
Screen('Flip', window);

% This is the cue which determines whether we exit the demo
exitFlag = false;

% Loop the animation until the escape key is pressed
while exitFlag == false
    % Check the keyboard to see if a button has been pressed
    [~,~, keyCode] = KbCheck;

    % Exit if exitKey is pressed
    if keyCode(exitKey)
        exitFlag = true;
    end
end

end