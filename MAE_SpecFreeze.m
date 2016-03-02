function y = MAE_SpecFreeze(x,windowSize,chance)

[inLen,numChan] = size(x);
yf = zeros(inLen,numChan);
nRow = ceil(windowSize/2);
window = MAA_HammWindows(windowSize,'p');
hopSize = floor(windowSize * 0.5);

holding = 0;

% STFT on one channel at a time
for chanIdx = 1:numChan
    idx = 1;
    filtIdx = 1;
    
    % Compute STFT
    while (idx+(windowSize-1) <= length(x))
        
        windowedSig = x(idx:idx+(windowSize-1),chanIdx) .* window;
        Z = fft(windowedSig,windowSize);
        hZ  = Z(1:nRow);
        hZF = zeros(size(hZ));
        
        if holding == 0;
            if randi([0 chance],1,1) == 0
                threshEnd = randi([501 1000],1,1);
                threshStart = randi([1 500],1,1);
                holdFrame = hZ(threshStart:threshEnd);
                holding = 1;
            end
        else
            if randi([0 10],1,1) == 0
                holding = 0;
            end
        end
                
        
        if holding == 1;            
            hZF(threshStart:threshEnd) = holdFrame;         
            hZF(threshEnd+1:end) = hZ(threshEnd+1:end);
            hZF(1:threshStart) = hZF(1:threshStart);
        else
            hZF = hZ;
        end
        
        
        % --- ISTFT --- %
        X = [hZF; hZF];
        xprim = real(ifft(X));
        
        yf(idx:idx+(windowSize-1),chanIdx) = yf(idx:idx+(windowSize-1),chanIdx) + xprim;
        
        % index updates
        idx = idx + hopSize;
        filtIdx = filtIdx+1;
        
    end
end

y = yf;
end