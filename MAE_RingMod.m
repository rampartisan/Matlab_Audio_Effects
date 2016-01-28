function y = MAE_RingMod(x,sampleRate,modFreq,depth)

% you can supply just input + sampleRate arguments and 
% the below will be used a default.

if nargin < 3
% modulator frequceny
modFreq = 440;
% modulator depth
modFreq = 0.6;
end

% create carrier sine 
idx = 1:length(x);
carrier = repmat(depth*sin(2*pi*idx*(modFreq/sampleRate))',1,size(x,2));

% ring mod input
y = x .* carrier;

