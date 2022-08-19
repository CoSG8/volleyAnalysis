function [readData, folderName, fileName, fileNum] = folderLoading()
%matファイルが格納されたフォルダを読み込む
%   Programmed by Akito Kosugi
%   Version 1.0   14.10.2
%   Version 1.1   15.11.10
%   Version 1.2   15.12.07    folderLoadingに変更　フォルダ名を返すよう変更
%   Version 1.2.1 18.08.17    added waitbar 
%   Version 1.2.2 19.05.13    
%   Ver.1.2.3   2020.04.23    added 'fileName'    

    currentfolder = pwd;
    dpath = uigetdir;    
   
    folderNameStart = max(findstr(dpath,'/'));
    folderNameEnd = length(dpath);
    folderName = dpath(folderNameStart+1:folderNameEnd);
    
    cd(dpath)
    D = dir('*.mat');
    fileNum = size(D,1);
    h = waitbar(0,'file loading...');
    for n=1:fileNum
 
        fname = D(n).name;
        fileName(n) = {fname};
        load(fname)
        temp =  eval(char(who('-file', fname)));
        readData(n) = temp;
        clear temp
        waitbar(n/fileNum,h);
    end
    close(h)
       
    cd(currentfolder)
    disp('File Loading complete');
    
end

