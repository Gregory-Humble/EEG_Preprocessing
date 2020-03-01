% The following line gets rid of anything that might already be open:

clear all; close all; clc;
eeglabpath= 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20'

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

ID = {'301'};
ftID = strcat('P', ID);

%ID = {'301', '302', '303', '304', '305', '306', '307', '308', '309', '310', '311', '312', '313', '314', '315', '316', '317', '318', '319', '320', '322', '324', '325', '326', '327', '328', '329', '330', '331'};
%ftID = {'P301', 'P302', 'P303', 'P304', 'P305', 'P306', 'P307', 'P308', 'P309', 'P310', 'P311', 'P312', 'P313', 'P314', 'P315', 'P316', 'P317', 'P318', 'P319', 'P320', 'P322', 'P324', 'P325', 'P326', 'P327', 'P328', 'P329', 'P330', 'P331'};

FolderCondition = {'BL_3_mins_eyes_open', 'BL_3_mins_eyes_closed', 'END_3_mins_eyes_open', 'END_3_mins_eyes_closed'};
Condition = {'eyesopen_BL','eyesclosed_BL','eyesopen_END','eyesclosed_END'};

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
%SubjectFinish=27;

ConditionStart=1;
ConditionFinish=4;

Timepoint = {'BL', 'END'};

        setname = [workDir, '\1Set\345_eyesopen_BL_1.set'];
        EEG = pop_loadset(setname);
        
        allchan = EEG.allchan;
        
        clear EEG;
        

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;


        
        ICASetname = [workDir, '\6ICA\' ID{1,Subjects} '_' Timepoint{1,Time} '_6ICA.set'];
        EEG = pop_loadset(ICASetname);
        
        EEG.allchan = allchan;
        
        % The following pops up a display of the different ICA components that
    % could be selected for rejection if they're artifacts. View Delorme, Palmer, Onton, Oostenveld, Makeig (2012) -
    % 'Independent EEG sources are dipolar' for an explanation of which
    % components to reject.
    
    % The line requires Nigel's 'TMS-toolbox' to be installed. This toolbox
    % should be in the analysis scripts and tutorials folder on the shared
    % drive, but can be obtained by contacting neilwbailey@gmail.com if
    % not, or nigel.rogasch@monash.edu.
    
    %Remove bad components
    EEG = sortRemoveComp(EEG,'time',[0 1998]);

    %%
    
    % The following line interpolates missing channels (channels that were
    % bad or bridged). It does this based on the channels that should have
    % been there originally (which were stored in EEG.allchan).
    
    %Interpolate missing channels
    EEG = pop_interp(EEG, EEG.allchan, 'spherical');
    
    % The following two lines remove the remaining eye and ECG channels. If
    % you have different labels on your eye channels (for example E1), or no ECG channel, this
    % will need to be changed.
    
    EEG.NoCh={'SO1'};
    EEG=pop_select(EEG,'nochannel',EEG.NoCh);
    
    % The following line stores the bad components in location with all the
    % other processing and behaviour data. Then the following lines store
    % the bad components selected in a separate matlab file (however, this
    % will re-write the matlab file each time. It might be best to load the
    % matlab file, add the new components selected to the end of this file,
    % then re-save the file instead.
    
    EEG.ProcessingAndBehaviourData.BadComponents = EEG.TMScomp;
    
    mkdir([workDir, '\7ICArejected\'])
        ICARejectedSetname = [workDir, '\7ICArejected\' ID{1,Subjects} '_' Timepoint{1,Time} '_7ICArejected.set'];
    EEG = pop_saveset(EEG, ICARejectedSetname);
    
    end

end