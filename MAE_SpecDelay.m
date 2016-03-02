function y = MAE_SpecDelay(x,windowSize,delMat,mix)

% Length and number of chanels of input
[inLen,numChan] = size(x);
% Create periodic hamming window
window = MAA_HannWindows(windowSize,'p');
% hopsize is half the window size
hopSize = round(windowSize * 0.5);
% Calculate number of rows and columns for the base STFT matrix
nRow = ceil(windowSize/2);
nCol = fix((inLen-windowSize)/hopSize);
% Calculate extra columns/samples needed to account for more samples
% created by the delay
extraCols = max(delMat) * 10;
extraSamps = extraCols * windowSize;
% Set output as input, with the extra zeroed samples
y = [x;zeros(extraSamps,size(x,2))];
delOut = zeros(size(y));
% STFT on one channel at a time
for chanIdx = 1:numChan
    % Create empty out STFT matrix, with the extra columns
    STFT = zeros(nRow,nCol+extraCols);
    % Init Pointers
    idx = 1;
    colIdx = 1;
    
    % Compute STFT
    while (idx+windowSize) <= length(y)
        
        % --- STFT --- %        
        % segment and window input according to pointer
        windowedSig = y(idx:idx+(windowSize-1),chanIdx) .* window;
        % DFT
        Z = fft(windowedSig);
        % store DFT vector in STFT Matrix
        STFT(:,colIdx) = Z(1:nRow); 

        % --- Delays --- %      
        % empty DFT vector for the delayed spectral components
        
        HZDel = zeros(nRow,1,'like',Z);
        % iterate over each bin value, if the delay time is valid 
        % (not referencing negative frames) and is not 0 then set the
        % output FFT Component to a previous component determined by delay
        % time in delMat
                
        for delIdx = 1:length(HZDel)              
        if colIdx - delMat(delIdx) > 0 && delMat(delIdx) ~= 0;  
            HZDel(delIdx) = STFT(delIdx,colIdx - delMat(delIdx));  
        end       
        end
        
        ZDel = [HZDel;HZDel];
        
        % --- ISTFT --- %        
        % inverse FFT
        delayedSig = real(ifft(ZDel));
                
        % combine delayed signal and original/overlap add, amp
        % set by user specified mix
        delOut(idx:idx+(windowSize-1),chanIdx) = ...
            delOut(idx:idx+(windowSize-1),chanIdx) + delayedSig;
        

        % --- Pointer Updates --- %
        idx = idx + hopSize;
        colIdx = colIdx+1;
        
    end

    
end
y = y*(1-mix) + delOut*mix;
end