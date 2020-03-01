clear;
eeglabpath= '\\ad.monash.edu\home\User093\memo0002\Desktop\eeglab14_1_2b';
cd(eeglabpath)
eeglab; 
ft_defaults;
workDir='\\ad.monash.edu\home\User093\memo0002\Desktop\Alz Data Analysis\'

%define groups for comparison
data1='total_tfr_grandaverage_active_EC';
data2='total_tfr_grandaverage_sham_EC';
%!!!!! CHECK SUBJ NUMBERS AND VARIABLE NAMES

suf='.mat';

data1m=[data1 suf];
data2m=[data2 suf];



cd([workDir, '\9Statistics\']);
load(data1m);
load(data2m);

% Active_EC_theta_frontal = total_tfr_grandaverage_active_EC.BL.EC.powspctrm(:,[5:9 13:17],8:16);
% Active_EC_theta_frontal_MeanTheta=mean(Active_EC_theta_frontal,3);
% Active_EC_theta_frontal_MeanThetaFrontals=mean(Active_EC_theta_frontal_MeanTheta,2);
% 
% Sham_EC_theta_frontal = total_tfr_grandaverage_sham_EC.BL.EC.powspctrm(:,[5:9 13:17],8:16);
% Sham_EC_theta_frontal_MeanTheta=mean(Sham_EC_theta_frontal,3);
% Sham_EC_theta_frontal_MeanThetaFrontals=mean(Sham_EC_theta_frontal_MeanTheta,2);
% 
% Active_EC_theta_frontalEND = total_tfr_grandaverage_active_EC.END.EC.powspctrm(:,[5:9 13:17],8:16);
% Active_EC_theta_frontal_MeanThetaEND=mean(Active_EC_theta_frontalEND,3);
% Active_EC_theta_frontal_MeanThetaFrontalsEND=mean(Active_EC_theta_frontal_MeanThetaEND,2);
% 
% Sham_EC_theta_frontalEND = total_tfr_grandaverage_sham_EC.END.EC.powspctrm(:,[5:9 13:17],8:16);
% Sham_EC_theta_frontal_MeanThetaEND=mean(Sham_EC_theta_frontalEND,3);
% Sham_EC_theta_frontal_MeanThetaFrontalsEND=mean(Sham_EC_theta_frontal_MeanThetaEND,2);



%define groups for comparison
data1='total_tfr_grandaverage_active_EO';
data2='total_tfr_grandaverage_sham_EO';
%!!!!! CHEOK SUBJ NUMBERS AND VARIABLE NAMES

suf='.mat';

data1m=[data1 suf];
data2m=[data2 suf];

load(data1m);
load(data2m);

% Active_EO_theta_frontal = total_tfr_grandaverage_active_EO.BL.EO.powspctrm(:,[5:9 13:17],8:16);
% Active_EO_theta_frontal_MeanTheta=mean(Active_EO_theta_frontal,3);
% Active_EO_theta_frontal_MeanThetaFrontals=mean(Active_EO_theta_frontal_MeanTheta,2);
% 
% Sham_EO_theta_frontal = total_tfr_grandaverage_sham_EO.BL.EO.powspctrm(:,[5:9 13:17],8:16);
% Sham_EO_theta_frontal_MeanTheta=mean(Sham_EO_theta_frontal,3);
% Sham_EO_theta_frontal_MeanThetaFrontals=mean(Sham_EO_theta_frontal_MeanTheta,2);
% 
% Active_EO_theta_frontalEND = total_tfr_grandaverage_active_EO.END.EO.powspctrm(:,[5:9 13:17],8:16);
% Active_EO_theta_frontal_MeanThetaEND=mean(Active_EO_theta_frontalEND,3);
% Active_EO_theta_frontal_MeanThetaFrontalsEND=mean(Active_EO_theta_frontal_MeanThetaEND,2);
% 
% Sham_EO_theta_frontalEND = total_tfr_grandaverage_sham_EO.END.EO.powspctrm(:,[5:9 13:17],8:16);
% Sham_EO_theta_frontal_MeanThetaEND=mean(Sham_EO_theta_frontalEND,3);
% Sham_EO_theta_frontal_MeanThetaFrontalsEND=mean(Sham_EO_theta_frontal_MeanThetaEND,2);





% Frontal Alpha

% Active_EO_alpha_frontalBL = total_tfr_grandaverage_active_EO.BL.EO.powspctrm(:,[5:9 13:17],16:26);
% Active_EO_alpha_frontal_MeanAlphaBL=mean(Active_EO_alpha_frontalBL,3);
% Active_EO_alpha_frontal_MeanAlphaFrontalsBL=mean(Active_EO_alpha_frontal_MeanAlphaBL,2);
% 
% Sham_EO_alpha_frontalBL = total_tfr_grandaverage_sham_EO.BL.EO.powspctrm(:,[5:9 13:17],16:26);
% Sham_EO_alpha_frontal_MeanAlphaBL=mean(Sham_EO_alpha_frontalBL,3);
% Sham_EO_alpha_frontal_MeanAlphaFrontalsBL=mean(Sham_EO_alpha_frontal_MeanAlphaBL,2);
% 
% Active_EO_alpha_frontalEND = total_tfr_grandaverage_active_EO.END.EO.powspctrm(:,[5:9 13:17],16:26);
% Active_EO_alpha_frontal_MeanAlphaEND=mean(Active_EO_alpha_frontalEND,3);
% Active_EO_alpha_frontal_MeanAlphaFrontalsEND=mean(Active_EO_alpha_frontal_MeanAlphaEND,2);
% 
% Sham_EO_alpha_frontalEND = total_tfr_grandaverage_sham_EO.END.EO.powspctrm(:,[5:9 13:17],16:26);
% Sham_EO_alpha_frontal_MeanAlphaEND=mean(Sham_EO_alpha_frontalEND,3);
% Sham_EO_alpha_frontal_MeanAlphaFrontalsEND=mean(Sham_EO_alpha_frontal_MeanAlphaEND,2);



% Posterior Alpha

% Active_EO_alpha_posteriorBL = total_tfr_grandaverage_active_EO.BL.EO.powspctrm(:,[26 34 35 36 38 40],16:26);
% Active_EO_alpha_posterior_MeanAlphaBL=mean(Active_EO_alpha_posteriorBL,3);
% Active_EO_alpha_posterior_MeanAlphaposteriorBL=mean(Active_EO_alpha_posterior_MeanAlphaBL,2);
% 
% Sham_EO_alpha_posteriorBL = total_tfr_grandaverage_sham_EO.BL.EO.powspctrm(:,[26 34 35 36 38 40],16:26);
% Sham_EO_alpha_posterior_MeanAlphaBL=mean(Sham_EO_alpha_posteriorBL,3);
% Sham_EO_alpha_posterior_MeanAlphaposteriorBL=mean(Sham_EO_alpha_posterior_MeanAlphaBL,2);
% 
% Active_EO_alpha_posteriorEND = total_tfr_grandaverage_active_EO.END.EO.powspctrm(:,[26 34 35 36 38 40],16:26);
% Active_EO_alpha_posterior_MeanAlphaEND=mean(Active_EO_alpha_posteriorEND,3);
% Active_EO_alpha_posterior_MeanAlphaposteriorEND=mean(Active_EO_alpha_posterior_MeanAlphaEND,2);
% 
% Sham_EO_alpha_posteriorEND = total_tfr_grandaverage_sham_EO.END.EO.powspctrm(:,[26 34 35 36 38 40],16:26);
% Sham_EO_alpha_posterior_MeanAlphaEND=mean(Sham_EO_alpha_posteriorEND,3);
% Sham_EO_alpha_posterior_MeanAlphaposteriorEND=mean(Sham_EO_alpha_posterior_MeanAlphaEND,2);





% % Frontal Gamma
% 
% Active_EO_Gamma_frontalBL = total_tfr_grandaverage_active_EO.BL.EO.powspctrm(:,[5:9 13:17],40:90);
% Active_EO_Gamma_frontal_MeanGammaBL=mean(Active_EO_Gamma_frontalBL,3);
% Active_EO_Gamma_frontal_MeanGammafrontalBL=mean(Active_EO_Gamma_frontal_MeanGammaBL,2);
% 
% Sham_EO_Gamma_frontalBL = total_tfr_grandaverage_sham_EO.BL.EO.powspctrm(:,[5:9 13:17],40:90);
% Sham_EO_Gamma_frontal_MeanGammaBL=mean(Sham_EO_Gamma_frontalBL,3);
% Sham_EO_Gamma_frontal_MeanGammafrontalBL=mean(Sham_EO_Gamma_frontal_MeanGammaBL,2);
% 
% Active_EO_Gamma_frontalEND = total_tfr_grandaverage_active_EO.END.EO.powspctrm(:,[5:9 13:17],40:90);
% Active_EO_Gamma_frontal_MeanGammaEND=mean(Active_EO_Gamma_frontalEND,3);
% Active_EO_Gamma_frontal_MeanGammafrontalEND=mean(Active_EO_Gamma_frontal_MeanGammaEND,2);
% 
% Sham_EO_Gamma_frontalEND = total_tfr_grandaverage_sham_EO.END.EO.powspctrm(:,[5:9 13:17],40:90);
% Sham_EO_Gamma_frontal_MeanGammaEND=mean(Sham_EO_Gamma_frontalEND,3);
% Sham_EO_Gamma_frontal_MeanGammafrontalEND=mean(Sham_EO_Gamma_frontal_MeanGammaEND,2);

% posterior Gamma

Active_EO_Gamma_posteriorBL = total_tfr_grandaverage_active_EO.BL.EO.powspctrm(:,[26 34 35 36 38 40],40:90);
Active_EO_Gamma_posterior_MeanGammaBL=mean(Active_EO_Gamma_posteriorBL,3);
Active_EO_Gamma_posterior_MeanGammaposteriorBL=mean(Active_EO_Gamma_posterior_MeanGammaBL,2);

Sham_EO_Gamma_posteriorBL = total_tfr_grandaverage_sham_EO.BL.EO.powspctrm(:,[26 34 35 36 38 40],40:90);
Sham_EO_Gamma_posterior_MeanGammaBL=mean(Sham_EO_Gamma_posteriorBL,3);
Sham_EO_Gamma_posterior_MeanGammaposteriorBL=mean(Sham_EO_Gamma_posterior_MeanGammaBL,2);

Active_EO_Gamma_posteriorEND = total_tfr_grandaverage_active_EO.END.EO.powspctrm(:,[26 34 35 36 38 40],40:90);
Active_EO_Gamma_posterior_MeanGammaEND=mean(Active_EO_Gamma_posteriorEND,3);
Active_EO_Gamma_posterior_MeanGammaposteriorEND=mean(Active_EO_Gamma_posterior_MeanGammaEND,2);

Sham_EO_Gamma_posteriorEND = total_tfr_grandaverage_sham_EO.END.EO.powspctrm(:,[26 34 35 36 38 40],40:90);
Sham_EO_Gamma_posterior_MeanGammaEND=mean(Sham_EO_Gamma_posteriorEND,3);
Sham_EO_Gamma_posterior_MeanGammaposteriorEND=mean(Sham_EO_Gamma_posterior_MeanGammaEND,2);