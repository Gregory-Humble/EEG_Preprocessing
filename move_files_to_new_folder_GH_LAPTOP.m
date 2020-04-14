%% The following line gets rid of anything that might already be open:
clear all; close all; clc;
 addpath 'D:\Alz_Clinical_Trial'
cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
IDlist= {'346'}; %populate this list with the different participant IDs
for i = 1:length(IDlist)
    ID=IDlist{i}
    source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesclosed_BL.cnt']
    copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\BL_3_mins_eyes_closed', 'f')
end

%%
clear all; close all; clc;
 addpath 'D:\Alz_Clinical_Trial'
cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
IDlist= {'346'}; %populate this list with the different participant IDs
for i = 1:length(IDlist)
    ID=IDlist{i}
    source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesopen_BL.cnt']
    copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\BL_3_mins_eyes_open', 'f')
end

%%
clear all; close all; clc;
 addpath 'D:\Alz_Clinical_Trial'
cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
IDlist= {'346'}; %populate this list with the different participant IDs
for i = 1:length(IDlist)
    ID=IDlist{i}
    source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesclosed_END.cnt']
    copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\END_3_mins_eyes_closed', 'f')
end

%%
clear all; close all; clc;
 addpath 'D:\Alz_Clinical_Trial'
cd('D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\')
IDlist= {'346'}; %populate this list with the different participant IDs
for i = 1:length(IDlist)
    ID=IDlist{i}
    source = ['D:\Alz_Clinical_Trial\',ID,'\',ID, '_eyesopen_END.cnt']
    copyfile(source, 'D:\Alz_Clinical_Trial\Alz_Data_Analysis_10JAN20\END_3_mins_eyes_open', 'f')
end