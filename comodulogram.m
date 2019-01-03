function pacmat = comodulogram(sig_mod, sig_pac, fs, pha_freq, amp_freq, pha_filt, amp_filt, pac_method)
% Calculate PAC for many small frequency bands
%
% Input:
% sig_mod       - The low frequency time-series to use as the phase component
% sig_pac       - The high frequency time-series to ue as the amplitude component
% fs            - Sample frequency
% pha_freq      - Low frequency filtering range for phase
% amp_freq      - High frequency filtering range for amplitude
% pha_filt      - Filter type for phase ('morlet' or 'fir')
% amp_filt      - Filter type for amplitude ('morlet' or 'fir')
% pac_method    - Method to calculate PAC:
%                 'mi_tort' - See Tort, 2008
%                 'mi_canolty' - See Canolty, 2006
%                 'mi_ozkurt' - See Ozkurt & Schnitzler, 2011
%
% Output: 
% Matrix of phase-amplitude coupling values for each combination of the
% phase frequency bin and the amplitude frequency bin
% 
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018

if nargin < 8
    pac_method = 'mi_tort';
end

if nargin < 7
    amp_filt = 'morlet';
end

if nargin < 6
    pha_filt = 'morlet';
end


if size(sig_mod,1) < size(sig_mod,2)
    sig_mod = sig_mod';
    sig_pac = sig_pac';
end


[pha, amp] = pa_series(sig_mod, sig_pac, fs, pha_freq, amp_freq, pha_filt, amp_filt);


xbins = length(pha);
ybins = length(amp);
pacmat = zeros(ybins, xbins);    
for i = 1:ybins
    for j = 1:xbins
        
        % Calculate matrix of PAC values        
        % Pacmat full of raw mi values, not yet normalized
        pacmat(i,j) = mi_measure(pha{j}, amp{i}, pac_method);       
    end
end