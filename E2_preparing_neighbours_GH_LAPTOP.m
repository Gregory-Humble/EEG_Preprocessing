clear;

%define groups for comparison
data1='total_tfr_grandaverage';
%!!!!! CHECK SUBJ NUMBERS AND VARIABLE NAMES

suf='.mat';

data1m=[data1 suf];

eeglabpath= 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\'

cd([workDir, '\9Statistics\']);
load(data1m);

cfg.method = 'template'; %'distance', 'triangulation' or 'template'
%    cfg.neighbourdist = number, maximum distance between neighbouring sensors (only for 'distance')
    cfg.template      = name of the template file, e.g. CTF275_neighb.mat
%    cfg.layout        = filename of the layout, see FT_PREPARE_LAYOUT
    cfg.channel       = {'AF3', 'AF4', 'F7', 'F5', 'F3', 'F1', 'FZ', 'F2', 'F4', 'F6', 'F8', 'FC5', 'FC3', 'FC1', 'FCZ', 'FC2', 'FC4', 'FC6', 'C5', 'C3', 'C1', 'CZ', 'C2', 'C4', 'C6', 'M1', 'M2', 'P7', 'P5', 'P3', 'P1', 'PZ', 'P2', 'P4', 'P6', 'P8', 'PO3', 'POZ', 'PO4', 'O1', 'OZ', 'O2'};
%    cfg.feedback      = 'yes' or 'no' (default = 'no')


AlzNeighbours = ft_prepare_neighbours(cfg, total_tfr_grandaverage.END);

