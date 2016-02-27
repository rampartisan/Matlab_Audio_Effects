function y = MAE_SimpleDel(x,Fs,delTime)

maxDelSamp = round(delTime*Fs);
% empty out vec.
y = zeros(length(x)+maxDelSamp,size(x,2));

% dont ref empty samps!
if maxDelSamp < length(x)
y(1:maxDelSamp,:) = x(1:maxDelSamp,:);
else
y(1:length(x),:) = x;
end
    
for i = (maxDelSamp+1 :length(y))
    % if index less than the length of input then it is safe to reference,
    % else delayed signal is referenced from output buffer
    if i < length(x)
    % output = input + (input - n)2
    y(i,:) =  x(i,:) + x(i-maxDelSamp,:);
    else
            y(i,:) = y(i-maxDelSamp,:);
    end 
 
end

% normalise output
y =  y/max(abs(y));   
end

