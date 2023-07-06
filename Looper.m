clear 
close all
clc
format short


%%% User Parameter Selection

TXT_Number = {'6'};  %Mesh Number% '0' '00' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10'   '31' '32' '33' '34' '35' '40' '41' '50' '51' '52' '53' '54' '55' '56' '60' '61' '70' '71' '80' '90' '91' '92' '100' '101' '102' '103'
Ele_Type = {'Q16'};  %Element Type% 'Q4' 'Q8' 'Q9' 'Q12' 'Q16'
Ref_R = {'No'};
Ref_R_Number = {'2'};  %R Refinement Number%
Calculate_K = 'Yes';  %% 'Yes' ; 'No'
Save_K = 'No';  %% 'Yes' ; 'No'
Material = 'Orthotropic';  %% 'Orthotropic' ; 'Isotropic'
DAF = 5000;  %Displacement Amplifying Factor%
Simetric = 'No';  %% 'Yes' ; 'No'
if strcmp(Material(1:5),'Ortho')==1
    Simetric = 'No';
end

i_Ref = 1;

%%% Loop
for i_Type=1:length(Ele_Type)
    %% Vuelta
    for i_Number=1:length(TXT_Number)
        for i_Ref=1:length(Ref_R)
            switch char(Ref_R(i_Ref))
                case 'No'                    
                    Looper_Main(char(TXT_Number(i_Number)),char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),'0',Calculate_K,Save_K,Material,DAF,Simetric)
                case 'Yes'
                    for i_R_Number=1:length(Ref_R_Number)
                        Looper_Main(char(TXT_Number(i_Number)),char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),char(Ref_R_Number(i_R_Number)),Calculate_K,Save_K,Material,DAF,Simetric)
                    end
            end
        end
    end
end
%%
