% The following line gets rid of anything that might already be open:
clear all; close all; clc;
eeglabpath= 'C:\Users\grego\Desktop\Matlab_EEGlab_Files\eeglab2019_1';
cd(eeglabpath)
eeglab; 
workDir='D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\'

%ft_defaults;
% The following lines sets up an 'array' of strings (sequence of letters). An array is a table where
% each cell contains the digits or letters within the quotation marks. The
% array created below is titled 'ID' (which is why 'ID' is on the left hand
% side of the equals sign). The values in the ID array are referred to
% later in order to call specific variables, so that the script knows which
% files to load.

% ftID has a 'P' at the front of the participant number, because field trip
% (ft) saves files as .mat format, and MATLAB doesn't seem to like files
% to start with numbers.

%just seeing if git push works
% If you go into the MATLAB command window and look in the workspace (usually on the right hand side), you
% can view the variables and arrays that have been created. This is useful
% for testing whether you've created the correct array that refers to the
% correct file/folder. If MATLAB comes up with an error, this is a good way
% to trouble shoot.

%ID = {'343', '344', '345', '346', '347', '348', '349', '350', '351'};
%ftID = {, 'P344', 'P345', 'P346', 'P347', 'P348', 'P349', 'P350', 'P351'};

ID = {'320'};
ftID = strcat('P', ID);


FolderCondition = {'BL_3_mins_eyes_open', 'BL_3_mins_eyes_closed', 'END_3_mins_eyes_open', 'END_3_mins_eyes_closed'};
Condition = {'eyesopen_BL','eyesclosed_BL','eyesopen_END','eyesclosed_END'};
Timepoint = {'BL','END'};

caploc=['D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\standard-10-5-cap385.elp']; %path containing electrode positions

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
%SubjectFinish=20;

ConditionStart=1;
ConditionFinish=4;

for Subjects=SubjectStart:SubjectFinish;
    for Cond=ConditionStart:ConditionFinish;
        %%
        %load data
        % The below line creates a variable cntname. Make this equal the
        % location and file name of the file you want to load. Use the
        % variables created above and embedded in the cntname variable
        % below to ensure the script can load multiple files while only
        % running the script once (so you don't have to go back and
        % re-write the script each time you want to process a new participant).
        
        cntname = [workDir FolderCondition{1,Cond} '\' ID{1,Subjects} '_' Condition{1,Cond} '.cnt'];
        %EEG = pop_loadcnt(cntname, 'dataformat', 'auto', 'keystroke', 'on', 'memmapfile', '');
        %EEG = pop_loadcnt(cntname, 'dataformat', 'auto', 'keystroke', 'off', 'memmapfile', '');
        EEG = pop_loadcnt(cntname , 'dataformat', 'auto', 'memmapfile', '');
        
        EEG = pop_select( EEG,'nochannel',{'FP1' 'FPZ' 'FP2' 'FT7' 'FT8' 'T7' 'T8' 'TP7' 'CP5' 'CP3' 'CP1' 'CPZ' 'CP2' 'CP4' 'CP6' 'TP8' 'PO7' 'PO5' 'PO6' 'PO8' 'CB1' 'CB2' 'E3' 'HEOG'});
        
        % The next two lines find where E1 is in the electrode list, and
        % replaces E1 with SO1 (so that EEGLAB can allocate the correct
        % location to the electrode)
        
        E1_location= find(ismember({EEG.chanlocs.labels},'E1'));
        EEG.chanlocs(1,E1_location).labels='SO1';
        
        EEG=pop_chanedit(EEG,  'lookup', caploc);
        
        EEG.allchan=EEG.chanlocs;
        
        EEG = pop_resample( EEG, 500);
        EEG = eeg_checkset( EEG );
        
        % The lines below saves the .cnt file as a .set file using the
        % EEGLAB command pop_saveset, after defining the variable 'setname'
        
        mkdir([workDir,'\1Set']);
        setname = [workDir,'\1Set\' ID{1,Subjects} '_' Condition{1,Cond} '_1.set'];
        EEG = pop_saveset(EEG, setname);
        
       
        
    end
    
end



for Subjects=SubjectStart:SubjectFinish;
    for Cond=ConditionStart:ConditionFinish;

        setname = [workDir '\1Set\' ID{1,Subjects} '_' Condition{1,Cond} '_1.set'];
        EEG = pop_loadset(setname);
        
% Filtering:
        
        % Leave the following as unchanged as possible. I try not to mess
        % with it because I haven't explored all the parameters, and I
        % don't know what does what. Having said that, the values that
        % follow 's1', 's2', 'all1', and 'all2' can be varied depending on
        % which frequencies you want to notch filter out (with s1 and s2)
        % and high pass (with all1) and low pass (with all2).
        
        % Also, the following section can often error out due to command
        % conflicts. Make sure you only have one copy of the 'butter' file
        % (which is called below in a number of lines, for example: [z1 p1 k1] = butter(ord1, [all1 all2]./(Fs/2), 'bandpass'); % 10th order filter
        % You can find out which butter is being called by typing 'which
        % butter' in the MATLAB command window (without the speech marks).
        % The answer it comes up with should be something like:
        % C:\Program Files\MATLAB\R2015a\toolbox\signal\signal\butter.m 
        % If that isn't the answer that is revealed, maybe change the other
        % file somehow so that it finds the correct file (change the name of the other file to 'butter2' or something.
        
        %%
        EEG = eeg_checkset( EEG );
        dir= pwd;
        cd('C:\Program Files\MATLAB\R2018b\toolbox\signal\signal')             % go to BUTTER    
        
        %filter the data (second order butterworth filter)
        Fs=EEG.srate; ord1=2; ord2=2;
        
        % The next two lines define high pass and low pass filters. The
        % 47-53Hz is a notch filter to remove 50Hz line noise. The 1-80Hz
        % gets rid of low and high frequency noise.
        
        s1=47; s2=53;
        all1=0.1; all2=100;     
        [z1 p1 k1] = butter(ord1, [all1 all2]./(Fs/2), 'bandpass'); % 10th order filter
        [sos1,g1] = zp2sos(z1,p1,k1); % Convert to 2nd order sections form
        [z2 p2 k2] = butter(ord2, [s1 s2]./(Fs/2), 'stop'); % 10th order filter
        [sos2,g2] = zp2sos(z2,p2,k2);
        EEG.data=double(EEG.data);
        temp=NaN(size(EEG.data,1),EEG.pnts,size(EEG.data,3));
        for ch=1:size(EEG.data,1) % for each chan
            for trial=1:size(EEG.data,3) % for each trial
                dataFilt1=filtfilt(sos1,g1,EEG.data(ch,:,trial));
                dataFilt2=filtfilt(sos2,g2,dataFilt1);
                temp(ch,:,trial)=dataFilt2;
            end%--- end of trials
        end %--- end of channels
        EEG.data=temp;
        EEG = eeg_checkset( EEG );
        clear temp
        cd(dir);                                                      % GO BACK 
                % I cant believe it's not BUTTER!   
                
        
        %Save chanlocs
         EEG = eeg_checkset( EEG );
         
         
         
         % epoch the resting data into two second epochs (the two numbers in brackets), 
         % 2 seconds apart (the first number), 
         % and correct to the full epoch baseline (the final number
         % baseline corrects to all values prior to that number)
         
        EEG = eeg_regepochs(EEG, 2, [0 2], 1.99); 
        
        if (Cond==1)||(Cond==3);
            for a = 1:size(EEG.event,2);
                if strcmp(EEG.event(1,a).type, 'X');
                    EEG.event(1,a).type = 'EO';
                    EEG.urevent(1,a).type = 'EO';
                end
            end
        end
        
        if (Cond==2)||(Cond==4);
            for a = 1:size(EEG.event,2);
                if strcmp(EEG.event(1,a).type, 'X');
                    EEG.event(1,a).type = 'EC';
                    EEG.urevent(1,a).type = 'EC';
                end
            end
        end

        EEG = eeg_checkset( EEG );
        
        mkdir([workDir,'\2filtered']);
        setname = [workDir,'\2filtered\' ID{1,Subjects} '_' Condition{1,Cond} '_2.set'];
        EEG = pop_saveset(EEG, setname);
        
    end
    
end

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
        

        
        setname = [workDir,'\2filtered\' ID{1,Subjects} '_' Condition{1,Cond} '_2.set'];
        EEG = pop_loadset(setname);
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
    
    mkdir([workDir,'\3merged']);
    setname = [workDir,'\3merged\' ID{1,Subjects} '_BL_3.set'];
    EEG = pop_saveset(EEG, setname);
    
end

clear ALLEEG;

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
        
    for Cond=3:4;
        

        
        setname = [workDir,'\2filtered\' ID{1,Subjects} '_' Condition{1,Cond} '_2.set'];
        EEG = pop_loadset(setname);
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
        
        file=3:4;


        if Cond==3; 
            file=3;
        end
        if Cond==4; 
            file=4;
        end 
        
        [ALLEEG, EEG, CURRENTSET]=eeg_store(ALLEEG,EEG, file);
        
       
    end
    EEG = pop_mergeset( ALLEEG, [3  4], 0);
    
    mkdir([workDir,'\3merged']);
    setname = [workDir,'\3merged\' ID{1,Subjects} '_END_3.set'];
    EEG = pop_saveset(EEG, setname);
    
end

%%
clear EEG;
clear ALLEEG;
eeglab;

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;
    

        setname = [workDir,'\3merged\' ID{1,Subjects} '_' Timepoint{1,Time} '_3.set'];
        EEG = pop_loadset(setname);
        
        %%
        
        % AUTOMATIC ARTIFACT REJECTION OPTIONS:
        
        % This can be done instead of manual rejection, or prior to manual
        % rejection (which means the manual rejection is more of a spot
        % check, and makes the manual rejection process faster), or not at
        % all (and only the manual rejection method could be used).
        
        % The advantages of the automatic process are that it's objective
        % (all subjects/conditions have the same criteria for bad
        % channels/epochs), and it's faster and  less manually intensive.
        % The objective nature of the automatic process makes your study
        % easier to be published in some cases (some reviewers distrust the
        % manual process).
        % Disadvantages are that it seems to be less rigorous, you can't be
        % sure if you can trust it, and from my testing, gives less
        % statistically significant differences than the manual process.
    
    %Check for bad channel
        
        EEG.origionalepochind= (1:numel(EEG.data(1,1,:)));
        
        % the following line gets the total number of channels listed from
        % before the ECG processing (which adds extra channels).
        n = numel(EEG.chanlocs);
        
        % we then use this value of 'n', representing all channels from the
        % head, to tell the following pop_eegthresh command to check all channels except
        % the last two channels (which are SO1 and ECG in the case of the
        % files for this script) to see if the voltage of those channels
        % varies by more than -250 to 250 microvolts in any of the epochs.
        % (pop_eegthresh is a command that is used by EEGLAB to check that
        % thresholds are not above certain values.
        EEG = pop_eegthresh(EEG,1,[1:n-1] ,-250,250,0,2.0,0,0);
        
        % The following line averages (using the 'mean' command) the
        % EEG.reject.rejthreshE variable along the second dimension (which
        % is where the number of bad epochs for each channel are listed).
        % This can be fed into the following line to ensure less than 3% of
        % the epochs are bad for each channel. If more are bad, this
        % process can be used to delete that channel
        
        EEG.badelectrodesthresh=mean(EEG.reject.rejthreshE,2);
        
        % the following line checks if more than 3% (0.03) of the epochs have a channel that varies by
        % more than -250 to 250 microvolts
        
        thresh=unique([find(EEG.badelectrodesthresh>0.03)]);


        
        % the following few lines transpose the 'thresh' variable so that
        % it can be used in field trip formatting, in order to get a fix on
        % which channels should be excluded. I think I've done this to get
        % the arrays to be formatted so that the pop_select function can
        % read them properly. There's probably a more elegant solution, I
        % jsut don't know what it is.
        
        threshtransposed=transpose(thresh);
        
        FTdata = eeglab2fieldtrip(EEG, 'preprocessing', 'coord_transform');
        
    for threshb=1:length(threshtransposed);
        threshc=threshtransposed(1,threshb);
        
        EEG.badchanthresh(1,threshb)=FTdata.label(1,threshc);
        
    end
    
    
    
    
    % if the command 'isempty' is false for the variable 'thresh' (or in
    % other words equals 0), then there are channels that vary by more than
    % -250 to 250 microvolts. pop_select is then used to exclude those
    % channels
    
    newN=n-1;
    
    if isempty(thresh)==0;
    EEG = pop_select( EEG,'nochannel',EEG.badchanthresh);
    newN=n-1-threshb;
    end
    
    % the following command goes through the same channels and checks if
    % any epochs be excluded because they show a variation of more than
    % 5SDs of kurtosis for individual channels, or 3 for all channels.
    
    % Kurtosis is a measure of the 'peakiness' of the distribution of the
    % data. This method of exclusion runs on the theory that EEG data
    % should be normally distributed, so epochs that are unusal because they're too peaky are
    % excluded.
        
        EEG = pop_rejkurt(EEG,1,[1:newN] ,5,3,0,0);

        % the following line rejects epochs based on whether the
        % power within the frequencies 25 to 45Hz exceeds -100 or 30dB.
        % power in these frequencies generally reflects muscle activity, so
        % if a lot of power is found in the activity in those frequencies
        % during any particular epoch, you've probably got muscle activity
        % rather than brain activity (eg. jaw clenching.
        
        EEG = pop_rejspec( EEG, 1,'elecrange',[1:newN] ,'threshold',[-100 30] ,'freqlimits',[25 45],'eegplotcom','','eegplotplotallrej',1,'eegplotreject',0);
        
        %%
        
        
        %The following few lines do the same thing as above with the
        %threshold for each channel, but for kurtosis and frequency
        %measures of noise,
        %and reject the channel if it's caused
        %more than 3% of epochs to be rejected as bad due to noise.
        
        EEG.badelectrodeskurt=mean(EEG.reject.rejkurtE,2);
        EEG.badelectrodesfreq=mean(EEG.reject.rejfreqE,2);
       
               
       
          x=unique([find(EEG.badelectrodeskurt>0.03)]);


        
        
        
        xtransposed=transpose(x);
        
        FTdata = eeglab2fieldtrip(EEG, 'preprocessing', 'coord_transform');
        
    for y=1:length(xtransposed);
        z=xtransposed(1,y);
        
        EEG.badchankurt(1,y)=FTdata.label(1,z);
        
    end
    
    a=unique([find(EEG.badelectrodesfreq>0.03)]);
    

        
        atransposed=transpose(a);
        
        FTdata = eeglab2fieldtrip(EEG, 'preprocessing', 'coord_transform');
        
    for b=1:length(atransposed);
        c=atransposed(1,b);
        
        EEG.badchanfreq(1,b)=FTdata.label(1,c);
        
    end
    
    
 
if isempty(x)==0;
    EEG = pop_select( EEG,'nochannel',EEG.badchankurt);
    EEG.ProcessingAndBehaviourData.badchankurt=EEG.badchankurt;
end

if isempty(a)==0;
    EEG = pop_select( EEG,'nochannel',EEG.badchanfreq);
    EEG.ProcessingAndBehaviourData.badchanfreq=EEG.badchanfreq;
end

% Once bad channels are rejected (those that cause more than 3% of epochs
% to be rejected, we do a check to see if channels were rejected. If none
% were rejected, then we can use the overall channel epoch rejection that
% was calculated with pop_rejkurt and pop_rejspec functions above. If
% channels were rejected, the following two lines will come up with 'no' in
% answer to the question 'is n (reflecting number of channels rejected)
% equal to 0?', and the 'if' statement (which is formatted to equal 0, or
% 'no') will then perform the following two functions again (pop_rejkurt
% and pop_rejspec). That way, we'll get a bad epoch rejection run without
% including the bad channels that have been excluded because they cause too many epochs to be rejected.
        
n=cat(1,a,x);

if isempty(n)==0;   
        
        EEG = pop_rejkurt( EEG,1,[1:n-1] ,5,3,0,0);
        EEG = pop_rejspec( EEG, 1,'elecrange',[1:n-1] ,'threshold',[-100 30] ,'freqlimits',[25 45],'eegplotcom','','eegplotplotallrej',1,'eegplotreject',0);    
end
% The following clthree lines use the 'unique' and 'find' functions to find
% the trials that should be rejected from the rejfreq and rejkurt functions
% (without doubling up and rejecting the epoch, then going through and
% rejecting the same number of epoch again (which will be a different
% epoch, because the first has already been rejected, because of
% potential overlap).

EEG.BadTrialspect=unique([find(EEG.reject.rejfreq==1)]);
EEG.BadTrialkurt=unique([find(EEG.reject.rejkurt==1)]);   

EEG.BadTr=unique([find(EEG.reject.rejfreq==1) find(EEG.reject.rejkurt==1)]);

% pop_rejepoch rejects the trials listed in EEG.BadTr
        
EEG=pop_rejepoch(EEG,EEG.BadTr,0);



EEG.ProcessingAndBehaviourData.badtrialauto=EEG.BadTr;
        mkdir([workDir,'\4AutoRejection\'])
        AutomaticRejectionsetname = [workDir,'\4AutoRejection\' ID{1,Subjects} '_' Timepoint{1,Time} '_4.set'];
        EEG = pop_saveset(EEG, AutomaticRejectionsetname);
        
    end
    
end
        