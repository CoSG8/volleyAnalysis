% IOComparison.m
% Programmed by AKito Kosugi
% v1.0        06.15.2022

clear all
close all
clc

%% Initialization

programName = 'IOComparison.m';
ver = '1.0';

screenSize = get(0,'screensize');


%% File loading

[loadData, folderName, fileName, fileNum] = folderLoading;
stimType = loadData(1).readData(1).param.stimType;

for i = 1:fileNum
    ppAmp(:,i) = loadData(i).analysisData.ppAmp_mean;
    normppAmp(:,i) = loadData(i).analysisData.normppAmp_mean;
    latency(:,i) = loadData(i).analysisData.latency_mean;
    switch stimType
        case 'elect'
            stimInt(:,i) = loadData(i).param.normStimInt;
        case 'opt_L'
            stimInt(:,i) = loadData(i).param.stimIntensity_mw;
        case 'opt_S'
            stimInt(:,i) = loadData(i).param.stimIntensity_mw;
        case 'opt_doric_c'
            stimInt(:,i) = loadData(i).param.stimIntensity_mw;
    end
end


%% Plot

fSize = 18;
plotColor = [1,0,0;0,1,0;0,0,1];

switch stimType
    case 'elect'
        plotYlim = [0,10];
        plotYlim_amp = [0,2];
%         plotYlim_amp = [0,6];
        x_label = 'Intensity (xThreshold)';
    case 'opt_S'
        plotYlim = [0,240];
        plotYlim_amp = [0,0.6];
        x_label = 'Intensity [mW]';
    case 'opt_L'
        plotYlim = [0,240];
        plotYlim_amp = [0,0.6];
        x_label = 'Intensity [mW]';
    case 'opt_doric_c'
        plotYlim = [0,130];
        plotYlim_amp = [0,4];
        x_label = 'Intensity [mW]';
end


%---I/O amplitude---%
figure
hold on
for i = fileNum:-1:1
    p(i) = plot(stimInt(:,i),ppAmp(:,i),'color',plotColor(i,:),'linewidth',2);
end
xlim(plotYlim)
ylim(plotYlim_amp)
title('Amplitude')
xlabel(x_label);
ylabel('Amplitude [mV]');
legend({'non-targeted','Targeted'})
set(gca,'fontsize',fSize);

pause(1)

%---I/O amplitude---%
figure
hold on
for i = fileNum:-1:1
    p(i) = plot(stimInt(:,i),normppAmp(:,i),'color',plotColor(i,:),'linewidth',2);
end
xlim(plotYlim)
ylim([0,120])
title('Amplitude')
xlabel(x_label);
ylabel('Normalized amplitude(%)');
legend({'non-targeted','Targeted'})
set(gca,'fontsize',fSize);

pause(1)

%---I/O latency---%
figure
hold on
for i = fileNum:-1:1
    plot(stimInt(:,i),latency(:,i),'color',plotColor(i,:),'linewidth',2);
end
xlim(plotYlim)
ylim([0,7])
title('Latency')
xlabel(x_label);
ylabel('Latency [ms]');
legend({'non-targeted','Targeted'})
set(gca,'fontsize',fSize);


%% Save

saveData.profile.programName_2nd = programName;
saveData.profile.ver_2nd = ver;
saveData.profile.fileName = fileName;

savePanel(saveData);