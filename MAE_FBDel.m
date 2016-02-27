function y = MAE_FBDel(x,Fs,delTime,feedBack)

% Make sure delayed signal doesnt get cutoff before it is inaudible
numDels = round (3 + exp(feedBack*4.7));
% convert delay time from ms o hz
maxDelSamp = round(delTime*Fs);

% empty out vec.
y = zeros(length(x)+maxDelSamp*numDels,size(x,2));

% dont ref empty samps
if maxDelSamp < length(x)
y(1:maxDelSamp,:) = x(1:maxDelSamp,:);
else
y(1:length(x),:) = x;
end
    
for i = (maxDelSamp+1 :length(y))
    
    % dont reference input signal past its length
    if i <= length(x)
    y(i,:) = (0.9*x(i,:)) + feedBack*(y(i-maxDelSamp,:));
    else
            y(i,:) = feedBack*y(i-maxDelSamp,:);
    end       
end

% normalise output
y =  y/max(abs(y)); 

end

