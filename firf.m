function y = firf(s,frq_band,fs,ord)
% Filter signal with an FIR filter
% 
% Inputs:
%  s         - Signal to be filtered
%  frq_band  - Frequency band
%  fs        - Sample frequency
%  ord       - Filter order
%
% Outputs:
%  y        - Filted signal
% 
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018

nyq = floor(fs/2);
Ntaps = floor(ord*fs/frq_band(1));
b = fir1(Ntaps, frq_band/nyq, 'bandpass')';
y = filtfilt(b,1,s);