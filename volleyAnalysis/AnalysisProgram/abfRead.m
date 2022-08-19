% abfRead.m
% abf file to matfile
% Programmed by AKito Kosugi
%
% v.2.2       03.01.2022
% v.2.1       01.19.2022
% v.2.0       12.16.2015
% v.1.0       08.28.2014

close all
clc


%% Initialization

programName = 'abfRead.m';
ver = '2.2';


%% Load abf files

currentFolder = pwd;
dPath = uigetdir;    
cd(dPath)

folderNameFirstIndex = max(findstr(dPath,'/'));
folderName = dPath(folderNameFirstIndex+1:end); 

clear folderNameFirstIndex dPath

D = dir('*.abf');                       
fileNum = size(D,1);                            

%---File loading using absload.m---%
h = waitbar(0,'Read abs data...');
for i = 1:fileNum

    dataName = D(i).name;
    temp = abfload(dataName,'channels',cellstr(['IN ' num2str(recChannel)]));
    
    data(i).name = dataName;             
    data(i).date = D(i).date;            
    data(i).number = i-1;                
    data(i).volleyData = squeeze(temp);  
    
    waitbar(i/fileNum,h)

end
close(h)

cd(currentFolder)
clear currentFolder D

%% save

saveData.profile.programName = programName;
saveData.profile.ver = ver;
saveData.data = data;

save([folderName '_ch' num2str(recChannel) '.mat'],'saveData');
