%% Matlab Audio Effects - Alex Baldwin 2016

[x,Fs] = audioread('acousticGtr.wav');

%% Downsampler
% z = (input,division of original sample rate)
z = MAE_Downsamp(x,4);
soundsc(z,Fs);