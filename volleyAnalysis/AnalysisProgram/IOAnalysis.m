% IOAnalysis.m
% Programmed by AKito Kosugi

% v.3,6        08.19.2022   added analysisType 'depth'
% v.3,5.2      07.05.2022   added analysisType 'order'
% v.3,5.1      06.15.2022
% v.3,5        06.14.2022
% v.3,4.1      05.16.2022   bag fixed
% v.3,4        05.11.2022   added loadData_ref for normalization
% v.3,3        03.28.2022   
% v.3.2        03.21.2022
% v.3.1        03.17.2022
% v.3.0        03.01.2022
% v.2.0        02.24.2022
% v.1.0        01.05.2021

close all
clc

%% Initialization

programName = 'IOAnalysis.m';
ver = '3.6';

screenSize = get(0,'screensize');

x_lim = [-1, 10];


%% File loading

[loadData, folderName, fileName, fileNum] = folderLoading;
stimType = loadData(1).param.stimType;

for i = 1:fileNum
    data(:,:,i) = loadData(i).data.volleyUseData(:,1:15,:);
    data_mean(:,i) = loadData(i).data.volleyUseData_mean;
    stimDuration(i) = loadData(i).param.stimDuration;
    stimIntensity(i) = loadData(i).param.stimIntensity;
    dataNum(i) = loadData(i).param.dataNum;
    if strcmp(analysisType,'depth') == 1
        depth(i) = loadData(i).param.depth;
        laterality(i) = loadData(i).param.laterality;
    end
    if strcmp(stimType,'opt_L') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;
    elseif strcmp(stimType,'opt_S') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;
    elseif strcmp(stimType,'opt_doric_c') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;        
    elseif strcmp(stimType,'opt_doric_g') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;  
    elseif strcmp(stimType,'opt_doric_y') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;  
    elseif strcmp(stimType,'opt_doric_o') == 1
        stimIntensity_mw(i) = loadData(i).param.stimIntensity_mw;  
    end
    ppAmp_mean(i) = loadData(i).analysisData.ppAmp_mean;
    latency_mean(i) = loadData(i).analysisData.latency_mean;
end

dataLength = size(data,1);

fs = loadData(1).param.recFs;
stimDelay = loadData(1).param.stimDelay;

%---Normalize---%
if strcmp(analysisType,'depth' == 0)
    [loadData_ref fileName_ref] = dataLoading;
    ppAmp_mean_ref = loadData_ref.analysisData.ppAmp_mean;
    normppAmp_mean = ppAmp_mean./ppAmp_mean_ref.*100;
end

%---sort---%
switch analysisType
    case 'intensity'
    [val, idx] = sort(stimIntensity,'ascend');
    stimIntensity = stimIntensity(idx);
    data = data(:,:,idx);
    data_mean = data_mean(:,idx);
    ppAmp_mean = ppAmp_mean(idx);
    latency_mean = latency_mean(idx);
    normppAmp_mean = normppAmp_mean(idx);
    case 'duration'
    [val, idx] = sort(stimDuration,'ascend');
    stimDuration = stimDuration(idx);
    data = data(:,:,idx);
    data_mean = data_mean(:,idx);
    ppAmp_mean = ppAmp_mean(idx);
    latency_mean = latency_mean(idx);
    normppAmp_mean = normppAmp_mean(idx);
    case 'depth'
    [val, idx] = sort(depth,'descend');
    depth = depth(idx);
    data = data(:,:,idx);
    data_mean = data_mean(:,idx);
    ppAmp_mean = ppAmp_mean(idx);
    latency_mean = latency_mean(idx);
%     normppAmp_mean = normppAmp_mean(idx);
    case 'order'
    [val, idx] = sort(dataNum,'ascend');
    stimDuration = stimDuration(idx);
    data = data(:,:,idx);
    data_mean = data_mean(:,idx);
    ppAmp_mean = ppAmp_mean(idx);
    latency_mean = latency_mean(idx);
    normppAmp_mean = normppAmp_mean(idx);
end

normStimIntIdx = 1;
switch stimType
    case 'elect'
        normStimInt = stimIntensity./(stimIntensity(normStimIntIdx));
    case 'opt_L'
        stimIntensity_mw = stimIntensity_mw(idx);
    case 'opt_S'
        stimIntensity_mw = stimIntensity_mw(idx);
    case 'opt_doric_c'
        stimIntensity_mw = stimIntensity_mw(idx);
    case 'opt_doric_o'
        stimIntensity_mw = stimIntensity_mw(idx);
end


%% Plot

fSize = 16;
switch stimType
    case 'elect'
        for i = 1:length(plotIdx)
           titleList{i} = [num2str(round(normStimInt(plotIdx(i)),1)) 'T'];
        end
        switch analysisType
            case 'intensity'
                plotColor = jet(ceil(max(normStimInt)));
            case 'order'
                plotColor = jet(length(idx));
            case 'depth'
                plotColor = jet(ceil(max(depth))+1);
                for i = 1:length(plotIdx)
                    depthList{i} = num2str(depth(i));
                end
        end
    case 'opt_S'
        plotColor = jet(floor(max(stimIntensity_mw)));
    case 'opt_L'
        plotColor = jet(floor(max(stimIntensity_mw)));
    case 'opt_doric_c'
        switch analysisType
            case 'intensity'
                plotColor = jet(floor(max(stimIntensity_mw)));
            case 'duration'
                plotColor = jet(floor(max(stimDuration)));
            case 'order'
                plotColor = jet(idx);
        end
    case 'opt_doric_o'
        plotColor = jet(floor(max(stimIntensity_mw)));        
end

plotYlim_amp = plotYlim(2)-plotYlim(1); 

%---representative---%
f = figure('position',[screenSize(1)+screenSize(3)*6/10 screenSize(2)+screenSize(4)*6/10 screenSize(3)*6/20 screenSize(4)*3/10]);
switch stimType
    case 'elect'
        if strcmp(analysisType, 'depth') == 1
            hold on
            k = 0;
            for i = 1:1:length(plotIdx)
                k = k+1;
                plotDepth(k) = plotYlim(2)*2*(k-1);
%                 plotData = data_mean(:,plotIdx(i))./(max(data_mean(:,plotIdx(i)))/(plotYlim(2)))+plotDepth(i);
                plotData = data_mean(:,plotIdx(i))+plotDepth(i);
                plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,plotData,'k','linewidth',1);
                set(gca,'xlim',[x_lim(1) x_lim(2)])
            end
            ylim([plotYlim(1)*2,plotYlim(2)*2*length(plotIdx)])
            xlabel('Time [ms]');
            ylabel('Depth [É m]');
            set(gca,'ytick',plotDepth)
            set(gca,'yticklabel',depthList)
            set(gca,'fontsize',fSize);
        else
            for i = 1:length(plotIdx)
                subplot(1,length(plotIdx),i)
                plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,plotIdx(i)),'k','linewidth',1);
                set(gca,'xlim',[x_lim(1) x_lim(2)])
                set(gca,'ylim',[plotYlim(1) plotYlim(2)])
                %     ylim([-0.05,0.05])
                if i == 1
                    xlabel('Time [ms]');
                    ylabel('Amplitude [mV]');
                end
                title(char(titleList(i)),'fontsize',fSize);
                set(gca,'fontsize',fSize);
            end
        end
    case 'opt_S'
        for i = 1:length(plotIdx)
            subplot(1,length(plotIdx),i)
            plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,plotIdx(i)),'k','linewidth',1);
            set(gca,'xlim',[x_lim(1) x_lim(2)])
            set(gca,'ylim',[plotYlim(1) plotYlim(2)])
            %     ylim([-0.05,0.05])
            if i == 1
                xlabel('Time [ms]');
                ylabel('Amplitude [mV]');
            end
            title([num2str(stimIntensity_mw(idx(i))) ' mW']);
            set(gca,'fontsize',fSize);
        end
    case 'opt_L'
        for i = 1:length(plotIdx)
            subplot(1,length(plotIdx),i)
            plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,plotIdx(i)),'k','linewidth',1);
            set(gca,'xlim',[x_lim(1) x_lim(2)])
            set(gca,'ylim',[plotYlim(1) plotYlim(2)])
            %     ylim([-0.05,0.05])
            if i == 1
                xlabel('Time [ms]');
                ylabel('Amplitude [mV]');
            end
            title([num2str(stimIntensity_mw(idx(i))) ' mW']);
            set(gca,'fontsize',fSize);
        end
    case 'opt_doric_c'
        for i = 1:length(plotIdx)
            subplot(1,length(plotIdx),i)
            plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,plotIdx(i)),'k','linewidth',1);
            set(gca,'xlim',[x_lim(1) x_lim(2)])
            set(gca,'ylim',[plotYlim(1) plotYlim(2)])
            %     ylim([-0.05,0.05])
            if i == 1
                xlabel('Time [ms]');
                ylabel('Amplitude [mV]');
            end
            switch analysisType
                case 'intensity'
                    title([num2str(stimIntensity_mw(plotIdx(i))) ' mW']);
                case 'duration'
                    title([num2str(stimDuration(plotIdx(i))) ' ms']);
            end
            set(gca,'fontsize',fSize);
        end
    case 'opt_doric_o'
        for i = 1:length(plotIdx)
            subplot(1,length(plotIdx),i)
            plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,plotIdx(i)),'k','linewidth',1);
            set(gca,'xlim',[x_lim(1) x_lim(2)])
            set(gca,'ylim',[plotYlim(1) plotYlim(2)])
            %     ylim([-0.05,0.05])
            if i == 1
                xlabel('Time [ms]');
                ylabel('Amplitude [mV]');
            end
            switch analysisType
                case 'intensity'
                    title([num2str(stimIntensity_mw(plotIdx(i))) ' mW']);
                case 'duration'
                    title([num2str(stimDuration(plotIdx(i))) ' ms']);
            end
            set(gca,'fontsize',fSize);
        end
end

pause(1);

fSize = 18;

%---superimpose---%
figure
hold on
switch stimType
    case 'elect'
        for i = 1:fileNum
            switch analysisType
                case 'intensity'            
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(ceil(normStimInt(i)),:),'linewidth',2);
                    colorbar
                    caxis([min(floor(normStimInt)),max(floor(normStimInt))])
                case 'order'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(i,:),'linewidth',2);
                    colorbar
                    caxis([min(floor(idx)),max(floor(idx))])
                case 'depth'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(ceil(depth(i))+1,:),'linewidth',2);
                    colorbar
                    caxis([min(floor(idx)),max(floor(idx))])
            end                    
        end

    case 'opt_doric_c'
        for i = 1:fileNum
            switch analysisType
                case 'intensity'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(floor(stimIntensity_mw(i)),:),'linewidth',2);
                    colorbar
                    caxis([min(floor(stimIntensity_mw)),max(floor(stimIntensity_mw))])
                case 'duration'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(floor(stimDuration(i)),:),'linewidth',2);                    
                    colorbar
                    caxis([min(floor(stimDuration)),max(floor(stimDuration))])
            end
        end
    case 'opt_doric_o'
        for i = 1:fileNum
            switch analysisType
                case 'intensity'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(floor(stimIntensity_mw(i)),:),'linewidth',2);
                    colorbar
                    caxis([min(floor(stimIntensity_mw)),max(floor(stimIntensity_mw))])
                case 'duration'
                    p(i) = plot(1/fs*1000-stimDelay:1/fs*1000:dataLength/fs*1000-stimDelay,data_mean(:,i),'color',plotColor(floor(stimDuration(i)),:),'linewidth',2);                    
                    colorbar
                    caxis([min(floor(stimDuration)),max(floor(stimDuration))])
            end
        end

end
set(gca,'xlim',[x_lim(1) x_lim(2)])
maxmax = max(max(abs(data_mean((stimDelay+0.2*2)/1000*fs:(stimDelay+x_lim(2))/1000*fs,:))));
set(gca,'ylim',[-maxmax,maxmax])
xlabel('Time [ms]');
ylabel('Amplitude [mV]');
set(gca,'fontsize',fSize);

pause(1);

%---I/O amplitude---%
if strcmp(analysisType, 'depth') == 0
    figure
    switch stimType
        case 'elect'
            switch analysisType
                case 'intensity'        
                    plot(normStimInt,ppAmp_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Intensity (xThreshold)');
                case 'order'
                    plot(idx,ppAmp_mean,'k','linewidth',2);
                    xlim([0,max(idx)+1])
                    xlabel('Session');
            end
            ylim([0,plotYlim_amp])
            title('Amplitude')
            ylabel('Amplitude [mV]');
        case 'opt_S'
            plot(stimIntensity_mw,ppAmp_mean,'k','linewidth',2);
            xlim([0,80])
            ylim([0,plotYlim_amp])
            title('Amplitude')
            xlabel('Intensity [mW]');
            ylabel('Amplitude [mV]');
        case 'opt_L'
            plot(stimIntensity_mw,ppAmp_mean,'k','linewidth',2);
            xlim([0,240])
            ylim([0,plotYlim_amp])
            title('Amplitude')
            xlabel('Intensity [mW]');
            ylabel('Amplitude [mV]');
        case 'opt_doric_c'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,ppAmp_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration,ppAmp_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Amplitude')
            ylim([0,plotYlim_amp])
            ylabel('Amplitude [mV]');
        case 'opt_doric_o'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,ppAmp_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration,ppAmp_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Amplitude')
            ylim([0,plotYlim_amp])
            ylabel('Amplitude [mV]');
    end
    set(gca,'fontsize',fSize);
end
pause(1)

%---I/O normalized amplitude---%
if strcmp(analysisType, 'depth') == 0
    figure
    switch stimType
        case 'elect'
            switch analysisType
                case 'intensity'
                    plot(normStimInt,normppAmp_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Intensity (xThreshold)');
                case 'order'
                    plot(idx,normppAmp_mean,'k','linewidth',2);
                    xlim([0,max(idx)+1])
                    xlabel('Session');
            end
            ylim([0,120])
            title('Amplitude')
            ylabel('Normalized amplitude (%)');
        case 'opt_S'
            plot(stimIntensity_mw,normppAmp_mean,'k','linewidth',2);
            xlim([0,80])
            ylim([0,120])
            title('Amplitude')
            xlabel('Intensity [mW]');
            ylabel('Normalized amplitude (%)');
        case 'opt_L'
            plot(stimIntensity_mw,normppAmp_mean,'k','linewidth',2);
            xlim([0,240])
            ylim([0,120])
            title('Amplitude')
            xlabel('Intensity [mW]');
            ylabel('Normalized amplitude (%)');
        case 'opt_doric_c'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,normppAmp_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration(2:4),normppAmp_mean(2:4),'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Amplitude')
            ylim([0,120])
            ylabel('Normalized Amplitude(%)');
        case 'opt_doric_o'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,normppAmp_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration(2:4),normppAmp_mean(2:4),'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Amplitude')
            ylim([0,120])
            ylabel('Normalized Amplitude(%)');
    end
    set(gca,'fontsize',fSize);
end

pause(1)

%---I/O latency---%
if strcmp(analysisType, 'depth') == 0
    figure
    switch stimType
        case 'elect'
            switch analysisType
                case 'intensity'
                    plot(normStimInt,latency_mean,'k','linewidth',2);
                    
                    xlabel('Intensity (xThreshold)');
                case 'order'
                    plot(idx,latency_mean,'k','linewidth',2);
                    xlim([0,max(idx)+1])
                    xlabel('Session');
            end
            title('Latency')
            ylim([0,4])
            ylabel('Latency [ms]');
        case 'opt_S'
            plot(stimIntensity_mw,latency_mean,'k','linewidth',2);
            xlim([0,80])
            ylim([0,4])
            title('Latency')
            xlabel('Intensity [mW]');
            ylabel('Latency [ms]');
        case 'opt_L'
            plot(stimIntensity_mw,latency_mean,'k','linewidth',2);
            xlim([0,240])
            ylim([0,4])
            title('Latency')
            xlabel('Intensity [mW]');
            ylabel('Latency [ms]');
        case 'opt_doric_c'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,latency_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration,latency_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Latency')
            ylim([0,4])
            ylabel('Latency [ms]');
        case 'opt_doric_o'
            switch analysisType
                case 'intensity'
                    plot(stimIntensity_mw,latency_mean,'k','linewidth',2);
                    xlim([0,130])
                    xlabel('Intensity [mW]');
                case 'duration'
                    plot(stimDuration,latency_mean,'k','linewidth',2);
                    xlim([0,10])
                    xlabel('Duration [ms]');
            end
            title('Latency')
            ylim([0,4])
            ylabel('Latency [ms]');
    end
    set(gca,'fontsize',fSize);
end
pause(1)


%% Save

saveData.profile.programName_1st = programName;
saveData.profile.ver_1st = ver;
saveData.profile.fileName = fileName;

saveData.readData = loadData;

saveData.param.fs = fs;
saveData.param.stimDelay = stimDelay;
saveData.param.stimIntensity = stimIntensity;
switch stimType
    case 'elect'
        saveData.param.normStimInt = normStimInt;
    case 'opt_S'
        saveData.param.stimIntensity_mw = stimIntensity_mw;
    case 'opt_L'
        saveData.param.stimIntensity_mw = stimIntensity_mw;
    case 'opt_doric_c'
        saveData.param.stimIntensity_mw = stimIntensity_mw;        
end

saveData.data.data = data;
saveData.data.data_mean = data_mean;

saveData.analysisData.ppAmp_mean = ppAmp_mean;
if strcmp(analysisType,'depth') == 0
    saveData.analysisData.normppAmp_mean = normppAmp_mean;
end
saveData.analysisData.latency_mean = latency_mean;

savePanel(saveData);
