function save_k(K,Simetric,Ele_Type,Save_K,TXT_Number,Ref_R,Ref_R_Number,Material,E,Alpha)

disp('Stiffness Matrix SAVING')
switch Simetric    
    case 'Yes'
        switch Material
            case 'Isotropic'
                switch Save_K
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                save(strcat(['Matrixes/Half/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                            case 'No'
                                save(strcat(['Matrixes/Half/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(E/1000)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                        end
                    case 'No'
                        disp('Stiffness Matrix NOT SAVED')
                end
        end        
    case 'No'
        switch Material
            case 'Isotropic'
                switch Save_K
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                save(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                            case 'No'
                                save(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(E/1000)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                        end
                    case 'No'
                        disp('Stiffness Matrix NOT SAVED')
                end
            case 'Orthotropic'
                switch Save_K
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                save(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(Alpha)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                            case 'No'
                                save(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(Alpha)]),'K','-v7.3')
                                disp('Stiffness Matrix SAVED')
                        end
                    case 'No'
                        disp('Stiffness Matrix NOT SAVED')
                end
        end        
end

