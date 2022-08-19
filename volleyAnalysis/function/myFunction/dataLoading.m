function [fileData, dataName] = dataLoading()
%matƒtƒ@ƒCƒ‹‚ğ“Ç‚İ‚Ş
%   Programmed by Akito Kosugi
%   Version 1.0   02.10.2014
%   Version 1.0.1 15.06.2015
%   Version 1.0.2 27.09.2017

    currentFolder = pwd;

    [fName, dPath] = uigetfile('*.mat');
    cd(dPath);
    load(fName);

    cd(currentFolder);


    fileData = eval(char(who('-file', [dPath fName])));
    
    dataNameEnd = findstr(fName,'.');
    dataName = fName(1:dataNameEnd-1);


    disp('Data Loading complete');
    
end

