clear 
close all
clc


%% Variables

Material = { 'Orthotropic' 'Isotropic' };
Simetric = { 'Yes' 'No' };
Ele_Type = { 'Q4' 'Q8' 'Q9' 'Q12' 'Q16' };  %Element Type%
E = [ 150000 165000 180000 ];
Alpha = [ 0 45 90 135 ];
Data = { 'taomax' };  %Measured Variables% 'nNod' 'nEle' 'errorG' 'errorG_1' 'sigmaxx' 'sigmaxy' 'sigmavm' 'dispmaxx' 'dispmaxy' 
Ref_R = { 'No' 'Yes' 'Yes' };
Ref_R_Number = { '0' '1' '2' };   %R Refinement Number%


%% Data List
for i_Alpha=1:length(Alpha)
    eval(char(erase(join(strcat(['Data_List_Full_Orthotropic','_',num2str(Alpha(i_Alpha)),'= strings([length(Ele_Type),length(Data)*length(Ref_R_Number)]);']))," ")));
end

for i_E=1:length(E)
    eval(char(erase(join(strcat(['Data_List_Full_Isotropic','_',num2str(E(i_E)/1000),'= strings([length(Ele_Type),length(Data)*length(Ref_R_Number)]);']))," ")));
    eval(char(erase(join(strcat(['Data_List_Half_Isotropic','_',num2str(E(i_E)/1000),'= strings([length(Ele_Type),length(Data)*length(Ref_R_Number)]);']))," ")));
end

for i_Data=1:length(Data)
    for i_Type=1:length(Ele_Type)
        for i_Simetric=1:length(Simetric)
            switch char(Simetric(i_Simetric))                
                case 'Yes'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000));
                                                eval(char(strcat('Data_List_Half_Isotropic_',num2str(E(i_E)/1000),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                            case 'No'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000));
                                                eval(char(strcat('Data_List_Half_Isotropic_',num2str(E(i_E)/1000),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                        end
                                    end
                                end
                        end
                    end
                case 'No'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000));
                                                eval(char(strcat('Data_List_Full_Isotropic_',num2str(E(i_E)/1000),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                            case 'No'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000));
                                                eval(char(strcat('Data_List_Full_Isotropic_',num2str(E(i_E)/1000),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                        end
                                    end
                                end
                            case 'Orthotropic'  
                                for i_R_Number=1:length(Ref_R_Number)
                                    for i_Alpha=1:length(Alpha)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha)));
                                                eval(char(strcat('Data_List_Full_Orthotropic_',num2str(Alpha(i_Alpha)),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                            case 'No'
                                                aux = strcat(Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha)));
                                                eval(char(strcat('Data_List_Full_Orthotropic_',num2str(Alpha(i_Alpha)),'(i_Type,i_Data+length(Data)*(i_R_Number-1))','=char(aux);')))
                                        end
                                    end
                                end
                        end
                    end
            end
        end
    end
end

for i_Alpha=1:length(Alpha)
    save(char(erase(join(strcat(['Data/Full/Orthotropic/',num2str(Alpha(i_Alpha)),'/Data_List_Full_Orthotropic','_',num2str(Alpha(i_Alpha))]))," ")),char(erase(join(strcat(['Data_List_Full_Orthotropic','_',num2str(Alpha(i_Alpha))]))," ")),'-v7.3');
end

for i_E=1:length(E)
    save(char(erase(join(strcat(['Data/Full/Isotropic/',num2str(E(i_E)/1000),'/Data_List_Full_Isotropic','_',num2str(E(i_E)/1000)]))," ")),char(erase(join(strcat(['Data_List_Full_Isotropic','_',num2str(E(i_E)/1000)]))," ")),'-v7.3');
    save(char(erase(join(strcat(['Data/Half/Isotropic/',num2str(E(i_E)/1000),'/Data_List_Full_Isotropic','_',num2str(E(i_E)/1000)]))," ")),char(erase(join(strcat(['Data_List_Half_Isotropic','_',num2str(E(i_E)/1000)]))," ")),'-v7.3');
end


%% Vectors 

for i_Data=1:length(Data)
    for i_Type=1:length(Ele_Type)
        for i_Simetric=1:length(Simetric)
            switch char(Simetric(i_Simetric))                
                case 'Yes'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                eval(char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000),'=zeros(1,500);'])," ")));
                                            case 'No'
                                                eval(char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000),'=zeros(1,500);'])," ")));
                                        end
                                    end
                                end
                        end
                    end
                case 'No'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                eval(char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000),'=zeros(1,500);'])," ")));
                                            case 'No'
                                                eval(char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000),'=zeros(1,500);'])," ")));
                                        end
                                    end
                                end
                            case 'Orthotropic'
                                for i_R_Number=1:length(Ref_R_Number)
                                    for i_Alpha=1:length(Alpha)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                eval(char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha)),'=zeros(1,500);'])," ")));
                                            case 'No'
                                                eval(char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha)),'=zeros(1,500);'])," ")));
                                        end
                                    end
                                end  
                        end
                    end
            end
        end                    
    end
end


%% Data Save

for i_Data=1:length(Data)
    for i_Type=1:length(Ele_Type)
        for i_Simetric=1:length(Simetric)
            switch char(Simetric(i_Simetric))                
                case 'Yes'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                save(char(erase(join(strcat(['Data/Half/Isotropic/',num2str(E(i_E)/1000),'/',Data(i_Data),'_',Ele_Type(i_Type),'_r',char(Ref_R_Number(i_R_Number)),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)]))," ")),char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)])," ")),'-v7.3');
                                            case 'No'
                                                save(char(erase(join(strcat(['Data/Half/Isotropic/',num2str(E(i_E)/1000),'/',Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)]))," ")),char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)])," ")),'-v7.3');
                                        end
                                    end
                                end
                        end
                    end
                case 'No'
                    for i_Material=1:length(Material)
                        switch char(Material(i_Material))
                            case 'Isotropic'
                                for i_E=1:length(E)
                                    for i_R_Number=1:length(Ref_R_Number)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                save(char(erase(join(strcat(['Data/Full/Isotropic/',num2str(E(i_E)/1000),'/',Data(i_Data),'_',Ele_Type(i_Type),'_r',char(Ref_R_Number(i_R_Number)),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)]))," ")),char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)])," ")),'-v7.3');
                                            case 'No'
                                                save(char(erase(join(strcat(['Data/Full/Isotropic/',num2str(E(i_E)/1000),'/',Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)]))," ")),char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(E(i_E)/1000)])," ")),'-v7.3');
                                        end
                                    end
                                end
                            case 'Orthotropic'
                                for i_R_Number=1:length(Ref_R_Number)
                                    for i_Alpha=1:length(Alpha)
                                        switch char(Ref_R(i_R_Number))
                                            case 'Yes'
                                                save(char(erase(join(strcat(['Data/Full/Orthotropic/',num2str(Alpha(i_Alpha)),'/',Data(i_Data),'_',Ele_Type(i_Type),'_r',char(Ref_R_Number(i_R_Number)),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha))]))," ")),char(erase(join([Data(i_Data),'_',Ele_Type(i_Type),'_r',Ref_R_Number(i_R_Number),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha))])," ")),'-v7.3');
                                            case 'No'
                                                save(char(erase(join(strcat(['Data/Full/Orthotropic/',num2str(Alpha(i_Alpha)),'/',Data(i_Data),'_',Ele_Type(i_Type),'_',char(Material(i_Material)),'_',num2str(Alpha(i_Alpha))]))," ")),char(erase(join([string(Data(i_Data)),'_',Ele_Type(i_Type),'_',(Material(i_Material)),'_',num2str(Alpha(i_Alpha))])," ")),'-v7.3');
                                        end
                                    end
                                end
                        end
                    end
            end
        end
    end
end

disp('Data SAVED')

