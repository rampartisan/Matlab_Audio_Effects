function y = MAE_SpecFreeze(x,windowSize,chance,width)

[inLen,numChan] = size(x);
yf = zeros(inLen,numChan);
nRow = ceil((1+windowSize)/2);
window = MAA_HammWindows(windowSize,'p');
hopSize = floor(windowSize * 0.1);

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
        hZf = zeros(size(hZ));
        
        if holding == 0;
            if randi([0 chance],1,1) == 0
                threshEnd = randi([1000 (windowSize/2)-1],1,1);
                threshStart = randi([1 999],1,1);
                holdFrame = hZ(threshStart:threshEnd);
                holding = 1;
            end
        else
            if randi([0 10],1,1) == 0
                holding = 0;
            end
        end
                
        
        if holding == 1;            
            hZf(threshStart:threshEnd) = holdFrame;         
            hZf(threshEnd+1:end) = hZ(threshEnd+1:end);
            hZf(1:threshStart) = hZf(1:threshStart);
        else
            hZF = hZ;
        end
        
        
        % --- ISTFT --- %
        X = [hZF; conj(hZF(end-1:-1:2))];
        xprim = real(ifft(X));
        
        yf(idx:idx+(windowSize-1),chanIdx) = yf(idx:idx+(windowSize-1),chanIdx) + xprim;
        
        % index updates
        idx = idx + hopSize;
        filtIdx = filtIdx+1;
        
    end
end

y = yf;
end