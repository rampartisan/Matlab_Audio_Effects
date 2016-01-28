function yb = MAE_WahWah(x,Fs,speed,cFreq,width,damp)

% you can supply just input + sampleRate arguments and 
% the below will be used a default.

if nargin < 3
% wah speed (hz/s)
speed = 2000; 
% damping for small pass band
damp = 0.05;
% centre freqand width for bandpass
cFreq = 1750;
width = 875;
end


% define min and max freq for wah
minf = cFreq-width;
maxf = cFreq+width;
% wah speed in samps
delta = speed/Fs;

% calculate tri-wave of centre freq vals 
Fc=minf:delta:maxf;
while(length(Fc) < length(x) )
    Fc= [ Fc (maxf:-delta:minf) ];
    Fc= [ Fc (minf:delta:maxf) ];
end
% trim tri-wave to size of input
Fc = Fc(1:length(x));

% deff equations  coeffs

% F1 must be recalculated each time Fc changes
F1 = 2*sin((pi*Fc(1))/Fs); 
% this dictates size of the pass bands
Q1 = 2*damp;               

% create emptly out vectors, yh = highpass, yb = bandpass, yl = lowpass
yh=zeros(size(x));          
yb=zeros(size(x));
yl=zeros(size(x));

% first sample, to avoid referencing of negative signals
yh(1) = x(1);
yb(1) = F1*yh(1);
yl(1) = F1*yb(1);

% apply difference equation to the sample
for n=2:length(x),
    
    yh(n) = x(n) - yl(n-1) - Q1*yb(n-1);
    yb(n) = F1*yh(n) + yb(n-1);
    yl(n) = F1*yb(n) + yl(n-1);
    
    % redefine F1 with next value in cent freq table
    F1 = 2*sin((pi*Fc(n))/Fs);
end

%normalise
maxyb = max(abs(yb));
yb = yb/maxyb;
