clear 
close all
clc
format short


%%
Data = {'taomax'}; % 'alpha' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' 

E1 = 10e3;     %MPa
E2 = 10e3;     %MPa
% E3 = 200e3;     %MPa
G12 = 5e3;     %MPa
v12 = 0.3;

Ele_Type = 'Q16';  %Element Type%
TXT_Number = '404';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Orthotropic';  %% 'Orthotropic' ; 'Isotropic'


for i_Data = 1:length(Data)
    eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=zeros(1,500);'))
    save(char(strcat('Data/Alpha/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),'-v7.3');

    eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=zeros(1,500);'))
    save(char(strcat('Data/Alpha/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),'-v7.3');
end

