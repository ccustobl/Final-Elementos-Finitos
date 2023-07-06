function E_save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Disp,StrAvgNod,E)

% Str Max
StrAvgX_Data = max(StrAvgNod(:,1));
StrAvgY_Data = max(StrAvgNod(:,2));
StrVM_Data = max(StrAvgNod(:,4));
Node_VM = find(StrAvgNod(:,4)==StrVM_Data);
X_VMmax = Nodes(Node_VM,1);
Y_VMmax = Nodes(Node_VM,2);

% Disp Max
Node_UR = find(abs(Nodes(:,1) - 100) <1e-9 & abs(Nodes(:,2) - 30)<1e-9);
DispX_Data = Disp(Node_UR,1);
DispY_Data = Disp(Node_UR,2);

% Position
Position = E/1e4;

% Data
Data = {'sigmaxx' 'sigmaxy' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
Results_Data = {'StrAvgX_Data' 'StrAvgY_Data' 'StrVM_Data' 'X_VMmax' 'Y_VMmax' 'DispX_Data' 'DispY_Data' };

% Load
switch Ref_R
    case 'Yes'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/E/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,';'))
        end
    case 'No'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/E/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,';'))
        end
end 

% Save
for i_Data=1:length(Data)
    switch Ref_R
        case 'Yes'
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',num2str(Ref_R_Number),'_',Material,'=',char(Data(i_Data)),'_Vector;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',num2str(Ref_R_Number),'_',Material,'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
            save(char(strcat('Data/E/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material)),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material)),'-v7.3');

        case 'No'
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'=',char(Data(i_Data)),'_Vector;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
            save(char(strcat('Data/E/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material)),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material)),'-v7.3');
    end
end


disp('Data SAVED')
