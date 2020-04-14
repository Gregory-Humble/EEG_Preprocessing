clear;
eeglabpath= '\\ad.monash.edu\home\User093\memo0002\Desktop\eeglab14_1_2b';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='\\ad.monash.edu\home\User093\memo0002\Desktop\Alz Data Analysis\';

%define groups for comparison
data1='total_tfr_grandaverage_active_EC';
data2='total_tfr_grandaverage_sham_EC';
%!!!!! CHECK SUBJ NUMBERS AND VARIABLE NAMES

suf='.mat';

data1m=[data1 suf];
data2m=[data2 suf];

%ID = {'301', '302', '303', '304', '305', '306', '307', '308', '309', '310', '311', '312', '313', '314', '315', '316', '317', '318', '319', '320', '322', '324', '325', '326', '327', '328', '329', '330', '331'};
%ftID = {'P301', 'P302', 'P303', 'P304', 'P305', 'P306', 'P307', 'P308', 'P309', 'P310', 'P311', 'P312', 'P313', 'P314', 'P315', 'P316', 'P317', 'P318', 'P319', 'P320', 'P322', 'P324', 'P325', 'P326', 'P327', 'P328', 'P329', 'P330', 'P331'};

ID = {'333', '335', '336', '338', '341'};
ftID = strcat('P', ID);


%ID = {'301', '302', '305', '306', '307', '308', '309'};
%ftID = {'P301', 'P302', 'P305', 'P306', 'P307', 'P308', 'P309'};

FolderCondition = {'BSL 3 mins eyes open', 'BSL 3 mins eyes closed', 'W6 3 mins eyes open', 'W6 3 mins eyes closed'};
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

SubjectStart=21;
SubjectFinish=numel(ID);
%SubjectFinish=6;

ConditionStart=1;
ConditionFinish=4;

Timepoint = {'BL', 'END'};

cd([workDir, '\8Transforms\']);

% load(data1m);
% load(data2m);

% THETA:

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;
        
        connectivitysavefile = ['power_wPLI_' (Timepoint{1,Time}) '_' (ftID{1,Subjects}) '.mat'];
        load(connectivitysavefile);
        
        connectivityF3toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,30,5:9,:); %F3 to P3 theta
        connectivityF4toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (9,34,5:9,:); %F4 to P4 theta
        
        connectivityF3toF4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,9,5:9,:); %F3 to F4 theta
        connectivityP3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (30,34,5:9,:); %P3 to P4 theta
        
        connectivityF3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,34,5:9,:); %F3 to P4 theta
        connectivityF4toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (9,30,5:9,:); %F4 to P3 theta
        
        
        
        % averaging in time
        
        connectivitymeantimeF3toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to P3 theta
        connectivitymeantimeF4toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF4toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F4 to P4 theta
        
        connectivitymeantimeF3toF4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toF4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to F4 theta
        connectivitymeantimeP3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityP3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %P3 to P4 theta
        
        connectivitymeantimeF3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to P4 theta
        connectivitymeantimeF4toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF4toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F4 to P3 theta
        
        
        % averaging in freq
        
        connectivitymeanFREQF3toP3theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to P3 theta
        connectivitymeanFREQF4toP4theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF4toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F4 to P4 theta
        
        connectivitymeanFREQF3toF4theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toF4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to F4 theta
        connectivitymeanFREQP3toP4theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeP3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %P3 to P4 theta
        
        connectivitymeanFREQF3toP4theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toP4theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to P4 theta
        connectivitymeanFREQF4toP3theta.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF4toP3theta.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F4 to P3 theta
        
    end
end

% GAMMA:

for Subjects=SubjectStart:SubjectFinish;
    for Time=1:2;
        
        connectivitysavefile = ['power_wPLI_' (Timepoint{1,Time}) '_' (ftID{1,Subjects}) '.mat'];
        load(connectivitysavefile);
        
        connectivityF3toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,30,30:45,:); %F3 to P3 gamma
        connectivityF4toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (9,34,30:45,:); %F4 to P4 gamma
        
        connectivityF3toF4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,9,30:45,:); %F3 to F4 gamma
        connectivityP3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (30,34,30:45,:); %P3 to P4 gamma
        
        connectivityF3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (5,34,30:45,:); %F3 to P4 gamma
        connectivityF4toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=connectivityfile.wpli_debiasedspctrm (9,30,30:45,:); %F4 to P3 gamma
        
        
        
        % averaging in time
        
        connectivitymeantimeF3toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to P3 gamma
        connectivitymeantimeF4toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF4toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F4 to P4 gamma
        
        connectivitymeantimeF3toF4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toF4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to F4 gamma
        connectivitymeantimeP3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityP3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %P3 to P4 gamma
        
        connectivitymeantimeF3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F3 to P4 gamma
        connectivitymeantimeF4toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm=nanmean(connectivityF4toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,4); %F4 to P3 gamma
        
        
        % averaging in freq
        
        connectivitymeanFREQF3toP3gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to P3 gamma
        connectivitymeanFREQF4toP4gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF4toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F4 to P4 gamma
        
        connectivitymeanFREQF3toF4gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toF4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to F4 gamma
        connectivitymeanFREQP3toP4gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeP3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %P3 to P4 gamma
        
        connectivitymeanFREQF3toP4gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF3toP4gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F3 to P4 gamma
        connectivitymeanFREQF4toP3gamma.(Timepoint{1,Time}) (Subjects,1)=nanmean(connectivitymeantimeF4toP3gamma.(Timepoint{1,Time}).(ftID{1,Subjects}).wpli_debiasedspctrm,3); %F4 to P3 gamma
        
    end
end

        