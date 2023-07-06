function [nNod_Vector,nEle_Vector,errorG_Vector,errorG_1_Vector,sigmaxx_Vector,sigmaxy_Vector,taomax_Vector,sigmavm_Vector,dispmaxx_Vector,dispmaxy_Vector]=Data_Load(Ele_Type,Ref_R,Ref_R_Number,Material,Simetric,E,Alpha)

Data = { 'nNod' 'nEle' 'errorG' 'errorG_1' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'dispmaxx' 'dispmaxy' };

switch Simetric
    
    case 'Yes'
        switch Material
            case 'Isotropic'
                switch Ref_R
                    case 'Yes'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Half/Isotropic/',num2str(E/1000),'/',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),';'))
                        end
                    case 'No'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Half/Isotropic/',num2str(E/1000),'/',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),';'))
                        end
                end 
        end
        
    case 'No'
        switch Material
            case 'Isotropic'
                switch Ref_R
                    case 'Yes'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Full/Isotropic/',num2str(E/1000),'/',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(E/1000),';'))
                        end
                    case 'No'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Full/Isotropic/',num2str(E/1000),'/',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(E/1000),';'))
                        end
                end                
            case 'Orthotropic'
                switch Ref_R
                    case 'Yes'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Full/Orthotropic/',num2str(Alpha),'/',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),'=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),'.',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_r',Ref_R_Number,'_',Material,'_',num2str(Alpha),';'))
                        end
                    case 'No'
                        for i_Data=1:length(Data)
                            aux=matfile(strcat('Data/Full/Orthotropic/',num2str(Alpha),'/',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'.mat'));
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'=aux;'))
                            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),'.',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),';'))
                            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',Material,'_',num2str(Alpha),';'))
                        end
                end

        end
end

disp('Data LOADED')

