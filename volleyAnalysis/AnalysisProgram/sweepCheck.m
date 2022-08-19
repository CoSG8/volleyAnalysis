% sweepCheck.m
% preprocessing 
% Programmed by AKito Kosugi
%
% v.3,0.2      06.14.2022   bag fixed
% v.3,0.1      06.13.2022   bag fixed
% v.3,0        03.28.2022   Added "Peak search"
% v.2.3        03.01.2022
% v.2.2        02.24.2022
% v.2.1        01.19.2022
% v.2.0.1      01.05.2022
% v.2.0        12.24.2021
% v.1.0.1      12.18.2015    Scale change enabled
% v.1.0        12.16.2015

close all
clc


%% Initialization

programName = 'sweepCheck.m';
ver = '3.0.2';

x_lim = [-1, 10];
y_lim = [-1, 1];
maxTrial = 20;


%% Load files

[loadData fileName] = dataLoading;

for trial = 1:length(loadData.data)
    if loadData.data(trial).number == dataNum
        data = loadData.data(trial);
    end
end

saveNameEnd = findstr(data.name, '.');
saveName = ([fileName '_file_' num2str(dataNum)]);


%% Signal processing

%---Gain correction ---%
volleyGain = recGain;
volleyData_mv = data.volleyData * volleyGain;

dataLength = length(volleyData_mv(:,1));
trialNum = length(volleyData_mv(1,:));

%---Baseline correction---%
% 刺激開始時までの平均をbaselineとして波形の全点から減じる
ref = mean(volleyData_mv(1:(stimDelay-1)*recFs/1000,:),1);
volleyCorrectData_mv = volleyData_mv-repmat(ref,dataLength,1); 

clear ref


%% Remove trials

f = figure('position',[screenSize(1)+screenSize(3)*1/10 screenSize(2)+screenSize(4)*1/10 screenSize(3)*8/10 screenSize(4)*8/10]);
set(f,'name',[data.name '   ' data.date])

%---Plot---%
for trial = 1:trialNum
    
    h(trial)=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyCorrectData_mv(:,trial),'k');
    hold on
    
end
p=plot([0 0],[-100 100],'g');
title([data.name '   ' data.date],'interpreter','none'); 
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
set(gca,'xlim',[x_lim(1) x_lim(2)])
set(gca,'ylim',[y_lim(1) y_lim(2)])
set(gca,'Fontsize',11);

%---Set GUI---%
hc = uicontextmenu;
for line = 1:length(h)   
    set(h(line),'uicontextmenu',hc);
end

g1 = ['flag(1) = get(ui(1),''Value''); if flag(1) == 1; set(h(1),''visible'',''on''); else; set(h(1),''visible'',''off''); end;']; 
g2 = ['flag(2) = get(ui(2),''Value''); if flag(2) == 1; set(h(2),''visible'',''on''); else; set(h(2),''visible'',''off''); end;'];
g3 = ['flag(3) = get(ui(3),''Value''); if flag(3) == 1; set(h(3),''visible'',''on''); else; set(h(3),''visible'',''off''); end;'];
g4 = ['flag(4) = get(ui(4),''Value''); if flag(4) == 1; set(h(4),''visible'',''on''); else; set(h(4),''visible'',''off''); end;']; 
g5 = ['flag(5) = get(ui(5),''Value''); if flag(5) == 1; set(h(5),''visible'',''on''); else; set(h(5),''visible'',''off''); end;'];
g6 = ['flag(6) = get(ui(6),''Value''); if flag(6) == 1; set(h(6),''visible'',''on''); else; set(h(6),''visible'',''off''); end;'];
g7 = ['flag(7) = get(ui(7),''Value''); if flag(7) == 1; set(h(7),''visible'',''on''); else; set(h(7),''visible'',''off''); end;']; 
g8 = ['flag(8) = get(ui(8),''Value''); if flag(8) == 1; set(h(8),''visible'',''on''); else; set(h(8),''visible'',''off''); end;'];
g9 = ['flag(9) = get(ui(9),''Value''); if flag(9) == 1; set(h(9),''visible'',''on''); else; set(h(9),''visible'',''off''); end;'];
g10 = ['flag(10) = get(ui(10),''Value''); if flag(10) == 1; set(h(10),''visible'',''on''); else; set(h(10),''visible'',''off''); end;']; 
g11 = ['flag(11) = get(ui(11),''Value''); if flag(11) == 1; set(h(11),''visible'',''on''); else; set(h(11),''visible'',''off''); end;'];
g12 = ['flag(12) = get(ui(12),''Value''); if flag(12) == 1; set(h(12),''visible'',''on''); else; set(h(12),''visible'',''off''); end;'];
g13 = ['flag(13) = get(ui(13),''Value''); if flag(13) == 1; set(h(13),''visible'',''on''); else; set(h(13),''visible'',''off''); end;']; 
g14 = ['flag(14) = get(ui(14),''Value''); if flag(14) == 1; set(h(14),''visible'',''on''); else; set(h(14),''visible'',''off''); end;'];
g15 = ['flag(15) = get(ui(15),''Value''); if flag(15) == 1; set(h(15),''visible'',''on''); else; set(h(15),''visible'',''off''); end;'];
g16 = ['flag(16) = get(ui(16),''Value''); if flag(16) == 1; set(h(16),''visible'',''on''); else; set(h(16),''visible'',''off''); end;'];
g17 = ['flag(17) = get(ui(17),''Value''); if flag(17) == 1; set(h(17),''visible'',''on''); else; set(h(17),''visible'',''off''); end;'];
g18 = ['flag(18) = get(ui(18),''Value''); if flag(18) == 1; set(h(18),''visible'',''on''); else; set(h(18),''visible'',''off''); end;']; 
g19 = ['flag(19) = get(ui(19),''Value''); if flag(19) == 1; set(h(19),''visible'',''on''); else; set(h(19),''visible'',''off''); end;'];
g20 = ['flag(20) = get(ui(20),''Value''); if flag(20) == 1; set(h(20),''visible'',''on''); else; set(h(20),''visible'',''off''); end;'];
g21 = ['flag(21) = get(ui(21),''Value''); if flag(21) == 1; set(h(21),''visible'',''on''); else; set(h(21),''visible'',''off''); end;'];
g22 = ['flag(22) = get(ui(22),''Value''); if flag(22) == 1; set(h(22),''visible'',''on''); else; set(h(22),''visible'',''off''); end;'];
g23 = ['flag(23) = get(ui(23),''Value''); if flag(23) == 1; set(h(23),''visible'',''on''); else; set(h(23),''visible'',''off''); end;']; 
g24 = ['flag(24) = get(ui(24),''Value''); if flag(24) == 1; set(h(24),''visible'',''on''); else; set(h(24),''visible'',''off''); end;'];
g25 = ['flag(25) = get(ui(25),''Value''); if flag(25) == 1; set(h(25),''visible'',''on''); else; set(h(25),''visible'',''off''); end;'];
g26 = ['flag(26) = get(ui(26),''Value''); if flag(26) == 1; set(h(26),''visible'',''on''); else; set(h(26),''visible'',''off''); end;'];
g27 = ['flag(27) = get(ui(27),''Value''); if flag(27) == 1; set(h(27),''visible'',''on''); else; set(h(27),''visible'',''off''); end;'];
g28 = ['flag(28) = get(ui(28),''Value''); if flag(28) == 1; set(h(28),''visible'',''on''); else; set(h(28),''visible'',''off''); end;']; 
g29 = ['flag(29) = get(ui(29),''Value''); if flag(29) == 1; set(h(29),''visible'',''on''); else; set(h(29),''visible'',''off''); end;'];
g30 = ['flag(30) = get(ui(30),''Value''); if flag(30) == 1; set(h(30),''visible'',''on''); else; set(h(30),''visible'',''off''); end;'];

%---Set checkbox---%
for trial = 1:trialNum
    
    ui(trial) = uicontrol(f(1),'style','checkbox',...
                    'unit','normalize',...
                    'position',[0.92 0.93-0.025*trial 0.05 0.03],...
                    'string',['trial ' num2str(trial)],...
                    'value',1,...
                    'callback',eval(['g' num2str(trial)]));                    

end                

%---Set label---%
% 右クリックで反応するラベルの配置---%
uimenu(hc,'label','Remove this trial','Callback','getData = get(gco,''Ydata'');for trial = 1:trialNum; if isequal(volleyCorrectData_mv(:,trial)'',getData) == 1; set(ui(trial),''Value'',0); end; end; set(gco,''visible'',''off'')');

%---Set pushbutton---%
ui2 = uicontrol(gcf,'style','push',...
                'unit','normalize',...
                'position',[0.88 0.02 0.1 0.05],...
                'string','OK',...
                'callback','set(p,''visible'',''off'');useData = get(findobj(f(1), ''Type'' ,''LIne'', ''Visible'' ,''On''),''YData'');currentXlim = get(gca,''xlim'');currentYlim = get(gca,''ylim'');close gcf');
            
set(gcf,'KeyPressFcn','scaleChange')

uiwait    


if iscell(useData)
    volleyUseData_mv = cell2mat(useData);
end

volleyUseData_mv = volleyUseData_mv';
useTrialNum = length(volleyUseData_mv(1,:));

clear getData useData
clear flag f h hc ui ui2
for trial = 1:trialNum
    eval(['clear g'  num2str(trial)])
end


%% Processing

%---Trial selection---%
if useTrialNum > maxTrial
    idx = randperm(useTrialNum,maxTrial);
    idx = sort(idx,'ascend');
    volleyUseData_mv = volleyUseData_mv(:,idx);
    useTrialNum = maxTrial;
    useTrial = idx;
end

%---Caluculate mean and SD---%

volleyUseData_mean = squeeze(mean(volleyUseData_mv,2));
volleyUseData_sd = squeeze(std(volleyUseData_mv,1,2));


%% Peak search

analysisWindow = [1,2;2,3];
polarityIdx = [2,1];
peakAmp = zeros(2,useTrialNum);
peakIdx = zeros(2,useTrialNum);

%---First peak search---%
f = figure('position',[screenSize(1)+screenSize(3)*1/10 screenSize(2)+screenSize(4)*1/10 screenSize(3)*8/10 screenSize(4)*8/10]);
set(f,'name',[data.name '   ' data.date])
hold on
for trial = 1:useTrialNum    
    h(trial)=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mv(:,trial),'k');
end
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean,'r');
set(p,'linewidth',2);
ph(1)=plot([analysisWindow(1,1) analysisWindow(1,1)],[-100 100],'g','linewidth',1.5);
ph(2)=plot([analysisWindow(1,2) analysisWindow(1,2)],[-100 100],'g','linewidth',1.5);
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
title('Set first peak window');
set(gca,'xlim',[currentXlim(1) currentXlim(2)])
set(gca,'ylim',[currentYlim(1) currentYlim(2)])
set(gca,'Fontsize',15);

%---Set GUI---%
hc1 = uicontextmenu;
set(ph(1),'uicontextmenu',hc1);
uimenu(hc1,'label','Move first line','Callback','[picPoint(1,1),picPoint(1,2)]=ginput(1);set(ph(1),''xdata'',[picPoint(1,1),picPoint(1,1)]);');
hc2 = uicontextmenu;
set(ph(2),'uicontextmenu',hc2);
uimenu(hc2,'label','Move second line','Callback','[picPoint(1,1),picPoint(1,2)]=ginput(1);set(ph(2),''xdata'',[picPoint(1,1),picPoint(1,1)]);');

uicontrol(gcf,'style','text',...
    'unit','normalize',...
    'position',[0.78 0.05 0.1 0.02],...
    'string','Polarity',...
    'fontsize',15,...
    'fontweight','bold');
ui1 = uicontrol(gcf,'style','popupmenu',...
    'unit','normalize',...
    'position',[0.78 0.03 0.1 0.02],...
    'HorizontalAlignment','left',...
    'string',{'Positive','Negative'},...
    'value',polarityIdx(1));
ui2 = uicontrol(gcf,'style','push',...
                'unit','normalize',...
                'position',[0.88 0.02 0.1 0.05],...
                'string','OK',...
                'callback','polarityIdx(1) = get(ui1,''value'');w1 = get(ph(1),''xdata'');w2 = get(ph(2),''xdata'');analysisWindow(1,:) = [w1(1),w2(1)];close gcf');

uiwait


%---Second peak search---%    
analysisWindow(2,1) = analysisWindow(1,2);
f = figure('position',[screenSize(1)+screenSize(3)*1/10 screenSize(2)+screenSize(4)*1/10 screenSize(3)*8/10 screenSize(4)*8/10]);
set(f,'name',[data.name '   ' data.date])
hold on
for trial = 1:useTrialNum    
    h(trial)=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mv(:,trial),'k');
end
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean,'r');
set(p,'linewidth',2);
ph(1)=plot([analysisWindow(2,1) analysisWindow(2,1)],[-100 100],'g','linewidth',1.5);
ph(2)=plot([analysisWindow(2,2) analysisWindow(2,2)],[-100 100],'g','linewidth',1.5);
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
title('Set second peak window');
set(gca,'xlim',[currentXlim(1) currentXlim(2)])
set(gca,'ylim',[currentYlim(1) currentYlim(2)])
set(gca,'Fontsize',15);

%---Set GUI---%
hc1 = uicontextmenu;
set(ph(1),'uicontextmenu',hc1);
uimenu(hc1,'label','Move first line','Callback','[picPoint(1,1),picPoint(1,2)]=ginput(1);set(ph(1),''xdata'',[picPoint(1,1),picPoint(1,1)]);');
hc2 = uicontextmenu;
set(ph(2),'uicontextmenu',hc2);
uimenu(hc2,'label','Move second line','Callback','[picPoint(1,1),picPoint(1,2)]=ginput(1);set(ph(2),''xdata'',[picPoint(1,1),picPoint(1,1)]);');

uicontrol(gcf,'style','text',...
    'unit','normalize',...
    'position',[0.78 0.05 0.1 0.02],...
    'string','Polarity',...
    'fontsize',15,...
    'fontweight','bold');
ui3 = uicontrol(gcf,'style','popupmenu',...
    'unit','normalize',...
    'position',[0.78 0.03 0.1 0.02],...
    'HorizontalAlignment','left',...
    'string',{'Positive','Negative'},...
    'value',polarityIdx(2));
ui4 = uicontrol(gcf,'style','push',...
                'unit','normalize',...
                'position',[0.88 0.02 0.1 0.05],...
                'string','OK',...
                'callback','polarityIdx(2) = get(ui3,''value'');w1 = get(ph(1),''xdata'');w2 = get(ph(2),''xdata'');analysisWindow(2,:) = [w1(1),w2(1)];close gcf');

uiwait


%---Calculate peak-to-peak amplitude---%
for trial = 1:useTrialNum
    for i = 1:2
        dataIdx = floor((stimDelay+analysisWindow(i,1))*recFs/1000):floor((stimDelay+analysisWindow(i,2))*recFs/1000);
        temp = volleyUseData_mv(dataIdx,trial);
        if polarityIdx(i) == 1
            [val,idx] = max(temp);
        else
            [val,idx] = min(temp);
        end
        peakAmp(i,trial) = val;
        peakIdx(i,trial) = idx+dataIdx(1);
        clear dataIdx temp
    end    
    ppAmp(trial) = abs(peakAmp(1,trial)) +  abs(peakAmp(2,trial));
end

%---Calculate latency---%
for trial = 1:useTrialNum
    base_mean = mean(volleyUseData_mv(1:(stimDelay-1)*recFs/1000,trial),1);
    base_sd = std(volleyUseData_mv(1:(stimDelay-1)*recFs/1000,trial),0,1);
    dataIdx = floor((stimDelay+analysisWindow(1,1))*recFs/1000):floor((stimDelay+analysisWindow(1,2))*recFs/1000);
    temp = volleyUseData_mv(dataIdx,trial);
    if polarityIdx(1) == 1
       th = base_mean + 3*base_sd;
       [val,idx] = max(temp>th); 
    else
       th = base_mean - 3*base_sd;
       [val,idx] = max(temp<th); 
    end
    
    if idx > (stimDelay+analysisWindow(1,2))*recFs/1000
        latencyIdx(trial) = nan;
        latencyAmp(trial) = nan;
        latency(trial) = nan;
    elseif idx == 1
        latencyIdx(trial) = peakIdx(1,trial);
        latencyAmp(trial) = peakAmp(1,trial);
        latency(trial) = peakIdx(1,trial)/recFs*1000-stimDelay;
    else
        latencyIdx(trial) = idx+dataIdx(1);
        latencyAmp(trial) = temp(idx);
        latency(trial) = idx/recFs*1000+analysisWindow(1,1);
    end
    if latency(trial) > 5
        latencyIdx(trial) = nan;
        latencyAmp(trial) = nan;
        latency(trial) = nan;
    end
end


%---Check amplitude and latency---%
f = figure('position',[screenSize(1)+screenSize(3)*1/10 screenSize(2)+screenSize(4)*1/10 screenSize(3)*8/10 screenSize(4)*8/10]);
set(f,'name',[data.name '   ' data.date])
hold on
for trial = 1:useTrialNum    
    time = 1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay;
    h(trial)=plot(time,volleyUseData_mv(:,trial),'k');
    s(1)=scatter(time(peakIdx(1,trial)-1),peakAmp(1,trial),30,'r','filled');
    s(2)=scatter(time(peakIdx(2,trial)-1),peakAmp(2,trial),30,'b','filled');
    if latency(trial) > 0
        s(3)=scatter(time(latencyIdx(trial)),latencyAmp(trial),30,'g','filled');
    end
end
ph(1)=plot([analysisWindow(1,1) analysisWindow(1,1)],[-100 100],'r','linewidth',1.5);
ph(2)=plot([analysisWindow(1,2) analysisWindow(1,2)],[-100 100],'r','linewidth',1.5);
ph(3)=plot([analysisWindow(2,1) analysisWindow(2,1)],[-100 100],'b','linewidth',1.5);
ph(4)=plot([analysisWindow(2,2) analysisWindow(2,2)],[-100 100],'b','linewidth',1.5);
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
legend(s,{'First peak','Second peak','Latency'})
title('Check peak and onset');
set(gca,'xlim',[currentXlim(1) currentXlim(2)])
set(gca,'ylim',[currentYlim(1) currentYlim(2)])
set(gca,'Fontsize',15);

uicontrol(gcf,'style','push',...
    'unit','normalize',...
    'position',[0.88 0.02 0.1 0.05],...
    'string','OK',...
    'callback','close gcf');


uiwait

ppAmp_mean = mean(ppAmp);
ppAmp_sd = std(ppAmp);
latency_mean = nanmean(latency);
latency_sd = nanstd(latency);

            
%% Plot

recFsize = 15;

%---Signal---%
f = figure('position',[screenSize(1)+screenSize(3)*1/10 screenSize(2)+screenSize(4)*1/10 screenSize(3)*4/10 screenSize(4)*8/10]);
set(f,'name',saveName)
f1=subplot(2,1,1);
hold on
for trial = 1:useTrialNum    
    h(trial)=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mv(:,trial),'k');
end
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean,'r');
set(p,'linewidth',2);
p=plot([0 0],[-100 100],'g');
title(saveName,'interpreter','none');
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
set(gca,'xlim',[currentXlim(1) currentXlim(2)])
set(gca,'ylim',[currentYlim(1) currentYlim(2)])
set(gca,'Fontsize',recFsize);
set(f,'KeyPressFcn','scaleChange')

f2=subplot(2,1,2);
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean,'b');
set(p,'linewidth',2);
hold on
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean+volleyUseData_sd,'b');  
p=plot(1/recFs*1000-stimDelay:1/recFs*1000:dataLength/recFs*1000-stimDelay,volleyUseData_mean-volleyUseData_sd,'b');  
p=plot([0 0],[-100 100],'g');
title([saveName ' average'],'interpreter','none'); 
xlabel('Time [ms]') 
ylabel('Amplitude [mV]')
set(gca,'xlim',[currentXlim(1) currentXlim(2)])
set(gca,'ylim',[currentYlim(1) currentYlim(2)])

set(gca,'Fontsize',recFsize);
set(gcf,'KeyPressFcn','scaleChange')

pause(1)

%---Bar---%
figure
subplot(1,2,1)
hold on
errorbar(1,ppAmp_mean,ppAmp_sd,'k','linewidth',1.5);
b = bar(1,ppAmp_mean);
set(b,'facecolor','r')
xlim([0,2]);
set(gca,'xtick',[]);
title([num2str(round(ppAmp_mean,2)) ' ± ' num2str(round(ppAmp_sd,2)) , ' mV']);
ylabel('Amplitude [mV]');
set(gca,'fontsize',15);

subplot(1,2,2)
hold on
errorbar(1,latency_mean,latency_sd,'k','linewidth',1.5);
b = bar(1,latency_mean);
set(b,'facecolor','b');
xlim([0,2]);
set(gca,'xtick',[]);
title([num2str(round(latency_mean,2)) ' ± ' num2str(round(latency_sd,2)) , ' ms']);
ylabel('Latency [ms]');
set(gca,'fontsize',15);

pause(1)


%% Save

saveData.profile.programName = programName;
saveData.profile.ver = ver;
saveData.profile.profile_abfRead = loadData.profile;
saveData.profile.fileName = fileName;

saveData.param = param_volley_ui2;

data.volleyUseData = volleyUseData_mv;
data.volleyUseData = volleyUseData_mv;
data.volleyUseData_mean = volleyUseData_mean;
data.volleyUseData_sd = volleyUseData_sd;
saveData.data = data;

analysisData.ppAmp = ppAmp;
analysisData.latency= latency;
analysisData.ppAmp_mean = ppAmp_mean;
analysisData.ppAmp_sd = ppAmp_sd;
analysisData.latency_mean = latency_mean;
analysisData.latency_sd = latency_sd;
analysisData.analysisWindow = analysisWindow;
analysisData.polarityIdx = polarityIdx;
saveData.analysisData = analysisData;


savePanel(saveData);
