%% Matlab Audio Effects
[x,Fs] = audioread('acousticGtr.wav');
soundsc(x,Fs);

%% Downsampler 
% y = (input,division of original sample rate)
y = MAE_Downsamp(x,2);
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

%% Wah-Wah
%(input,SampleRate,speed,cFreq,width,damp)
y = MAE_WahWah(x,Fs,1000,500,400,0.05);
soundsc(y,Fs);

%% Simple Delay
%(input,SampleRate,DelTime)
y = MAE_SimpleDel(x,Fs,0.05);
soundsc(y,Fs);

%% Feedback Delay
%(input,SampleRate,DelTime,FeedBackAmount)
y = MAE_FBDel(x,Fs,0.5,0.4);
soundsc(y,Fs);

%% Simple Reverb
%(input,SampleRate,DelTime,FeedBackAmount)
y = MAE_SimpleReverb(x,Fs,0.1,10);
soundsc(y,Fs);

%% Sample and Hold
% y = (input,sampleRate,meanLen,holdDivs,holdOccur,mode)
y = MAE_SampHold(y,Fs,0.2,[2 8],0.2,0);
soundsc(y,Fs);

%% Frequency Domain filter 
%  y = MAE_specFilt(input,windowSize,filter matrix)
windowSize = 1024;

% draw shape of spectral filter on bar plot using mouse
MAE_SpecDrawFcn(windowSize);

% Freq Domain Filtering
y = MAE_SpecFilt(x,windowSize,binValues',1);

soundsc(y,Fs);
figure;
subplot(2,1,1)
spectrogram(x(:,1));
subplot(2,1,2)
spectrogram(y(:,1));

