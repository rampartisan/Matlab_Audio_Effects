function MAE_SpecDrawFcn(windowSize)

f1 = figure;
set(f1,'WindowButtonDownFcn',@BDF);
ah = axes('SortMethod','childorder');
binGraph = bar(zeros(floor(windowSize/2)+1,1),'PickableParts', 'none');
xlim([1 floor(windowSize/2)+1]);
ylim([0 1.1]);
btn = uicontrol('Style','pushbutton','String','Apply', ...
    'Position', [20 20 50 20], 'Callback', @buttonPress);
btnOnes = uicontrol('Style','pushbutton','String','Apply', ...
    'Position', [80 20 50 20], 'Callback', @setOnes);
uiwait;

    function BDF(src,~)
        
        seltype = src.SelectionType;
        if strcmp(seltype,'normal') && strcmp(class(src.CurrentObject),class(ah))
            src.WindowButtonMotionFcn = @BMF;
            src.WindowButtonUpFcn = @BUF;
        end
        
    end

    function BMF(src,~)
        x = round(src.CurrentObject.CurrentPoint(1,1));
        y = src.CurrentObject.CurrentPoint(1,2);        
        if  x-5 >= 1 && x+5 <= floor(windowSize/2)+1 && y >= 0 && y <= 1
            binGraph.YData(x-5:x+5) = y;
        end
        
    end

    function BUF(src,~)
        src.WindowButtonMotionFcn = '';
        src.WindowButtonUpFcn = '';        
    end

    function buttonPress(~,~)
     assignin('base','binValues',binGraph.YData);
     uiresume;
     
    end

function setOnes(~,~)
binGraph.YData = ones(floor(windowSize/2)+1,1);
end

end