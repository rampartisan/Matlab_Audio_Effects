function y = MAE_SimpleDel(x,Fs,delTime)

maxDelSamp = round(delTime*Fs);
% empty out vec.
y = zeros(length(x)+maxDelSamp,size(x,2));
% amp coeff
amp = 0.9;

% dont ref empty samps
if maxDelSamp < length(x)
y(1:maxDelSamp,:) = x(1:maxDelSamp,:);
else
y(1:length(x),:) = x;
end
    
for i = (maxDelSamp+1 :length(y))
    if i < length(x)
    y(i,:) = (amp*x(i,:)) + amp*(x(i-maxDelSamp,:));
    else
            y(i,:) = x(i-maxDelSamp,:);
    end

        
end

