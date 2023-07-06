function alpha_save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Disp,StrAvgNod,E1,E2,G12,Alpha)

% Str Max
StrAvgX_Data = max(StrAvgNod(:,1));
StrAvgY_Data = max(StrAvgNod(:,2));
TaoAvgXY_Data = max(StrAvgNod(:,3));
StrVM_Data = max(StrAvgNod(:,4));
Node_VM = find(StrAvgNod(:,4)==StrVM_Data);
X_VMmax = Nodes(Node_VM,1);
Y_VMmax = Nodes(Node_VM,2);

% Disp Max
Node_UR = find(abs(Nodes(:,1) - 100) <1e-9 & abs(Nodes(:,2) - 30)<1e-9);
DispX_Data = Disp(Node_UR,1);
DispY_Data = Disp(Node_UR,2);

% Data
Data = { 'alpha' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
Results_Data = { 'Alpha' 'StrAvgX_Data' 'StrAvgY_Data' 'TaoAvgXY_Data' 'StrVM_Data' 'X_VMmax' 'Y_VMmax' 'DispX_Data' 'DispY_Data' };

% Position
Position = Alpha/10 + 1;

% Load Vectors
switch Ref_R
    case 'Yes'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/Alpha/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
        end
    case 'No'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/Alpha/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
        end
end

% Fill & Save Vectors
for i_Data=1:length(Data)
    switch Ref_R
        case 'Yes'
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_Vector;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
            save(char(strcat('Data/Alpha/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),'-v7.3');
        case 'No'
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_Vector;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
            save(char(strcat('Data/Alpha/',Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000))),'-v7.3');
    end
end


disp('Data SAVED')

