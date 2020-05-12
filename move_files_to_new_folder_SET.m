%% The following line gets rid of anything that might already be open:
clear all; close all; clc;
addpath 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
eeglab;
cd('\\storage.erc.monash.edu.au\shares\R-MNHS-MAPrc\Archive\Melanie_DPsych\Resting EEG Baseline Analysis\')
IDlist= {'101', '102', '103', '104', '105', '106', '107', '108' ,'109' ,'110', '111', '112', '114', '115', '116', '117', '118', '119', '120', '121'}; %populate this list with the different participant IDs
for ii = 1:length(IDlist)
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
    ID=IDlist{ii};
    %source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_S1,Baseline_EYES_CLOSED_ica_clean.set']
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    EEG = pop_loadset('filename', [IDlist{ii} '_S1_Baseline_EYES_CLOSED_ica_clean.set'],'filepath',['\\\\storage.erc.monash.edu.au\\shares\\R-MNHS-MAPrc\\Archive\\Melanie_DPsych\\Resting EEG Baseline Analysis\\' IDlist{ii} '\\']);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename', [IDlist{ii} '_BL_eyesclosed_7ICArejected.set'],'filepath','E:\\Alz_Clinical_Trial\\Alz_Data_Analysis_10JAN20\\Control_Resting_EEG_Data\\eyesclosed\\');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    %copyfile(source, 'E:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\Control_Resting_EEG_Data\eyesclosed\', 'f')
end
%%
IDlist= {'101', '102', '103', '104', '105', '106', '107', '108' ,'109' ,'110', '111', '112', '114', '115', '116', '117', '118', '119', '120', '121'}; 
for ii = 1:length(IDlist)
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
    ID=IDlist{ii};
    %source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_S1,Baseline_EYES_CLOSED_ica_clean.set']
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    EEG = pop_loadset('filename', [IDlist{ii} '_S1_Baseline_EYES_OPEN_ica_clean.set'],'filepath',['\\\\storage.erc.monash.edu.au\\shares\\R-MNHS-MAPrc\\Archive\\Melanie_DPsych\\Resting EEG Baseline Analysis\\' IDlist{ii} '\\']);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename', [IDlist{ii} '_BL_eyesopen_7ICArejected.set'],'filepath','E:\\Alz_Clinical_Trial\\Alz_Data_Analysis_10JAN20\\Control_Resting_EEG_Data\\eyesopen\\');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    %copyfile(source, 'E:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\Control_Resting_EEG_Data\eyesclosed\', 'f')
end


%%
% clear all; close all; clc;
%  addpath 'D:\Alz_Clinical_Trial'
% cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
% IDlist= {'346'}; %populate this list with the different participant IDs
% for ii = 1:length(IDlist)
%     ID=IDlist{ii};
%     source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesopen_BL.cnt'];
%     copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\BL_3_mins_eyes_open', 'f');
% end

%%
% clear all; close all; clc;
%  addpath 'D:\Alz_Clinical_Trial'
% cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
% IDlist= {'346'}; %populate this list with the different participant IDs
% for ii = 1:length(IDlist)
%     ID=IDlist{ii}
%     source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesclosed_END.cnt']
%     copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\END_3_mins_eyes_closed', 'f')
% end
% 
% %%
% clear all; close all; clc;
%  addpath 'D:\Alz_Clinical_Trial'
% cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
% IDlist= {'346'}; %populate this list with the different participant IDs
% for ii = 1:length(IDlist)
%     ID=IDlist{ii}
%     source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesopen_END.cnt']
%     copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\END_3_mins_eyes_open', 'f')
% end