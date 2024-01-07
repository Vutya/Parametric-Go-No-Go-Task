function [tbl, tb2, tb3] = plotAndAnalyze()
%PLOTANDANALYZE Draws resulted plots for each level and performs ANOVA

% Make a list of the files with results
filelist = dir(fullfile('data', '**\*.*'));
filelist = filelist(~[filelist.isdir]);

% Make lists for resulted table
PCTT = [];
RTT = [];
PCIT = [];
Levels = repmat([1 2 3], 1, numel(filelist));
LevelsForPCIT = repmat([2 3], 1, numel(filelist));

% Go over data folder and aggregate results into tables
for i = 1:numel(filelist)
    fname = fullfile(filelist(i).folder, filelist(i).name);
    load(fname, 'results');

    PCTT = [PCTT results{1}.correctTarget results{2}.correctTarget results{3}.correctTarget];
    RTT = [RTT results{1}.meanRT results{2}.meanRT results{3}.meanRT];
    PCIT = [PCIT results{2}.correctSuppression results{3}.correctSuppression];
end

% Performing linear model fitting 
mdl1 = fitlm(categorical(Levels), PCTT);
mdl2 = fitlm(categorical(Levels), RTT);
mdl3 = fitlm(categorical(LevelsForPCIT), PCIT);

% Performing anova
tbl = anova(mdl1);
tb2 = anova(mdl2);
tb3 = anova(mdl3);

% Making some plots
x = [1 2 3];
y1 = [mean(PCTT(Levels==1)) mean(PCTT(Levels==2)) mean(PCTT(Levels==3))];
y2 = [NaN mean(PCIT(LevelsForPCIT==2)) mean(PCIT(LevelsForPCIT==3))];
tiledlayout(1,2);
nexttile;
plot(x,y1, '-o');
title('% correc tials for each level and target/lure trials');
ylim([0 1]);
xlim([0.5 3.5]);
xticks([1 2 3]);
ylabel('%correct');
xlabel('Level')
hold on
plot(x,y2, '-o');
legend('Percentage correct target trials',' Percentage correct inhibitory trials');
hold off

% Plot for mean RTs
nexttile;
y3 = [mean(RTT(Levels==1)) mean(RTT(Levels==2)) mean(RTT(Levels==3))];
plot(x,y3, '-o');
title('Mean RTs for target trial');
ylim([0 0.5]);
xlim([0.5 3.5]);
xticks([1 2 3]);
ylabel('Mean RT');
xlabel('Level');

end