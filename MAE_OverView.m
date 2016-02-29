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

%% Frequency Domain filter - Scales magnitude of frequency bins
% The MAE_SpecDrawFcn can be used to easily create a filter matrix,
% other wise the vector should be round(windowSize/2)+1
%  y = MAE_specFilt(input,windowSize,filter Vector)
windowSize = 4096;

% draw shape of spectral filter on bar plot using mouse
MAE_SpecDrawFcn(windowSize,[0 1],0);

% Freq Domain Filtering
y = MAE_SpecFilt(x,windowSize,binValues',1);

soundsc(y,Fs);
subplot(2,1,1)
spectrogram(x(:,1));
subplot(2,1,2)
spectrogram(y(:,1));

%% Spectral Gate - Only allow frequency bins that exceed a magnitude threshold 
% y = MAE_SpecGate(input,windowsize,magnitude threshold, mix (0:1
% input:gated)
y= MAE_SpecGate(x,4096,20,1);
soundsc(y,Fs);

%% Spectral Freeze - Randomly freezes a selection of the spectrum
% y = MAE_SpecFreeze(input,windowSize,freezeChance(bigger means less
% frequent)
y = MAE_SpecFreeze(x,4096,10);
soundsc(y,Fs)

%% Spectral Delay - Delay frequency bins by different times
% Delay is specified as a multiple of the window size (eg window size of
% 4096 samples and delay of 10 means 40960 sample delay. Smaller window
% Sizes obviously give smaller delays but you sacrifice frequency resolution 
% Use MAE_SpecDrawFcn to easily create delay vector.
% Other wise the vector should be round(windowSize/2)+1
% y = MAE_SpecDelay(input,windowsize,Delay Vector,Mix)
windowSize = 4096;
MAE_SpecDrawFcn(windowSize,[0 40],1);
y = MAE_SpecDelay(x,windowSize,binValues',0.5);
soundsc(y,Fs);

%% Spectral Draw Function
% Tool to draw parameters for frequency domain effects on a bar chart, 
% Returns a variable called binValues when apply is clicked. The script it
% is called from is paused until value is returned.
% MAE_SpecDrawFcn(windowSize,[minYValue maxYValue],roundYValues(0 or 1)
MAE_SpecDrawFcn(1024,[0 100],1);
plot(binValues);


