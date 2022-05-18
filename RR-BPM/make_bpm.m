clear all; close all; clc
% addpath('/Users/eyu/Google Drive/DSQ/data_analyse/oslo_marts/data/RR-Intervals/preconcert/')
full_path = '/Users/wenboyi/Desktop/HR/RR/RR_interval_corrected/';
formatSpec = 'condition%d_lasthalf_rr.csv';
concert = 8;

load_violin1 = strcat(full_path, 'violin1_', sprintf(formatSpec, concert));
load_violin2 = strcat(full_path, 'violin2_', sprintf(formatSpec, concert));
load_viola = strcat(full_path, 'viola_', sprintf(formatSpec, concert));
load_cello = strcat(full_path, 'cello_', sprintf(formatSpec, concert));
%%
violin1_data = load(load_violin1) .* 1000;
violin2_data = load(load_violin2) .* 1000;
viola_data = load(load_viola) .* 1000;
cello_data = load(load_cello) .* 1000;

%%
windowSz = 0.5;
reSamp = 0.5;
violin1_bpm = RR2BPM(violin1_data, windowSz, reSamp);
violin2_bpm = RR2BPM(violin2_data, windowSz, reSamp);
viola_bpm = RR2BPM(viola_data, windowSz, reSamp);
cello_bpm = RR2BPM(cello_data, windowSz, reSamp);


trunc = min([size(violin1_bpm, 2), size(violin2_bpm, 2), size(viola_bpm, 2), size(cello_bpm, 2)]);


violin1_bpm = violin1_bpm(1:trunc);
violin2_bpm = violin2_bpm(1:trunc);
viola_bpm = viola_bpm(1:trunc);
cello_bpm = cello_bpm(1:trunc);


[length(violin1_bpm), length(violin2_bpm), length(viola_bpm), length(cello_bpm)]

%%
formatSpec = 'preconcert%d_bpm.csv';
load_violin1 = sprintf(formatSpec, concert);
load_violin2 = sprintf(formatSpec, concert);
load_viola = sprintf(formatSpec, concert);
load_cello = sprintf(formatSpec, concert);


csvwrite(strcat(full_path, 'violin1_', load_violin1), violin1_bpm) 
csvwrite(strcat(full_path, 'violin2_', load_violin2), violin2_bpm) 
csvwrite(strcat(full_path, 'viola_', load_viola), viola_bpm) 
csvwrite(strcat(full_path, 'cello_', load_cello), cello_bpm) 

%%
figure
plot(violin1_bpm)
hold on
plot(violin2_bpm)
plot(viola_bpm)
plot(cello_bpm)
legend('violin1', 'violin2', 'viola', 'cello')