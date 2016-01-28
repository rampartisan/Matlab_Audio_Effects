function y = MAE_Tremolo(x,Fs,modFreq,depth)

% you can supply just input + sampleRate arguments and 
% the below will be used a default.

if nargin < 3
% modulator frequceny
modFreq = 2;
% modulator depth
depth = 0.5;
end

% create carrier sine, repmat to make sure dimensions match with input 
idx = 1:length(x);
trem = repmat(depth*sin(2*pi*idx*(modFreq/Fs))',1,size(x,2));
% amp mod input with carrier sine
y = x .* trem;
end
