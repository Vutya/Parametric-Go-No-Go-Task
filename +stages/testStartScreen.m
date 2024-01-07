function testStartScreen(window, colors, settings)
%TESTSTARTSCREEN Shows Test Start screen

% Define texts
title = 'Test Start';
line1 = 'The actual task is about to start.\n\n';
line2 = 'There will be no prompts nor feedback.\n\n';
line3 = 'Test Reminder will appear momentarily.';

% Draw title at the top of the screen
Screen('TextSize', window, settings.titleSize);
DrawFormattedText(window, title, 'center', settings.titlePosition, colors.black);

% Draw main text in the middle of the screen
Screen('TextSize', window, settings.mainTextSize);
DrawFormattedText(window, [line1 line2 line3], 'center', 'center', colors.black);

% Draw lines around the title
DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

% Update the screen
Screen('Flip', window);

% Keep the screen for 6 seconds
WaitSecs(6);

end