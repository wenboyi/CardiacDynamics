%% LOAD DATA
clear all; close all; clc

full_path = '/Users/wenboyi/Desktop/HR/RR/RR_joint/Normal_R/';
formatSpec = 'preconcert%d_bpm.csv';

for concert=5:6
    % get name
    load_violin1 = strcat(full_path, 'violin1_', sprintf(formatSpec, concert));
    load_violin2 = strcat(full_path, 'violin2_', sprintf(formatSpec, concert));
    load_viola = strcat(full_path, 'viola_', sprintf(formatSpec, concert));
    load_cello = strcat(full_path, 'cello_', sprintf(formatSpec, concert));
    
    % load data
    violin1_data = load(load_violin1);
    violin2_data = load(load_violin2);
    viola_data = load(load_viola);
    cello_data = load(load_cello);
    
    % save data in struct
    violin1{1,concert} = zscore(violin1_data);
    violin2{1,concert} = zscore(violin2_data);
    viola{1,concert} = zscore(viola_data);
    cello{1,concert} = zscore(cello_data);
end


%% MDRQA
close all;

EMB = 3;
DEL = 7;
NORM = 'euc';
RAD = 0.51; % 0.56 bottom, 0.64 middle, 0.71 top
ZScore = 1;
mdrqa_rp_condition = {};

%%
for concert=5:6
    block1 = [violin1{concert}; violin2{concert}; viola{concert}; cello{concert}]';  % [violin1{concert}; violin2{concert}; viola{concert}; cello{concert}]'
    [rp, RESULTS, PARAMETERS, b] = MDRQA(block1, EMB, DEL, NORM, RAD, ZScore);
    mdrqa_rp_condition{concert} = rp; 
    res{concert} = RESULTS;
end
res
writecell(res,'normalR_B_testtableB_0.51_3_7.csv')
res
