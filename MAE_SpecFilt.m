function y = MAE_SpecFilt(x,windowSize,filtMat,mix)

[inLen,numChan] = size(x);
yf = zeros(inLen,numChan);
nRow = ceil((1+windowSize)/2);
window = MAA_HammWindows(windowSize,'p');
hopSize = floor(windowSize * 0.25);



% STFT on one channel at a time
for chanIdx = 1:numChan
    idx = 1;
    filtIdx = 1;

    % Compute STFT
    while (idx+(windowSize-1) <= length(x))                                
        % --- STFT --- %
        % segment and window input according to index
        windowedSig = x(idx:idx+(windowSize-1),chanIdx) .* window;
        % FFT
        Z = fft(windowedSig,windowSize);
        hZ  = Z(1:nRow);
        % --- Filter -- %
        
        magX = abs(hZ);
        phaseX = angle(hZ);        
        magY = (magX .* filtMat);
        hZF =  magY .* exp(1i*phaseX);
        
        % --- ISTFT --- %
        X = [hZF; conj(hZF(end-1:-1:2))];
        xprim = real(ifft(X));
                
        yf(idx:idx+(windowSize-1),chanIdx) = yf(idx:idx+(windowSize-1),chanIdx) + xprim;              
        
        % index updates
        idx = idx + hopSize;
        filtIdx = filtIdx+1;
        
    end
end

y = (yf * mix) + ((1-mix) * x);

end