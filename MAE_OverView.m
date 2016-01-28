%% Matlab Audio Effects

[x,Fs] = audioread('acousticGtr.wav');

%% Downsampler
% y = (input,division of original sample rate)
y = MAE_Downsamp(x,4);
soundsc(y,Fs);

%% Tremolo
% y = (input,sampleRate,modFreq,depth)
z = MAE_Tremolo(x,Fs,2,0.5);
soundsc(z,Fs);
