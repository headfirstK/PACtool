
function y = morletf(s,f,Fs,width)
% function y = ampvec(s,f,Fs,width)
%
% Returns a vector 'y' containing the instantaneous amplitude values of 
% signal 's' filtered for frequency 'f' (via convolution with a complex 
% Morlet wavelet described by 'width')
%
% INPUTS:
% s - signal to be filtered
% f - frequency to filter at 
% Fs - sampling frequency of s
% width - parameter which defines the mother wavelet (this is then 
% scaled and translated in order to filter for different frequencies, 
% >= 5 is suggested, see Tallon-Baudry et al., J. Neurosci. 15, 722-734 
% (1997))
%
% NOTE: This function is a modification of code written Ole Jensen, August
% 1998, see ENERGYVEC
%
% Author: Angela Onslow, May 2010

dt = 1/Fs;
sf = f/width;
st = 1/(2*pi*sf); 

t=-(width/2)*st:dt:(width/2)*st; 
m = morlet_wav(f,t,width);
y = conv(s,m');
y = y(ceil(length(m)/2):length(y)-floor(length(m)/2));