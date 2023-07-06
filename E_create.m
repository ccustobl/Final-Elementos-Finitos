clear 
close all
clc
format short

%%

% Data
Data = {'sigmaxx' 'sigmaxy' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
Results_Data = {'StrAvgX_Data' 'StrAvgY_Data' 'StrVM_Data' 'X_VMmax' 'Y_VMmax' 'DispX_Data' 'DispY_Data' };


Ele_Type = 'Q8';  %Element Type%
TXT_Number = '400';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Isotropic';  %% 'Orthotropic' ; 'Isotropic'

for i_Data=1:length(Data)
    eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',num2str(Ref_R_Number),'_',Material,'=zeros(1,500);'))
    save(char(strcat('Data/E/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material)),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material)),'-v7.3');

    eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'=zeros(1,500);'))
    save(char(strcat('Data/E/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material)),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material)),'-v7.3');
end