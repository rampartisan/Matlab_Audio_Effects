%% Matlab Audio Effects

[x,Fs] = audioread('acousticGtr.wav');

%% Sample and Hold
% y = (input,sampleRate,meanLen,holdDivs,holdOccur,mode)
y = MAE_SampHold(x,Fs,0.2,[2 8],0.2,0);
soundsc(y,Fs);

%% Downsampler
% y = (input,division of original sample rate)
y = MAE_Downsamp(x,4);
soundsc(y,Fs);

%% Tremolo
% y = (input,sampleRate,modFreq,depth)
y = MAE_Tremolo(x,Fs,2,0.5);
soundsc(y,Fs);

%% Flanger
% y = (input,sampleRate,DelTime,Rate)
y = MAE_Flanger(x,Fs,0.01,0.1,0.8);
soundsc(y,Fs);

%% RingMod
% y = (input,sampleRate,Rate,Depth)
y = MAE_RingMod(x,Fs,200,0.5);
soundsc(y,Fs);


