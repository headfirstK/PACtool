% This demo is to demostrat how to used the PACtools


clear;clc;
close all;

% Load example data
load example_data.mat;
fs = 1000;

% Set parameters
fp = [6 40];
fa = [20 200];
dp = 2;
da = 4;
width = 7;
measure = 'mi';

ph_freq_vec = [fp(1):dp:fp(2)];
amp_freq_vec = [fa(1):da:fa(2)];
    
pac = comodulogram(data, data, fs, ph_freq_vec, amp_freq_vec,'morlet','morlet','mi_tort');

cmax = max(pac(:))*0.90;
clims = [0 cmax];
imagesc(ph_freq_vec(1:end-1),amp_freq_vec(1:end-1),pac,clims);
set(gca,'YDir','normal')
xlabel('Frequency for phase (Hz)');
ylabel('Frequency for amplitude (Hz)');




