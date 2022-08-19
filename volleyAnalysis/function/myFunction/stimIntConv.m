function [stimInt_mw] = stimIntConv(stimInt,stimType)
% Programmed by AKito Kosugi
% % Å® mW
% v.2.0        05.11.2022 
% v.1.0        03.28.2022 

    switch stimType
        case 'opt_S'
            switch stimInt
                case 2
                    stimInt_mw = 2.2;
                case 5
                    stimInt_mw = 7.3;
                case 10
                    stimInt_mw = 13.6;
                case 20
                    stimInt_mw = 24.7;
                case 30
                    stimInt_mw = 34.9;
                case 40
                    stimInt_mw = 43.4;
                case 50
                    stimInt_mw = 51.3;
                case 60
                    stimInt_mw = 58.4;
                case 70
                    stimInt_mw = 64.4;
                case 80
                    stimInt_mw = 70;
                case 90
                    stimInt_mw = 74.8;
            end
        case 'opt_L'
            switch stimInt
                case 2
                    stimInt_mw = 6;
                case 5
                    stimInt_mw = 21.8;
                case 10
                    stimInt_mw = 42.5;
                case 20
                    stimInt_mw = 76.3;
                case 30
                    stimInt_mw = 107.9;
                case 40
                    stimInt_mw = 134.8;
                case 50
                    stimInt_mw = 159.3;
                case 60
                    stimInt_mw = 181;
                case 70
                    stimInt_mw = 200;
                case 80
                    stimInt_mw = 218;
                case 90
                    stimInt_mw = 233;
            end
        case 'opt_doric_c'
            switch stimInt
                case 20
                    stimInt_mw = 5.6;
                case 50
                    stimInt_mw = 11.4;
                case 100
                    stimInt_mw = 20.5;
                case 200
                    stimInt_mw = 37.1;
                case 300
                    stimInt_mw = 51.6;
                case 400
                    stimInt_mw = 64.7;
                case 500
                    stimInt_mw = 82.4;
                case 600
                    stimInt_mw = 88;
                case 700
                    stimInt_mw = 98.6;
                case 800
                    stimInt_mw = 108.5;
                case 900
                    stimInt_mw = 118.2;
                case 1000
                    stimInt_mw = 127.2;                    
            end
        case 'opt_doric_g'            
            switch stimInt
                case 1000
                    stimInt_mw = 101.2;
            end
        case 'opt_doric_y'            
            switch stimInt
                case 1000
                    stimInt_mw = 114.8;
            end
        case 'opt_doric_o'            
            switch stimInt
                case 200
                    stimInt_mw = 8.7;
                case 300
                    stimInt_mw = 22.5;
                case 400
                    stimInt_mw = 35.8;
                case 500
                    stimInt_mw = 49;
                case 600
                    stimInt_mw = 61.7;
                case 700
                    stimInt_mw = 73.8;
                case 800
                    stimInt_mw = 85.5;
                case 900
                    stimInt_mw = 96.5;
                case 1000
                    stimInt_mw = 107.3;
            end
    end
end

