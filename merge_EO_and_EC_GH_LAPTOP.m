clear all; 
close all; 
clc;
eeglabpath = 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
workDir = 'E:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\Control_Resting_EEG_Data\'
ID = {'101', '102', '103', '104', '105', '107', '108', '109', '110', '111', '112', '114', '115', '116', '117', '119', '120', '121'};

ftID = strcat('P', ID);
Condition = {'eyesopen','eyesclosed'};
caploc = 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1\plugins\dipfit3.3\standard_BESA\standard-10-5-cap385.elp'; %path containing electrode positions
clear ALLEEG;
SubjectStart = 1;
SubjectFinish = numel(ID);
%SubjectFinish=20;

ConditionStart = 1;
ConditionFinish = 2;

for Subjects=SubjectStart:SubjectFinish;
    
        % the following line loads EEGLAB so that it can process the files.
        % When merging files (as is done at the end of this section), you
        % need to load eeglab before you have the 'for' that will load all
        % the files that you would like to merge. So for example, below we
        % want to merge the two different conditions for each participant.
        % So we've loaded EEGLAB after we've stated the participants to be
        % loaded (so each participant is merged separately), but before
        % we've loaded the conditions (so the conditions are merged for
        % each participant). This is done so that both the condition files for
        % each participant (one participant at a time) are loaded into the
        % EEGLAB structure, where they can be merged.
        
        eeglab;
        
    for Cond=1:2;
        

        
        setname = [workDir, ID{1,Subjects} '_BL_' Condition{1,Cond} '_7ICArejected.set'];
        EEG = pop_loadset(setname);
        EEG = pop_select( EEG,'nochannel',{'FP1' 'FPZ' 'FP2' 'FT7' 'FT8' 'T7' 'T8' 'TP7' 'CP5' 'CP3' 'CP1' 'CPZ' 'CP2' 'CP4' 'CP6' 'TP8' 'PO7' 'PO5' 'PO6' 'PO8' 'CB1' 'CB2' 'E3' 'HEOG' 'M1' 'M2'});
        EEG = pop_chanedit(EEG,  'lookup', caploc);
        EEG.allchan = EEG.chanlocs;
        EEG = eeg_checkset( EEG );
        
        % the following 'if' statements allocate arbitrary numbers to the
        % files that have been loaded, so that condition 1 = file 1. Then
        % the line beginning with 'ALLEEG' stores the files into the
        % 'ALLEEG' store with the variable 'file' at the end (so when file
        % = 1, they're stored in the first compartment of ALLEEG, and when
        % file = 2, they're stored in the second). That way, pop_mergeset
        % below that knows which compartments of ALLEEG to merge (file 1
        % and file 2, as referenced within the square brackets of the
        % pop_mergeset command).
        
        file=1:2;

        if Cond==1; 
            file=1;
        end
        if Cond==2; 
            file=2;
        end 

        
        [ALLEEG, EEG, CURRENTSET]=eeg_store(ALLEEG,EEG, file);
        
       
    end
    EEG = pop_mergeset( ALLEEG, [1  2], 0);
    setname = [workDir,'\merged\' ID{1,Subjects} '_BL_7ICArejected.set'];
    EEG = pop_saveset(EEG, setname);
    
end