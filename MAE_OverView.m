%% Matlab Audio Effects
[x,Fs] = audioread('acousticGtr.wav');
% soundsc(x,Fs);

%% Downsampler 
% y = (input,division of original sample rate)
y = MAE_Downsamp(x,12);
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
y = MAE_RingMod(x,Fs,90,1);
soundsc(y,Fs);

%% Wah-Wah
%(input,SampleRate,speed,cFreq,width,damp)
y = MAE_WahWah(x,Fs,700,430,200,0.05);
soundsc(y,Fs);

%% Simple Delay
%(input,SampleRate,DelTime)
y = MAE_SimpleDel(x,Fs,0.5);
soundsc(y,Fs);

%% Feedback Delay
%(input,SampleRate,DelTime,FeedBackAmount)
y = MAE_FBDel(x,Fs,0.5,0.4);
soundsc(y,Fs);

%% Simple Reverb
%(input,SampleRate,DelTime,FeedBackAmount)
y = MAE_SimpleReverb(x,Fs,0.005,100);
soundsc(y,Fs);

%% Sample and Hold
% y = (input,sampleRate,meanLen,holdDivs,holdOccur,mode)
y = MAE_SampHold(x,Fs,0.2,[2 8],1,0);
soundsc(y,Fs);

%% Frequency Domain filter 
%  y = MAE_specFilt(input,windowSize,filter matrix)
windowSize = 4096;

% draw shape of spectral filter on bar plot using mouse
MAE_SpecDrawFcn(windowSize);

% Freq Domain Filtering
y = MAE_SpecFilt(x,windowSize,binValues',1);

soundsc(y,Fs);
subplot(2,1,1)
spectrogram(x(:,1));
subplot(2,1,2)
spectrogram(y(:,1));

%% Spectral Gate

y= MAE_SpecGate(x,4096,20,1);
soundsc(y,Fs);

%% Spectral Freeze
y = MAE_SpecFreeze(x,4096,10);
soundsc(y,Fs)