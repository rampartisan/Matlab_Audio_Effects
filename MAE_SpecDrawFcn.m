function MAE_SpecDrawFcn(windowSize,binLims,roundFlag)
% Create figure window and set its button down function
f1 = figure;
set(f1,'WindowButtonDownFcn',@BDF);
% Add axes (bar does not have a method for mouse movement detection, use
% axes as a proxy)
ah = axes('SortMethod','childorder');
% Create bar graph, number of bars is half windowsize +1
binGraph = bar(zeros(floor(windowSize/2)+1,1),'PickableParts', 'none');
% Set limits of bar graph, y specified by user input
xlim([1 floor(windowSize/2)+1]);
ylim([binLims(1) binLims(2)+(binLims(2)/10)]);
% Button to return bar values in main workspace
btn = uicontrol('Style','pushbutton','String','Apply', ...
    'Position', [20 20 50 20], 'Callback', @buttonPress);
% Button to set all y values to max
btnOnes = uicontrol('Style','pushbutton','String','Set Max', ...
    'Position', [80 20 50 20], 'Callback', @setOnes);
% Pause script evaluation (main workspace) until bar values are returned
uiwait;

% Button Down Function - sets button motion and button up functions for
% the proxy axes only if the axes are being clicked and the type of click
% is 'normal' (left click only)
    function BDF(src,~)
        seltype = src.SelectionType;
        if strcmp(seltype,'normal') && strcmp(class(src.CurrentObject),class(ah))
            src.WindowButtonMotionFcn = @BMF;
            src.WindowButtonUpFcn = @BUF;
        end
    end

% Button Motion Function, called only on Button Down (above)
    function BMF(src,~)
        % Get current x and y of mouse
        x = round(src.CurrentObject.CurrentPoint(1,1));
        y = src.CurrentObject.CurrentPoint(1,2);
        % If x is within bounds of axes and y is with bounds of user
        % specified limits then set the bar value (x) to height (y)
        % round if specified
        if  x-5 >= 1 && x+5 <= floor(windowSize/2)+1 && y >= 0 && y <= binLims(2);
            if roundFlag
                binGraph.YData(x-5:x+5) = round(y);
            else
                binGraph.YData(x-5:x+5) = y;
            end
        end
    end

% Button Up Function, clears both button up and button motion functions
% so that they are not called constantly on motion / button ups
    function BUF(src,~)
        src.WindowButtonMotionFcn = '';
        src.WindowButtonUpFcn = '';
    end

% Apply Button - Assigns the variable binValues to y data of the bar graph, assigns it in
% the main workspace. Resume main workspace script
    function buttonPress(~,~)
        assignin('base','binValues',binGraph.YData);
        uiresume;
    end

% Set Max Button - sets all values of the bar graph to maximum specified
    function setOnes(~,~)
        binGraph.YData = ones(floor(windowSize/2)+1,1) * binLims(2);
    end

end