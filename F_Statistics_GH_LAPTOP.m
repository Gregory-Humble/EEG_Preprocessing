%This script is designed for a within subject comparison. Note that the
%variables (set for TFR_ALL_rel and TFR_OTHER_rel) need to be saved with
%powspctrm=4-D matrix and dimord='sub_chan_freq_time'. You can create this
%file type using the ft_freqgrandaverage script with cfg.keepindividual =
%'yes'. 

clear;

clear all; close all; clc;
eeglabpath= 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\'


%define groups for comparison
data1='total_tfr_grandaverage_active_diff';
data2='total_tfr_grandaverage_sham_diff';
%!!!!! CHECK SUBJ NUMBERS AND VARIABLE NAMES

suf='.mat';

data1m=[data1 suf];
data2m=[data2 suf];

cd([workDir, '\9Statistics\']);
load(data1m);
load(data2m);

load('AlzNeighbours.mat');

TOI=[0 1.98]; %Set time of interest for analysis. Note that each time point will be considered unless averaged.
FOI=[25 45];

cfg = [];

cfg.channel     = {'all'};
cfg.minnbchan        = 2; %minimum number of channels for cluster
cfg.clusteralpha = 0.05; %cluster significance level for multiple comparison correction
cfg.clusterstatistic = 'maxsum'; % cluster statistics are calculated by taking the sum of the t-value within each cluster
cfg.alpha       = 0.3;% 0.025 for two tailed, 0.05 for one tailed
cfg.latency     = TOI;
cfg.frequency   = FOI;
cfg.avgovertime = 'no'; %can change this between no and yes depending if you want time included
cfg.avgoverchan = 'no'; %can change this between no and yes depending if you want all channels included
cfg.avgoverfreq = 'yes'; %can change this between no and yes depending if you want all frequencies included
cfg.statistic   = 'indepsamplesT'; %quantifies the effect at the sample level (dependent samples)
cfg.numrandomization = 2000;
cfg.correctm    = 'cluster';
cfg.method      = 'montecarlo'; 
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.neighbours  = AlzNeighbours;
%cfg.parameter   = 'individual';

% CHANGE THIS, AND THE FOLLOWING LINES TO FIT YOUR DESIGN:

subj = 5; %enter number of participants 10 responders 29 non-responders

%design for within subject test
design = zeros(1,subj);
%for i = 1:subj
%  design(1,i) = i;
%end
design(1,1:3) = 1;
design(1,4:5) = 2;


cfg.design = design;
%cfg.uvar  = 1; %unit variablse
cfg.ivar  = 1; %independent variables

%define variables for comparison. CHANGE THIS TO ALL YOUR DESIGN. 
[stat] = ft_freqstatistics(cfg, total_tfr_grandaverage_active_diff.EC, total_tfr_grandaverage_sham_diff.EC);

%%



STATS='STATS_';
V='_V_';
mat='.mat';

% WORK OUT HOW THIS PART WORKS AND WHAT IT DOES, then use it:

savename=[STATS data1 'Sham' V 'Active' mat];
save (savename, 'stat');

%%

cfg=[];
cfg.alpha = 0.3;
cfg.zparam='stat';
cfg.layout='quickcap64.mat';
cfg.highlightcolorpos=[1 1 1];
cfg.highlightcolorneg=[1 1 1];

ft_clusterplot(cfg,stat);
        
        