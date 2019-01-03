function pac = mi_canolty(phase_sig, amp_sig, n_surr)
% Calculate phase-amplitude coupling (PAC) using the modulation index (MI) 
% method (see Canolty, 2006)
%
% Inputs:
% pha       - Phase time series
% amp       - Amplitude time series
% n_surr    - Number of surrogates
%
% Outputs:
% pac       - phase-amplitude coupling value
%
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018


% Calculate modulation index
pac = abs(mean(amp_sig.*exp(1i*phase_sig)));

% Calculate surrogate MIs
pac_s = zeros(n_surr, 1);
n = length(phase_sig);

phase_j = exp(1i*phase_sig);
for j = 1:n_surr
    idx = randi(n);
    phase_s = phase_j([n-idx+1:n,1:n-idx]);
    pac_s(j) = abs(mean(amp_sig.*phase_s));
end

pac = (pac - mean(pac_s)) / std(pac_s);



