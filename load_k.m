function K = load_k(Simetric,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,E,Alpha)

disp('Stiffness Matrix LOADING')

switch Simetric
    
    case 'Yes'
        switch Material
            case 'Isotropic'
                switch Ref_R
                    case 'Yes'
                        K = matfile(strcat(['Matrixes/Half/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'.mat']));
                        K = K.K;
                    case 'No'
                        K = matfile(strcat(['Matrixes/Half/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(E/1000),'.mat']));
                        K = K.K;
                end 
        end
        
    case 'No'
        switch Material
            case 'Orthotropic'
                switch Ref_R
                    case 'Yes'
                        K = matfile(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(Alpha),'.mat']));
                        K = K.K;
                    case 'No'
                        K = matfile(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(Alpha),'.mat']));
                        K = K.K;
                end
            case 'Isotropic'
                switch Ref_R
                    case 'Yes'
                        K = matfile(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'_',Material,'_',num2str(E/1000),'.mat']));
                        K = K.K;
                    case 'No'
                        K = matfile(strcat(['Matrixes/Full/K_',Ele_Type,'_',num2str(TXT_Number),'_',Material,'_',num2str(E/1000),'.mat']));
                        K = K.K;
                end 
        end
end
            
disp('Stiffness Matrix LOADED')

