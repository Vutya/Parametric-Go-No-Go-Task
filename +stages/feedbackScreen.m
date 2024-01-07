function feedbackScreen(window, colors, settings, results)
%FEEDBACKSCREEN Shows feedback with individual results

% Define texts
title = 'Feedback';
level1Text = '<b>3 Targets Simple Rule:<b>\n';
level2Text = '<b>2 Targets Repeat Rule:<b>\n';
level3Text = '<b>3 Targets Repeat Rule:<b>\n';
correctTargetText = '<i>%correct target identification: <i>';
meanRTText = '<i>mean reaction time: <i>';
correctSuppressionText = '<i>%correct suppression: <i>';

mainText = strcat(level1Text, ...
    correctTargetText, sprintf('%0.2f', results{1}.correctTarget * 100), '%\n', ...
    meanRTText, sprintf('%0.2f', results{1}.meanRT * 1000), ' ms\n\n', ...
    level2Text, ...
    correctTargetText, sprintf('%0.2f', results{2}.correctTarget * 100), '%\n', ...
    correctSuppressionText, sprintf('%0.2f', results{2}.correctSuppression * 100), '%\n', ...
    meanRTText, sprintf('%0.2f', results{2}.meanRT * 1000), ' ms\n\n', ...
    level3Text, ...
    correctTargetText, sprintf('%0.2f', results{3}.correctTarget * 100), '%\n', ...
    correctSuppressionText, sprintf('%0.2f', results{3}.correctSuppression * 100), '%\n', ...
    meanRTText, sprintf('%0.2f', results{3}.meanRT * 1000), ' ms\n\n');

% Draw main text in the middle of the screen
Screen('TextSize', window, settings.lowerTextSize);
DrawFormattedText2(mainText, 'win', window, 'sx', 'center', 'sy', 'center', ...
    'xalign','center','yalign','center', 'baseColor', colors.black);

% Draw lines around the title
Screen('TextSize', window, settings.mainTextSize);
DrawFormattedText(window, settings.titleLines, 'center', settings.upperLinePosition, colors.black);
DrawFormattedText(window, settings.titleLines, 'center', settings.lowerLinePosition, colors.black);

% Draw title at the top of the screen
Screen('TextSize', window, settings.titleSize);
DrawFormattedText(window, title, 'center', settings.titlePosition, colors.black);

% Draw text with backward and forward buttons
Screen('TextSize', window, settings.lowerTextSize);
DrawFormattedText(window, settings.forwardKeyText, settings.lowerRightPosition, settings.lowerTextPosition, colors.black);

% Update the screen
Screen('Flip', window);

% Start a loop for showing the introduction part
while 1
    % Check the pressed key
    [~,~, keyCode] = KbCheck;
    if keyCode(settings.forwardKey)
        % waits until key is released, then skips the instructions
        KbReleaseWait;
        break;
    end
end

end