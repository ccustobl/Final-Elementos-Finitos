function Data_Save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Simetric,nNod,nEle,etaG,etaG_1,Disp,StrAvgNod,E,Alpha)

% Str Max
StrAvgX_Data = max(StrAvgNod(:,1));
StrAvgY_Data = max(StrAvgNod(:,2));
TaoAvgXY_Data = max(StrAvgNod(:,3));
StrVM_Data = max(StrAvgNod(:,4));

% Disp Max
Node_UR = find(abs(Nodes(:,1) - 100) <1e-9 & abs(Nodes(:,2) - 30)<1e-9);
DispX_Data = Disp(Node_UR,1);
DispY_Data = Disp(Node_UR,2);

% Data
Data = { 'nNod' 'nEle' 'errorG' 'errorG_1' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'dispmaxx' 'dispmaxy' };
Results_Data = { 'nNod' 'nEle' 'etaG' 'etaG_1' 'StrAvgX_Data' 'StrAvgY_Data' 'TaoAvgXY_Data' 'StrVM_Data' 'DispX_Data' 'DispY_Data' };

% Position
if strcmp(TXT_Number,'0')==1
    Position = 1;
elseif strcmp(TXT_Number,'00')==1
    Position = 2;
else
    Position = str2double(TXT_Number)+2;
end

% Load Vectors
[nNod_Vector,nEle_Vector,errorG_Vector,errorG_1_Vector,sigmaxx_Vector,sigmaxy_Vector,taomax_Vector,sigmavm_Vector,dispmaxx_Vector,dispmaxy_Vector]=Data_Load(Ele_Type,Ref_R,Ref_R_Number,Material,Simetric,E,Alpha);

% Fill & Save Vectors
for i_Data=1:length(Data)
    switch Simetric

        case 'Yes'
            switch Material
                case 'Isotropic'
                    switch Ref_R
                        case 'Yes'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Half/Isotropic/',num2str(E/1000),'/',Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000))),'-v7.3');
                        case 'No'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Half/Isotropic/',num2str(E/1000),'/',Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(E/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(E/1000))),'-v7.3');
                    end
            end

        case 'No'
            switch Material
                case 'Isotropic'
                    switch Ref_R
                        case 'Yes'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Full/Isotropic/',num2str(E/1000),'/',Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000))),'-v7.3');

                        case 'No'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Full/Isotropic/',num2str(E/1000),'/',Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(E/1000))),char(strcat(Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(E/1000))),'-v7.3');
                    end
                case 'Orthotropic'
                    switch Ref_R
                        case 'Yes'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(Alpha),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(Alpha),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Full/Orthotropic/',num2str(Alpha),'/',Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha))),char(strcat(Data(i_Data),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha))),'-v7.3');
                        case 'No'
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'=',char(Data(i_Data)),'_Vector;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'(1,',num2str(Position),')','=',char(Results_Data(i_Data)),';'))
                            save(char(strcat('Data/Full/Orthotropic/',num2str(Alpha),'/',Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(Alpha))),char(strcat(Data(i_Data),'_',Ele_Type,'_',Material,'_',num2str(Alpha))),'-v7.3');
                    end                
            end        
    end
end


disp('Data SAVED')

