function y = MAE_PPDel(x,Fs,delTime,feedBack)

% horrible hack to make sure delays dont get cut off before they are
% inaudible
numDels = round (3 + exp(feedBack*4.7));

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
    if i < length(x)
    y(i,:) = (0.9*x(i,:)) + feedBack*(y(i-maxDelSamp,:));
    else
            y(i,:) = feedBack*y(i-maxDelSamp,:);
    end

        
end

