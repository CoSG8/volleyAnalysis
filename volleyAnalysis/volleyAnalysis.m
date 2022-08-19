% volleyAnalysis.m
% Cord dorsum potential and dorsal root potential analysis package
% Programmed by AKito Kosugi
%
% v.4.0  06.15.2022
% v.3.0  03.28.2022
% v.2.1  01.19.2022
% v.2.0  12.24.2021
% v.1.0  12.16.2015

clear all
close all
clc

%% Start parameter setting GUI

paramSet_volley;


%% Start Analysis

switch uiIndex
    case 1
        abfRead;
    case 2
        sweepCheck;
    case 3
        IOAnalysis;
    case 4
        IOComparison;
end