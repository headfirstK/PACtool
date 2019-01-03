function pac = mi_tort(pha, amp, Nbins)
% Calculate phase-amplitude coupling (PAC) using the modulation index (MI) 
% method (see Tort, 2008)
%
% Inputs:
% pha       - Phase time series
% amp       - Amplitude time series
% Nbins     - Number of bins to split up the low frequency oscillation cycle
%
% Outputs:
% pac       - phase-amplitude coupling value
%
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018

if nargin < 3
    Nbins = 20;
end

step = 360/Nbins;
pha = pha*180/pi;
mean_amp = zeros(Nbins,1);
for i = 1:Nbins
    idx = find(pha >= (-180+(i-1)*step) & ...
               pha <  (-180+    i*step));
    mean_amp(i) = mean(amp(idx));
end

mean_amp = mean_amp/sum(mean_amp);
h = -sum(mean_amp.*log10(mean_amp));
h_max = log10(Nbins);
pac = (h_max - h)/h_max;