% Change xlim or ylim
% Programmed by Akito Kosugi
% ver. 1.0      2015.12.18
% Need "set(gcf,'KeyPressFcn','scaleChange')"

%% Get figure property
key = get(gcf,'currentkey');

currentXlim = get(gca,'xlim');
currentYlim = get(gca,'ylim');
currentgrid = get(gca,'xgrid');
    
deltaXlim = currentXlim(2)-currentXlim(1);
deltaYlim = currentYlim(2)-currentYlim(1);


%% Change lim
   
switch(key)
    
    case 'uparrow'
        changeYlim(1) = currentYlim(1) + deltaYlim/10;
        changeYlim(2) = currentYlim(2) + deltaYlim/10;
        set(gca,'ylim',changeYlim);

    case 'downarrow'
        changeYlim(1) = currentYlim(1) - deltaYlim/10;
        changeYlim(2) = currentYlim(2) - deltaYlim/10;
        set(gca,'ylim',changeYlim);
                   
    case 'rightarrow'
        changeXlim(1) = currentXlim(1) + deltaXlim/10;
        changeXlim(2) = currentXlim(2) + deltaXlim/10;
        set(gca,'xlim',changeXlim);

    case 'leftarrow'
        changeXlim(1) = currentXlim(1) - deltaXlim/10;
        changeXlim(2) = currentXlim(2) - deltaXlim/10;
        set(gca,'xlim',changeXlim);
 
   case 'a'
        changeXlim(1) = currentXlim(1) - deltaXlim/4;
        changeXlim(2) = currentXlim(2) + deltaXlim/4;
        set(gca,'xlim',changeXlim);

    case 's'
        changeXlim(1) = currentXlim(1) + deltaXlim/4;
        changeXlim(2) = currentXlim(2) - deltaXlim/4;
        set(gca,'xlim',changeXlim);
         
        
    case 'w'
        changeYlim(1) = currentYlim(1) + deltaYlim/4;
        changeYlim(2) = currentYlim(2) - deltaYlim/4;
        set(gca,'ylim',changeYlim);

    case 'z'
        changeYlim(1) = currentYlim(1) - deltaYlim/4;
        changeYlim(2) = currentYlim(2) + deltaYlim/4;
        set(gca,'ylim',changeYlim);
    
        
    case 'g'
        if strcmp(currentgrid,'on') == 1
            set(gca,'xgrid','off','ygrid','off');
        
        elseif strcmp(currentgrid,'off') == 1
            set(gca,'xgrid','on','ygrid','on');
        end
end
