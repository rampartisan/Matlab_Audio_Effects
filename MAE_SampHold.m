function y = MAE_SampHold(x,Fs,meanLen,holdDivs,holdOccur,mode)

% Sample and hold!
% meanLen = 2; % how long to hold sample for (prob dist around the length)
% holdDivs = [2 16]; % length of the held sample, divison of meanLen
% holdOccur = 2; % how often samples are held in TIME(S)
% (random function, lower numbers means more often)
% mode = 1; % (0 = write output to input , meaning that the held
% sections can be held again, 1 only ever holds orignal signal)

[I J] = size(x);
holdOccur = round(Fs*holdOccur);
pdLen = makedist('Normal',meanLen,1);
readBuff = x;
y = x;

for i = 1:I
    if randi([0 holdOccur],1,1) == 0;
        
        holdLen = round((random(pdLen,1,1) * Fs));
        if (i-holdLen) > 1
            
            holdLoopDiv = round(holdLen/holdDivs(randi(length(holdDivs))));
            holdLoop = readBuff([(i - holdLoopDiv+1):i],:);
            
            for j = 1:holdLen
                idx  = holdLoop(mod(j,holdLoopDiv)+1);
                y(i+j) = idx;
            end
            
            if mode
                readBuff = y;
            end
        end
    end
end

