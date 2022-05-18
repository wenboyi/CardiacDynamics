%% LOAD DATA
clear all; close all; clc

full_path = '/Users/wenboyi/Desktop/HR/RR/RR_BPM/';
formatSpec = 'preconcert%d_bpm.csv';
% concert = 1;

for concert=1:11
    % get name
    load_violin1 = strcat(full_path, 'violin1_', sprintf(formatSpec, concert));
    load_violin2 = strcat(full_path, 'violin2_', sprintf(formatSpec, concert));
    load_viola = strcat(full_path, 'viola_', sprintf(formatSpec, concert));
    load_cello = strcat(full_path, 'cello_', sprintf(formatSpec, concert));
    
    % load data
    violin1_data = load(load_violin1) ;
    violin2_data = load(load_violin2) ;
    viola_data = load(load_viola) ;
    cello_data = load(load_cello);
    
    % save data in struct
    violin1{1,concert} = zscore(violin1_data);
    violin2{1,concert} = zscore(violin2_data);
    viola{1,concert} = zscore(viola_data);
    cello{1,concert} = zscore(cello_data);
end

%% MDRQA
close all;

EMB = 6;
DEL = 8;
NORM = 'euc';
RAD = 0.61; % 0.56 bottom, 0.64 middle, 0.71 top
ZScore = 0;
mdrqa_rp_condition = {};

%%
players = {violin1, violin2, viola, cello};
%%
mdrqa_rp_condition = cell(11, 6);
res = cell(11, 6);
for concert=1:11
    pair_counter = 0;
    for p1=1:3
        for p2=p1+1:4
            player1 = players{p1}(concert);            
            player2 = players{p2}(concert);
            block1 = [player1{1}; player2{1}]';  % [violin1{concert}; violin2{concert}; viola{concert}; cello{concert}]'
            [rp, RESULTS, PARAMETERS, b] = MDRQA(block1, EMB, DEL, NORM, RAD, ZScore);
            pair_counter = pair_counter + 1;
            mdrqa_rp_condition{concert, pair_counter} = rp;
            res{concert, pair_counter} = RESULTS;
      
        end
    end
end

res
pairs = {'violin1-violin2', 'violin1-viola', 'violin1-cello', 'violin2-viola', 'violin2-cello', 'viola-cello'};
conds = {'Condition 1'; 'Condition 2'; 'Condition 3'; 'Condition 4'; 'Condition 5';'Condition 6';'Condition 7';'Condition 8';'Condition 9';'Condition 10';'Condition 11'};
for pair=1:6
    for con=1:11
        T = table(res{con,pair}); 
        writetable(T, sprintf('/Users/wenboyi/Desktop/HR/RR/mdRQA Pairwise Script/DSQ/%s/mdrqa_pair_%s.csv',string(con),string(pairs(pair))), 'WriteRowNames', true)  
    end
end

