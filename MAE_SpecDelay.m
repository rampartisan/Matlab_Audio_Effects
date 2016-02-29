function y = MAE_SpecDelay(x,windowSize,delMat,mix)

% Length and number of chanels of input
[inLen,numChan] = size(x);
% Create periodic hamming window
window = MAA_HammWindows(windowSize,'p');
% hopsize is half the window size
hopSize = floor(windowSize * 0.5);

% Calculate number of rows and columns for the base STFT matrix
nRow = ceil((1+windowSize)/2);
nCol = 1+fix((inLen-windowSize)/hopSize);
% Calculate extra columns/samples needed to account for more samples
% created by the delay
extraCols = max(delMat) * 10;
extraSamps = extraCols * round(windowSize/2);
% Create empty out STFT matrix, with the extra columns
STFT = zeros(nRow,nCol+extraCols);
% Set output as input, with the extra zeroed samples
y = [x;zeros(extraSamps,size(x,2))];

% STFT on one channel at a time
for chanIdx = 1:numChan
    % Init Pointers
    idx = 1;
    colIdx = 1;
    
    % Compute STFT
    while (idx+(windowSize-1) <= length(y))
        % --- STFT --- %        
        % segment and window input according to pointer
        windowedSig = y(idx:idx+(windowSize-1),chanIdx) .* window;
        % DFT
        Z = fft(windowedSig,windowSize);
        % store DFT vector in STFT Matrix (only positives needed, 
        % we recreate the negatives at resynthesis)
        STFT(:,colIdx) = Z(1:nRow);             
        
        % --- Delays --- %      
        
        % empty DFT vector for the delayed spectral components, again only
        % need half
        HZDel = zeros(size(Z(1:nRow)));

        % iterate over each bin value, if the delay time is valid 
        % (not referencing negative frames) and is not 0 then set the
        % output FFT Component to a previous component determined by delay
        % time in delMat
                
        for delIdx = 1:length(HZDel)              
        if colIdx - delMat(delIdx) > 0 && delMat(delIdx) ~= 0;  
            HZDel(delIdx) = STFT(delIdx,colIdx - delMat(delIdx));  
        end       
        end
        
        % --- ISTFT --- %
        
        % positive a negative freq values
        ZDel = [HZDel; conj(HZDel(end-1:-1:2))];
        % inverse FFT
        delayedSig = real(ifft(ZDel));
        
        % combine delayed signal and original/overlap add, amp
        % set by user specified mix
        y(idx:idx+(windowSize-1),chanIdx) = ...
            (y(idx:idx+(windowSize-1),chanIdx)*(1-mix)) + (delayedSig*mix);
        
        % --- Pointer Updates --- %
        idx = idx + hopSize;
        colIdx = colIdx+1;
        
    end
end

end