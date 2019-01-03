
function [pha, amp] = pa_series(sig_mod, sig_pac, fs, pha_freq, amp_freq, pha_filt, amp_filt)
% calculate the phase time series of a low frequency oscillation and 
% the amplitude time series of a high frequency oscillation.
% 
% Input:
% sig_mod       - The low frequency time-series to use as the phase component
% sig_pac       - The high frequency time-series to ue as the amplitude component
% fs            - Sample frequency
% pha_freq      - Low frequency filtering range for phase
% amp_freq      - High frequency filtering range for amplitude
% pha_filt      - Filter type for phase ('morlet' or 'fir' )
% amp_filt      - Filter type for amplitude ('morlet' or 'fir')
%
% Output: 
% pha           - phase time series
% amp           - amplitude time series
% 
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018


[~, ntrials] = size(sig_mod);

pha_freq_bins = length(pha_freq)-1;
amp_freq_bins = length(amp_freq)-1;

% Create structures to store filtered signals
pha = cell(pha_freq_bins,1);
amp = cell(amp_freq_bins,1);

%% Filter sig_mod for phase time series
if strcmp(pha_filt, 'morlet')
    for i = 1:pha_freq_bins
        f0 = (pha_freq(i) + pha_freq(i+1))/2;
        for j = 1:ntrials
            sig = sig_mod(:,j);
            sig_filt = morletf(sig,f0,fs,7);
            pha{i}(:,j) = angle(sig_filt);
        end
    end
    
elseif strcmp(pha_filt, 'fir')
    for i = 1:pha_freq_bins
        f_range = [pha_freq(i) pha_freq(i+1)];
        for j = 1:ntrials
            sig = sig_mod(:,j);
            sig_filt = firf(sig,f_range,fs,3);
            pha{i}(:,j) = angle(sig_filt);
        end
    end    
    
else
    error('Wrong filter for phase signal!\n');
end


%% Filter sig_pac for amplitude time series
if strcmp(amp_filt, 'morlet')
    for i = 1:amp_freq_bins
        f0 = (amp_freq(i) + amp_freq(i+1))/2;
        for j = 1:ntrials
            sig = sig_pac(:,j);
            sig_filt = morletf(sig,f0,fs,7);
            amp{i}(:,j) = abs(sig_filt);
        end
    end
    
elseif strcmp(amp_filt, 'fir')
    for i = 1:amp_freq_bins
        f_range = [amp_freq(i) amp_freq(i+1)];
        for j = 1:ntrials
            sig = sig_pac(:,j);
            sig_filt = firf(sig,f_range,fs,3);
            amp{i}(:,j) = abs(sig_filt);
        end
    end    
    
else
    error('Wrong filter for amplitude signal!\n');
end
