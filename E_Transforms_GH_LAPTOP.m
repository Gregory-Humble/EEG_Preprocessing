% The following line gets rid of anything that might already be open:

clear all; close all; clc;
eeglabpath= 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\'

% The following lines sets up an 'array' of strings (sequence of letters). An array is a table where
% each cell contains the digits or letters within the quotation marks. The
% array created below is titled 'ID' (which is why 'ID' is on the left hand
% side of the equals sign). The values in the ID array are referred to
% later in order to call specific variables, so that the script knows which
% files to load.

% ftID has a 'P' at the front of the participant number, because field trip
% (ft) saves files as .mat format, and MATLAB doesn't seem to like files
% to start with numbers.

% If you go into the MATLAB command window and look in the workspace (usually on the right hand side), you
% can view the variables and arrays that have been created. This is useful
% for testing whether you've created the correct array that refers to the
% correct file/folder. If MATLAB comes up with an error, this is a good way
% to trouble shoot.

% ID = {'333', '335', '336', '338', '341'};
% ftID = {'P333', 'P335', 'P336', 'P338', 'P341'};

ID = {'301', '302', '303', '305', '307', '308', '309', '310', '311', '312', '313', '314', '315', '316', '317', '318', '319', '320', '322', '324', '325', '326', '327', '328', '329', '330', '331', '333', '335', '336', '338', '341', '343', '345', '346', '347', '348', '349', '351'};
ftID = strcat('P',ID) %creates a new string ftID that has added a P to the start of every element in ID e.g. '301' becomes 'P301'

FolderCondition = {'BL_3_mins_eyes_open', 'BL_3_mins_eyes_closed', 'END_3_mins_eyes_open', 'END_3_mins_eyes_closed'};
Condition = {'EO','EC'};

caploc=[eeglabpath,'\plugins\dipfit2.3\standard_BESA\standard-10-5-cap385.elp'];

% Below creates variables 'SubjectStart' and 'SubjectFinish', used to
% define which subjects from the 'ID' variable above will be processed
% today. For example, SubjectStart=1 and SubjectFinish=1 will allow you to
% process the first subject listed in the ID variable above. 'nume1(ID);'
% refers to the end of the ID array, so will allow you to process right
% through to the last participant listed if you would like. The same is
% true for ConditionStart and ConditionFinish.

% ADJUST THE SUBJECTSTART AND SUBJECTFINISH VALUES BELOW TO ALLOCATE THE
% SUBJECT RANGE YOU ARE PROCESSING TODAY

SubjectStart=1;
SubjectFinish=numel(ID);
%SubjectFinish=6;

ConditionStart=1;
ConditionFinish=4;

Timepoint = {'BL', 'END'};

mkdir([workDir, '\8Transforms\']);
outfolder =  [workDir, '\8Transforms\'];
addpath(outfolder);
mat='.mat';

% for Subjects=SubjectStart:SubjectFinish;
%     for Time=1:2;
% 
%         ICARejectedSetname = ['S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\7ICArejected\' ID{1,Subjects} '_' Timepoint{1,Time} '_7ICArejected.set'];
%         EEG = pop_loadset(ICARejectedSetname);
%         
%         %Split in to different conditions
%         temp = EEG;
%         EEG = pop_selectevent( EEG, 'type',{'EO'},'deleteevents','off','deleteepochs','on','invertepochs','off');
%         EOSetname = ['S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\8Transforms\' ID{1,Subjects} '_' Timepoint{1,Time} '_EO.set'];
%         EEG = pop_saveset(EEG, EOSetname);
%         
% %         EEG = temp;
% %         EEG = pop_selectevent( EEG, 'type',{'EC'},'deleteevents','off','deleteepochs','on','invertepochs','off');
% %         ECSetname = ['S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\8Transforms\' ID{1,Subjects} '_' Timepoint{1,Time} '_EC.set'];
% %         EEG = pop_saveset(EEG, ECSetname);
% 
%     end
% end
% 
% for Subjects=SubjectStart:SubjectFinish;
%     for Time=1:2;
%         for Cond=1;
%         %%
%         
%         Setname = ['S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\8Transforms\' ID{1,Subjects} '_' Timepoint{1,Time} '_' Condition{1,Cond} '.set'];
%         EEG = pop_loadset(Setname);
%         
%         temp.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,Subjects}) = EEG;
% 
%         Total.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,Subjects})=eeglab2fieldtrip(temp.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,Subjects}), 'preprocessing');
% 
%         % alpha!
% 
%         %TIME FREQUENCY ANALYSIS
% 
%         %Time-frequency analysis inputs
%         cfg=[];
%         cfg.channel={'all', '-M1', '-M2'};
%         cfg.method='mtmfft';
%         %cfg.width=3.5;
%         cfg.output='pow';
%         cfg.foilim= [0.5 45];
%         cfg.taper      = 'hanning';
%         %cfg.toi=0:0.005:1.998;
%         
%         Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,Subjects})=ft_freqanalysis(cfg,Total.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,Subjects}));               
%         cd(outfolder); 
%         
%         savefile = ['Frequency' mat];
%         save (savefile, 'Frequency');
%         
%         end
%         
%     end
%                  
% end
% 
% mkdir('S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\9Statistics\');
% outfolder =  'S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\9Statistics\';
% cd('S:\R-MNHS-MAPrc\Neil-Bailey\Kates Data Analysis\Alz TBS Clinical Trial\9Statistics\');
% 
% addpath(outfolder);
% 
% for Subjects=SubjectStart:SubjectFinish;
%     for Time=1:2;
%         for Cond=1;
%         
%         %%
% %GRAND AVERAGE
% 
% %Required before cluster-based stats
% cfg=[];
% cfg.keepindividual = 'yes';
% 
% %Create appropriate name and ensure correct number of participants.
% %Annoyingly you need to include each participant file name. 
% 
% %            total_tfr_grandaverage_.(Condition{1,Cond})=ft_freqgrandaverage(cfg,total_tfr_bc.(ID{1,1}).(Condition{1,Cond}),total_tfr_bc.(ID{1,4}).(Condition),total_tfr_bc.(ID{1,5}).(Condition));
%             total_tfr_grandaverage_active_EO.(Timepoint{1,Time}).(Condition{1,Cond})=ft_freqgrandaverage(cfg,Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,1}),Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,5}),Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,6}));
%             total_tfr_grandaverage_sham_EO.(Timepoint{1,Time}).(Condition{1,Cond})=ft_freqgrandaverage(cfg,Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,2}),Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,3}),Frequency.(Timepoint{1,Time}).(Condition{1,Cond}).(ftID{1,4}));
%         end
%     end
% end
% 
% % savefile = ['total_tfr_grandaverage_active_EC' mat];
% % save (savefile, 'total_tfr_grandaverage_active_EC');
% % 
% % savefile = ['total_tfr_grandaverage_sham_EC' mat];
% % save (savefile, 'total_tfr_grandaverage_sham_EC');
% 
% savefile = ['total_tfr_grandaverage_active_EO' mat];
% save (savefile, 'total_tfr_grandaverage_active_EO');
% 
% savefile = ['total_tfr_grandaverage_sham_EO' mat];
% save (savefile, 'total_tfr_grandaverage_sham_EO');
% 
% 
% % total_tfr_grandaverage_sham_diff.EC = total_tfr_grandaverage_sham.END.EC;
% % total_tfr_grandaverage_active_diff.EC = total_tfr_grandaverage_active.END.EC;
% % 
% % % total_tfr_grandaverage_sham_diff.EO = total_tfr_grandaverage_sham.END.EO;
% % % total_tfr_grandaverage_active_diff.EO = total_tfr_grandaverage_active.END.EO;
% % 
% % total_tfr_grandaverage_sham_diff.EC.powspctrm = total_tfr_grandaverage_sham.END.EC.powspctrm - total_tfr_grandaverage_sham.BL.EC.powspctrm;
% % total_tfr_grandaverage_active_diff.EC.powspctrm = total_tfr_grandaverage_active.END.EC.powspctrm - total_tfr_grandaverage_active.BL.EC.powspctrm;
% % 
% % % total_tfr_grandaverage_sham_diff.EO.powspctrm = total_tfr_grandaverage_sham.END.EO.powspctrm - total_tfr_grandaverage_sham.BL.EO.powspctrm;
% % % total_tfr_grandaverage_active_diff.EO.powspctrm = total_tfr_grandaverage_active.END.EO.powspctrm - total_tfr_grandaverage_active.BL.EO.powspctrm;
% % 
% % savefile = ['total_tfr_grandaverage_active_diff' mat];
% % save (savefile, 'total_tfr_grandaverage_active_diff');
% % 
% % savefile = ['total_tfr_grandaverage_sham_diff' mat];
% % save (savefile, 'total_tfr_grandaverage_sham_diff');

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;

        ICARejectedSetname = [workDir, '\7ICArejected\' ID{1,Subjects} '_' Timepoint{1,Time} '_7ICArejected.set'];
        EEG = pop_loadset(ICARejectedSetname);
        
        
        temp.(Timepoint{1,Time}).(ftID{1,Subjects}) = EEG;

        Total=eeglab2fieldtrip(temp.(Timepoint{1,Time}).(ftID{1,Subjects}), 'preprocessing');
        
        cfg=[];
        cfg.channel={'all'};
        cfg.output     = 'fourier';
        cfg.method     = 'mtmconvol';
        cfg.taper      = 'hanning';
        cfg.foi        = 0.5:1:45;
        cfg.t_ftimwin  = 3./cfg.foi;
        cfg.toi        = 0:0.05:1.998;
        cfg.keeptrials = 'yes';

        cd(outfolder);



                powerfile=ft_freqanalysis(cfg, Total);

                powersavefile = ['power_' (Timepoint{1,Time}) '_' (ftID{1,Subjects}) mat];
                save (powersavefile, 'powerfile');

                 %Debiased wPLI
                cfg = [];
                cfg.method = 'wpli_debiased';

                connectivityfile = ft_connectivityanalysis(cfg,powerfile);

                connectivitysavefile = ['power_wPLI_' (Timepoint{1,Time}) '_' (ftID{1,Subjects}) '.mat'];
                save (connectivitysavefile, 'connectivityfile');
     
    end
                 
end