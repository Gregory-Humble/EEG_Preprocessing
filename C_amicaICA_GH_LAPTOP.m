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

%ID = {'301', '302', '303', '304', '305', '306', '307', '308', '309', '310', '311', '312', '313', '314', '315', '316', '317', '318', '319', '320', '322', '324', '325', '326', '327', '328', '329', '330', '331'};
%ftID = {'P301', 'P302', 'P303', 'P304', 'P305', 'P306', 'P307', 'P308', 'P309', 'P310', 'P311', 'P312', 'P313', 'P314', 'P315', 'P316', 'P317', 'P318', 'P319', 'P320', 'P322', 'P324', 'P325', 'P326', 'P327', 'P328', 'P329', 'P330', 'P331'};

ID = {'320'};
ftID = strcat('P', ID);


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
%SubjectFinish=11;

ConditionStart=1;
ConditionFinish=4;

Timepoint = {'BL', 'END'};

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;

        ManualRejectionsetname = [workDir, '\5ManualRejection\' ID{1,Subjects} '_' Timepoint{1,Time} '_5.set'];
        EEG = pop_loadset(ManualRejectionsetname);
        
        %%
    
    % The following section runs AMICA (a slow but the most accurate
    % version of ICA)
    
    % You'll need to install amica12 first, and in the folder that you
    % specify in the line below:
    
    % You can download amica12 from http://sccn.ucsd.edu/~jason/amica_web.htmlhttp://sccn.ucsd.edu/~jason/amica12/loadmodout12.m
    
    
    cd ([workDir,'\amica12\']);
    
    %Run AMICA
    [EEG.icaweights, EEG.icasphere, mods] = runamica12(EEG.data(:,:));
    EEG = eeg_checkset( EEG );
    
    % Other options for running ICA are listed below (fastica, which is a
    % fast version, and binica, which is a medium speed and accuracy
    % version) See Delorme, Palmer, Onton, Oostenveld, Makeig (2012) -
    % 'Independent EEG sources are dipolar' for a comparison of the different
    % ICA methods and their pros and cons.
    
    % Note also that FASTICA requires installing in the matlab folder, and
    % can be downloaded from http://research.ics.aalto.fi/ica/fastica/
    
    % EEG = pop_runica(EEG,'icatype','runica','approach', 'extended',1);
    % [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

    % EEG = pop_runica(EEG,'icatype','fastica', 'approach', 'symm', 'g', 'tanh');

    mkdir([workDir, '\6ICA\'])
    ICASetname = [workDir, '\6ICA\' ID{1,Subjects} '_' Timepoint{1,Time} '_6ICA.set'];
    EEG = pop_saveset(EEG, ICASetname);

   

    end

end
