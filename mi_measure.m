function pac = mi_measure(pha, amp, pac_method)
% Calculate phase-amplitude coupling (PAC) using the specified method
%
% Inputs:
% pha           - Phase time series
% amp           - Amplitude time series
% pac_method    - Method to calculate PAC:
%                 'mi_tort' - See Tort, 2008
%                 'mi_canolty' - See Canolty, 2006
%                 'mi_ozkurt' - See Ozkurt & Schnitzler, 2011
%
% Outputs:
% pac           - phase-amplitude coupling value
%
% Author: Ke Zeng (Dr.Robert Chen's Lab), Noverber, 2018


if nargin < 3
    pac_method = 'mi_tort';
end

ntrials = size(pha, 2);
pac = zeros(ntrials,1);
for i = 1:ntrials
    
    if strcmp(pac_method, 'mi_tort')
        pac(i) = mi_tort(pha(:,i), amp(:,i), 20);
    elseif strcmp(pac_method, 'mi_canolty')
        pac(i) = mi_canolty(pha(:,i), amp(:,i), 50);
    elseif strcmp(pac_method, 'mi_ozkurt')
        pac(i) = mi_ozkurt(pha(:,i), amp(:,i));
    else
        error('Wrong pac method!\n');
    end
end

if ntrials > 1
    avg = mean(pac);
    d   = std(pac);
    idx = find(pac>=(avg-2.5*d) & pac<=(avg+2.5*d));
    pac = mean(pac(idx)); 
end