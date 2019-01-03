function pac = mi_ozkurt(phase_sig, amp_sig)
% Calculate phase-amplitude coupling (PAC) using a modulation index 
% method (see Ozkurt & Schnitzler, 2011)
%
% Inputs:
% pha       - Phase time series
% amp       - Amplitude time series
%
% Outputs:
% pac       - phase-amplitude coupling value
%
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018
 
pac = abs(sum(amp_sig.*exp(1i*phase_sig)))/...
    (sqrt(length(phase_sig))*sqrt(sum(amp_sig.^2)));

