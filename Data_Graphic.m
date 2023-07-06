%% Este programa realiza los graficos vistos en el informe.

clc
close all
clear


%% Data Load Loop
Data = { 'nNod' 'nEle' 'errorG' 'errorG_1' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'dispmaxx' 'dispmaxy' };  %Measured Variables%
Ele_Type = { 'Q4' 'Q8' 'Q9' 'Q12' 'Q16' };  %Element Type%
Ref_R = { 'No' 'Yes' };
Ref_R_Number = { '2' };  %R Refinement Number%
Material = { 'Orthotropic' 'Isotropic' };  %% 'Orthotropic' ; 'Isotropic'
Simetric = 'No';  %% 'Yes' ; 'No'
E = 165;
Alpha = 45;

for i_Type=1:length(Ele_Type)
    for i_Ref=1:length(Ref_R)
        for i_R_Number=1:length(Ref_R_Number)
            for i_Material=1:length(Material)
                switch char(Material(i_Material))
                    case 'Isotropic'
                        for i_E=1:length(E)
                            switch char(Ref_R(i_Ref))
                                case 'Yes'
                                    eval(strcat('[nNod_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',nEle_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',errorG_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',errorG_1_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',sigmaxx_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',sigmaxy_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',sigmavm_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',dispmaxx_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),',dispmaxy_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Iso_',num2str(E(i_E)),']=Data_Load(char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),char(Ref_R_Number(i_R_Number)),char(Material(i_Material)),Simetric,E(i_E)*1000);'));
                                case 'No'
                                    eval(strcat('[nNod_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',nEle_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',errorG_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',errorG_1_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',sigmaxx_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',sigmaxy_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',sigmavm_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',dispmaxx_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),',dispmaxy_',char(Ele_Type(i_Type)),'_Iso_',num2str(E(i_E)),']=Data_Load(char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),char(Ref_R_Number(i_R_Number)),char(Material(i_Material)),Simetric,E(i_E)*1000);'));
                            end
                        end
                    case 'Orthotropic'
                        for i_Alpha=1:length(Alpha)
                             switch char(Ref_R(i_Ref))
                                case 'Yes'
                                    eval(strcat('[nNod_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',nEle_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',errorG_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',errorG_1_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmaxx_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmaxy_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmavm_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort',num2str(Alpha(i_Alpha)),',dispmaxx_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),',dispmaxy_',char(Ele_Type(i_Type)),'_r',char(Ref_R_Number(i_R_Number)),'_Ort','_',num2str(Alpha(i_Alpha)),']=Data_Load(char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),char(Ref_R_Number(i_R_Number)),char(Material(i_Material)),Simetric,0,',num2str(Alpha(i_Alpha)),');'));
                                 case 'No'
                                    eval(strcat('[nNod_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',nEle_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',errorG_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',errorG_1_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmaxx_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmaxy_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',sigmavm_',char(Ele_Type(i_Type)),'_Ort',num2str(Alpha(i_Alpha)),',dispmaxx_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),',dispmaxy_',char(Ele_Type(i_Type)),'_Ort','_',num2str(Alpha(i_Alpha)),']=Data_Load(char(Ele_Type(i_Type)),char(Ref_R(i_Ref)),char(Ref_R_Number(i_R_Number)),char(Material(i_Material)),Simetric,0,',num2str(Alpha(i_Alpha)),');'));
                             end       
                        end
                end
                clc
            end
        end
    end
end


%% Alpha Load Loop

Data = { 'alpha' 'sigmaxx' 'sigmaxy' 'taomax' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
Ele_Type_Vector = {'Q8' 'Q8' 'Q8' 'Q8' 'Q8' 'Q8' 'Q16' 'Q16' 'Q16' 'Q16' 'Q16'};  %Element Type%
TXT_Number_Vector = {'400' '400' '400' '400' '400' '400' '404' '404' '404' '404' '404'};  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Orthotropic'; 
E1_Vector = [500e3 150e3 50e3 100e3 150e3 200e3 200e3 25e3 400e3 22e3 10e3];
E2_Vector = [50e3 180e3 10e3 10e3 10e3 10e3 10e3 10e3 10e3 11e3 10e3];
G12_Vector = [75e3 75e3 5e3 5e3 5e3 5e3 5e3 5e3 5e3 5e3 5e3];     %MPa

switch Ref_R
    case 'Yes'
        for i_Data=1:length(Data)
            for i_E = 1:length(E1_Vector)
                E1 = E1_Vector(i_E);
                E2 = E2_Vector(i_E);
                G12 = G12_Vector(i_E);
                TXT_Number = char(TXT_Number_Vector(i_E));
                Ele_Type = char(Ele_Type_Vector(i_E));
                aux=matfile(strcat('Data/Alpha/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
                eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
                eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
                eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            end
        end
    case 'No'
        for i_Data=1:length(Data)
            for i_E = 1:length(E1_Vector)
                E1 = E1_Vector(1,i_E);
                E2 = E2_Vector(1,i_E);
                aux=matfile(strcat('Data/Alpha/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
                eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
                eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
                eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E1/1000),'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            end
        end
end


%% E Load Loop

Data = {'sigmaxx' 'sigmaxy' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
Ele_Type = 'Q8';
Case = 'Final';
Borders = 'Straight';
TXT_Number = '400';
Ref_R = 'Yes';
Ref_R_Number = '2';
Material = 'Isotropic';

[Nodes,Elements] = select_mesh(Ele_Type,Case,Simetric,TXT_Number,Ref_R,Ref_R_Number,Borders);

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


%% SURF Load

% Data
Data = { 'alpha' 'sigmaxx' 'sigmaxy' 'sigmavm' 'xvmmax' 'yvmmax' 'dispmaxx' 'dispmaxy' };
E2 = 10e3;     %MPa
% E3 = 200e3;     %MPa
G12 = 5e3;     %MPa
v12 = 0.3;
Ele_Type = 'Q16';  %Element Type%
TXT_Number = '404';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Orthotropic';  %% 'Orthotropic' ; 'Isotropic'

% Load Vectors
switch Ref_R
    case 'Yes'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/Surf/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_r',Ref_R_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
        end
    case 'No'
        for i_Data=1:length(Data)
            aux=matfile(strcat('Data/Surf/',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'.mat'));
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'=aux;'))
            eval(strcat(char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),'.',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
            eval(strcat(char(Data(i_Data)),'_Vector','=',char(Data(i_Data)),'_',Ele_Type,'_',TXT_Number,'_',Material,'_',num2str(E2/1000),'_',num2str(G12/1000),';'))
        end
end


%%
disp('Data LOADED')

%% CALCULO DE PENDIENTES

% Homogenea Iso
Pend_Q4_Hom_Iso =  -(log(errorG_1_Q4_Iso_165(1,10))-log(errorG_1_Q4_Iso_165(1,11)))/(log(2*nNod_Q4_Iso_165(1,11))-log(2*nNod_Q4_Iso_165(1,10)));
Pend_Q8_Hom_Iso =  -(log(errorG_1_Q8_Iso_165(1,10))-log(errorG_1_Q8_Iso_165(1,11)))/(log(2*nNod_Q8_Iso_165(1,11))-log(2*nNod_Q8_Iso_165(1,10)));
Pend_Q9_Hom_Iso =  -(log(errorG_1_Q9_Iso_165(1,10))-log(errorG_1_Q9_Iso_165(1,11)))/(log(2*nNod_Q9_Iso_165(1,11))-log(2*nNod_Q9_Iso_165(1,10)));
Pend_Q12_Hom_Iso = -(log(errorG_1_Q12_Iso_165(1,7))-log(errorG_1_Q12_Iso_165(1,8)))/(log(2*nNod_Q12_Iso_165(1,8))-log(2*nNod_Q12_Iso_165(1,7)));
Pend_Q16_Hom_Iso = -(log(errorG_1_Q16_Iso_165(1,8))-log(errorG_1_Q16_Iso_165(1,9)))/(log(2*nNod_Q16_Iso_165(1,9))-log(2*nNod_Q16_Iso_165(1,8)));

% Homogenea Ort
Pend_Q4_Hom_Ort =  -(log(errorG_1_Q4_Ort_45(1,10))-log(errorG_1_Q4_Ort_45(1,11)))/(log(2*nNod_Q4_Ort_45(1,11))-log(2*nNod_Q4_Ort_45(1,10)));
Pend_Q8_Hom_Ort =  -(log(errorG_1_Q8_Ort_45(1,10))-log(errorG_1_Q8_Ort_45(1,11)))/(log(2*nNod_Q8_Ort_45(1,11))-log(2*nNod_Q8_Ort_45(1,10)));
Pend_Q9_Hom_Ort =  -(log(errorG_1_Q9_Ort_45(1,10))-log(errorG_1_Q9_Ort_45(1,11)))/(log(2*nNod_Q9_Ort_45(1,11))-log(2*nNod_Q9_Ort_45(1,10)));
Pend_Q12_Hom_Ort = -(log(errorG_1_Q12_Ort_45(1,7))-log(errorG_1_Q12_Ort_45(1,8)))/(log(2*nNod_Q12_Ort_45(1,8))-log(2*nNod_Q12_Ort_45(1,7)));
Pend_Q16_Hom_Ort = -(log(errorG_1_Q16_Ort_45(1,8))-log(errorG_1_Q16_Ort_45(1,9)))/(log(2*nNod_Q16_Ort_45(1,9))-log(2*nNod_Q16_Ort_45(1,8)));

% Mejorada Ort
Pend_Q4_Mej_Ort =  -(log(errorG_1_Q4_r2_Ort_45(1,405))-log(errorG_1_Q4_r2_Ort_45(1,404)))/(log(2*nNod_Q4_r2_Ort_45(1,404))-log(2*nNod_Q4_r2_Ort_45(1,405)));
Pend_Q8_Mej_Ort =  -(log(errorG_1_Q8_r2_Ort_45(1,405))-log(errorG_1_Q8_r2_Ort_45(1,404)))/(log(2*nNod_Q8_r2_Ort_45(1,404))-log(2*nNod_Q8_r2_Ort_45(1,405)));
Pend_Q9_Mej_Ort =  -(log(errorG_1_Q9_r2_Ort_45(1,405))-log(errorG_1_Q9_r2_Ort_45(1,404)))/(log(2*nNod_Q9_r2_Ort_45(1,404))-log(2*nNod_Q9_r2_Ort_45(1,405)));
Pend_Q12_Mej_Ort = -(log(errorG_1_Q12_r2_Ort_45(1,406))-log(errorG_1_Q12_r2_Ort_45(1,405)))/(log(2*nNod_Q12_r2_Ort_45(1,405))-log(2*nNod_Q12_r2_Ort_45(1,406)));
Pend_Q16_Mej_Ort = -(log(errorG_1_Q16_r2_Ort_45(1,406))-log(errorG_1_Q16_r2_Ort_45(1,405)))/(log(2*nNod_Q16_r2_Ort_45(1,405))-log(2*nNod_Q16_r2_Ort_45(1,406)));

Pend_Q4_Mej_Ort_Ele =  -(log(errorG_1_Q4_r2_Ort_45(1,405))-log(errorG_1_Q4_r2_Ort_45(1,404)))/(log(nEle_Q4_r2_Ort_45(1,404))-log(nEle_Q4_r2_Ort_45(1,405)));
Pend_Q8_Mej_Ort_Ele =  -(log(errorG_1_Q8_r2_Ort_45(1,405))-log(errorG_1_Q8_r2_Ort_45(1,404)))/(log(nEle_Q8_r2_Ort_45(1,404))-log(nEle_Q8_r2_Ort_45(1,405)));
Pend_Q9_Mej_Ort_Ele =  -(log(errorG_1_Q9_r2_Ort_45(1,405))-log(errorG_1_Q9_r2_Ort_45(1,404)))/(log(nEle_Q9_r2_Ort_45(1,404))-log(nEle_Q9_r2_Ort_45(1,405)));
Pend_Q12_Mej_Ort_Ele = -(log(errorG_1_Q12_r2_Ort_45(1,406))-log(errorG_1_Q12_r2_Ort_45(1,405)))/(log(nEle_Q12_r2_Ort_45(1,405))-log(nEle_Q12_r2_Ort_45(1,406)));
Pend_Q16_Mej_Ort_Ele = -(log(errorG_1_Q16_r2_Ort_45(1,406))-log(errorG_1_Q16_r2_Ort_45(1,405)))/(log(nEle_Q16_r2_Ort_45(1,405))-log(nEle_Q16_r2_Ort_45(1,406)));


%% CALCULO DE CONSTANTES

% Homogenea Iso
Const_Q4_Hom_Iso = errorG_1_Q4_Iso_165(1,10)/(2*nNod_Q4_Iso_165(1,10))^Pend_Q4_Hom_Iso;
Const_Q8_Hom_Iso = errorG_1_Q8_Iso_165(1,10)/(2*nNod_Q8_Iso_165(1,10))^Pend_Q8_Hom_Iso;
Const_Q9_Hom_Iso = errorG_1_Q9_Iso_165(1,10)/(2*nNod_Q9_Iso_165(1,10))^Pend_Q9_Hom_Iso;
Const_Q12_Hom_Iso = errorG_1_Q12_Iso_165(1,8)/(2*nNod_Q12_Iso_165(1,8))^Pend_Q12_Hom_Iso;
Const_Q16_Hom_Iso = errorG_1_Q16_Iso_165(1,8)/(2*nNod_Q16_Iso_165(1,8))^Pend_Q16_Hom_Iso;

% Homogenea Ort
Const_Q4_Hom_Ort = errorG_1_Q4_Ort_45(1,10)/(2*nNod_Q4_Ort_45(1,10))^Pend_Q4_Hom_Ort;
Const_Q8_Hom_Ort = errorG_1_Q8_Ort_45(1,10)/(2*nNod_Q8_Ort_45(1,10))^Pend_Q8_Hom_Ort;
Const_Q9_Hom_Ort = errorG_1_Q9_Ort_45(1,10)/(2*nNod_Q9_Ort_45(1,10))^Pend_Q9_Hom_Ort;
Const_Q12_Hom_Ort = errorG_1_Q12_Ort_45(1,8)/(2*nNod_Q12_Ort_45(1,8))^Pend_Q12_Hom_Ort;
Const_Q16_Hom_Ort = errorG_1_Q16_Ort_45(1,8)/(2*nNod_Q16_Ort_45(1,8))^Pend_Q16_Hom_Ort;

% Mejorada Ort
Const_Q4_Mej_Ort = errorG_1_Q4_r2_Ort_45(1,405)/(2*nNod_Q4_r2_Ort_45(1,405))^Pend_Q4_Mej_Ort;
Const_Q8_Mej_Ort = errorG_1_Q8_r2_Ort_45(1,405)/(2*nNod_Q8_r2_Ort_45(1,405))^Pend_Q8_Mej_Ort;
Const_Q9_Mej_Ort = errorG_1_Q9_r2_Ort_45(1,405)/(2*nNod_Q9_r2_Ort_45(1,405))^Pend_Q9_Mej_Ort;
Const_Q12_Mej_Ort = errorG_1_Q12_r2_Ort_45(1,405)/(2*nNod_Q12_r2_Ort_45(1,405))^Pend_Q12_Mej_Ort;
Const_Q16_Mej_Ort = errorG_1_Q16_r2_Ort_45(1,405)/(2*nNod_Q16_r2_Ort_45(1,405))^Pend_Q16_Mej_Ort;

Const_Q4_Mej_Ort_Ele = errorG_1_Q4_r2_Ort_45(1,405)/(nEle_Q4_r2_Ort_45(1,405))^Pend_Q4_Mej_Ort;
Const_Q8_Mej_Ort_Ele = errorG_1_Q8_r2_Ort_45(1,405)/(nEle_Q8_r2_Ort_45(1,405))^Pend_Q8_Mej_Ort;
Const_Q9_Mej_Ort_Ele = errorG_1_Q9_r2_Ort_45(1,405)/(nEle_Q9_r2_Ort_45(1,405))^Pend_Q9_Mej_Ort;
Const_Q12_Mej_Ort_Ele = errorG_1_Q12_r2_Ort_45(1,405)/(nEle_Q12_r2_Ort_45(1,405))^Pend_Q12_Mej_Ort;
Const_Q16_Mej_Ort_Ele = errorG_1_Q16_r2_Ort_45(1,405)/(nEle_Q16_r2_Ort_45(1,405))^Pend_Q16_Mej_Ort;

%% Graficos Ortotropo
% 
% % S_xx y Desp
% figure(1)
% set(figure(1),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% title('Evolución de Tensiones y Desplazamientos en X','FontSize',20)
% 
% yyaxis right
% x = 0 : 1000;
% y = 200+log(x);
% semilogx(x, y,'Color','k','LineStyle','-.')
% 
% hold on
% 
% yyaxis left
% semilogx([1  1e8],[13.7774  13.7774],'Color','k','LineStyle','-')
% semilogx(2*nNod_Q4_Ort_45(1,1:13),sigmaxx_Q4_Ort_45(1,1:13),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Ort_45(1,1:12),sigmaxx_Q8_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Ort_45(1,1:12),sigmaxx_Q9_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Ort_45(1,1:12),sigmaxx_Q12_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Ort_45(1,1:12),sigmaxx_Q16_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% text(14,14,'13.7774 MPa','Color','k','FontSize',14);
% ylabel('\sigma_{X} Máxima [MPa]','FontSize', 22)
% set(gca,'YTick',linspace(1,16,16))
% ylim([5 15])
% 
% yyaxis right
% semilogx(2*nNod_Q4_Ort_45(1,1:13),dispmaxx_Q4_Ort_45(1,1:13),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Ort_45(1,1:12),dispmaxx_Q8_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Ort_45(1,1:12),dispmaxx_Q9_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Ort_45(1,1:12),dispmaxx_Q12_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Ort_45(1,1:12),dispmaxx_Q16_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','m')
% semilogx([1 1e8],[0.002398 0.002398],'Color','k','LineStyle','-.')
% text(1e7,0.00245,'0.002398 mm','Color','k','FontSize',14);
% hold off
% 
% ylabel('Desplazamiento en X Máximo [mm]','FontSize',22)
% set(gca,'YTick',linspace(1.5e-3,3e-3,7))
% ylim([1.5e-3 2.75e-3])
% 
% grid on
% xlim([10 5e7])
% xlabel('Grados de Libertad','FontSize',22)
% legend({'Tendencia \sigma_{X}','\sigma_{X} Q4','\sigma_{X} Q8','\sigma_{X} Q9','\sigma_{X} Q12','\sigma_{X} Q16','Tendencia Desp X','Desp X Q4','Desp X Q8','Desp X Q9','Desp X Q12','Desp X Q16'},'FontSize',20,'Location','Best')
% 
% 
% % S_yy y Desp
% figure(2)
% set(figure(2),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% title('Evolución de Tensiones y Desplazamientos en Y','FontSize',20)
% 
% yyaxis right
% x = 0 : 1000;
% y = 200+log(x);
% semilogx(x, y,'Color','k','LineStyle','-.')
% 
% hold on
% yyaxis left
% semilogx([1 1e8],[3.6889 3.6889],'Color','k','LineStyle','-')
% semilogx(2*nNod_Q4_Ort_45(1,1:13),sigmaxy_Q4_Ort_45(1,1:13),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Ort_45(1,1:12),sigmaxy_Q8_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Ort_45(1,1:12),sigmaxy_Q9_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Ort_45(1,1:12),sigmaxy_Q12_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Ort_45(1,1:12),sigmaxy_Q16_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% text(14,3.75,'3.6889 MPa','Color','k','FontSize',14);
% ylabel('\sigma_{Y} Máxima [MPa]','FontSize', 22)
% set(gca,'YTick',linspace(1,4,4))
% ylim([1 4])
% 
% yyaxis right
% semilogx(2*nNod_Q4_Ort_45(1,1:13),dispmaxy_Q4_Ort_45(1,1:13),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Ort_45(1,1:12),dispmaxy_Q8_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Ort_45(1,1:12),dispmaxy_Q9_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Ort_45(1,1:12),dispmaxy_Q12_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Ort_45(1,1:12),dispmaxy_Q16_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','m')
% semilogx([1 1e8],[-0.003950 -0.003950],'Color','k','LineStyle','-.')
% text(1e7,-0.004,'-0.003950 mm','Color','k','FontSize',14);
% hold off
% 
% ylabel('Desplazamiento en Y Máximo [mm]','FontSize',22)
% set(gca,'YTick',linspace(-4.25e-3,-2.5e-3,8))
% ylim([-4.25e-3 -2.5e-3 ])
% 
% grid on
% xlim([10 5e7])
% xlabel('Grados de Libertad','FontSize',22)
% legend({'Tendencia \sigma_{Y}','\sigma_{Y} Q4','\sigma_{Y} Q8','\sigma_{Y} Q9','\sigma_{Y} Q12','\sigma_{Y} Q16','Tendencia Desp Y','Desp Y Q4','Desp Y Q8','Desp Y Q9','Desp Y Q12','Desp Y Q16'},'FontSize',20,'Location','Best')
% 

% Error Global por numero de Grados de Libertad
figure(4)
set(figure(4),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(2*nNod_Q4_Ort_45(1,1:12),errorG_1_Q4_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(2*nNod_Q8_Ort_45(1,1:12),errorG_1_Q8_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(2*nNod_Q9_Ort_45(1,1:12),errorG_1_Q9_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(2*nNod_Q12_Ort_45(1,1:12),errorG_1_Q12_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(2*nNod_Q16_Ort_45(1,1:12),errorG_1_Q16_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog(([1e1 1e-7]./Const_Q4_Hom_Ort).^(1/Pend_Q4_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','b')
loglog(([1e1 1e-7]./Const_Q8_Hom_Ort).^(1/Pend_Q8_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','r')
loglog(([1e1 1e-7]./Const_Q9_Hom_Ort).^(1/Pend_Q9_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','g')
loglog(([1e1 1e-7]./Const_Q12_Hom_Ort).^(1/Pend_Q12_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','c')
loglog(([1e1 1e-7]./Const_Q16_Hom_Ort).^(1/Pend_Q16_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','m')
loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Error Global','FontSize', 22)
ylim([5e-7 1])

grid on
xlim([10 5e7])
xlabel('Grados de Libertad','FontSize', 22)
title('Evolución del Error Global','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16','Tendencia Q4','Tendencia Q8','Tendencia Q9','Tendencia Q12','Tendencia Q16'},'FontSize',20,'Location','Best')
% 
% 
% % Error Global por Numero de Elementos
% figure(5)
% set(figure(5),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x,y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(nEle_Q4_Ort_45(1,1:12),errorG_1_Q4_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(nEle_Q8_Ort_45(1,1:12),errorG_1_Q8_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(nEle_Q9_Ort_45(1,1:12),errorG_1_Q9_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(nEle_Q12_Ort_45(1,1:12),errorG_1_Q12_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(nEle_Q16_Ort_45(1,1:12),errorG_1_Q16_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global','FontSize', 22)
% ylim([5e-7 1])
% 
% grid on
% xlim([10 5e6])
% xlabel('Número de Elementos','FontSize', 22)
% title('Evolución del Error Global','FontSize',20)
% legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


%% Graficos Isotropo
% 
% % S_xx y Desp
% figure(100)
% set(figure(100),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% title('Evolución de Tensiones y Desplazamientos en X','FontSize',20)
% 
% yyaxis right
% x = 0 : 1000;
% y = 200+log(x);
% semilogx(x,y,'Color','k','LineStyle','-.')
% 
% hold on
% yyaxis left
% semilogx([1  10e7],[13.12  13.12],'Color','k','LineStyle','-')
% semilogx(2*nNod_Q4_Iso_165(1,1:13),sigmaxx_Q4_Iso_165(1,1:13),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Iso_165(1,1:12),sigmaxx_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Iso_165(1,1:12),sigmaxx_Q9_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Iso_165(1,1:12),sigmaxx_Q12_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Iso_165(1,1:12),sigmaxx_Q16_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% text(14,13.5,'13.12 MPa','Color','k','FontSize',14);
% ylabel('\sigma_{X} Máxima [MPa]','FontSize', 22)
% set(gca,'YTick',linspace(5,16,12))
% ylim([5 16])
% 
% yyaxis right
% semilogx(2*nNod_Q4_Iso_165(1,1:13),dispmaxx_Q4_Iso_165(1,1:13),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Iso_165(1,1:12),dispmaxx_Q8_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Iso_165(1,1:12),dispmaxx_Q9_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Iso_165(1,1:12),dispmaxx_Q12_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Iso_165(1,1:12),dispmaxx_Q16_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','m')
% text(1e7,0.00265,'0.002604 mm','Color','k','FontSize',14);
% semilogx([1 10e7],[0.002604 0.002604],'Color','k','LineStyle','-.')
% hold off
% 
% ylabel('Desplazamiento en X Máximo [mm]','FontSize',22)
% set(gca,'YTick',linspace(1.25e-3,2.75e-3,7))
% ylim([1.25e-3 2.75e-3])
% 
% grid on
% xlim([10 5e7])
% xlabel('Grados de Libertad','FontSize',22)
% legend({'ADINA \sigma_{X}' '\sigma_{X} Q4','\sigma_{X} Q8','\sigma_{X} Q9','\sigma_{X} Q12','\sigma_{X} Q16','ADINA Desp X','Desp X Q4','Desp X Q8','Desp X Q9','Desp X Q12','Desp X Q16'},'FontSize',20,'Location','Best')
% 
% 
% % S_yy y Desp
% figure(102)
% set(figure(102),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% title('Evolución de Tensiones y Desplazamientos en Y','FontSize',20)
% 
% yyaxis right
% x = 0 : 1000;
% y = 100+log(x);
% semilogx(x,y,'Color','k','LineStyle','-.')
% 
% hold on
% yyaxis left
% semilogx([1  1e8],[3.799  3.799],'Color','k','LineStyle','-')
% semilogx(2*nNod_Q4_Iso_165(1,1:13),sigmaxy_Q4_Iso_165(1,1:13),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Iso_165(1,1:12),sigmaxy_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Iso_165(1,1:12),sigmaxy_Q9_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Iso_165(1,1:12),sigmaxy_Q12_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Iso_165(1,1:12),sigmaxy_Q16_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% text(14,3.85,'3.799 MPa','Color','k','FontSize',14);
% ylabel('\sigma_{Y} Máxima [MPa]','FontSize', 22)
% set(gca,'YTick',linspace(1,4,4))
% ylim([1 4])
% 
% yyaxis right
% semilogx(2*nNod_Q4_Iso_165(1,1:13),dispmaxy_Q4_Iso_165(1,1:13),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','b')
% semilogx(2*nNod_Q8_Iso_165(1,1:12),dispmaxy_Q8_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','r')
% semilogx(2*nNod_Q9_Iso_165(1,1:12),dispmaxy_Q9_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','g')
% semilogx(2*nNod_Q12_Iso_165(1,1:12),dispmaxy_Q12_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','c')
% semilogx(2*nNod_Q16_Iso_165(1,1:12),dispmaxy_Q16_Iso_165(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','m')
% text(1e7,-0.0044,'-0.00436 mm','Color','k','FontSize',14);
% semilogx([1 1e8],[-0.004363 -0.004363],'Color','k','LineStyle','-.')
% hold off
% 
% ylabel('Desplazamiento en Y Máximo [mm]','FontSize',22)
% set(gca,'YTick',linspace(-4.5e-3,-3e-3,7))
% ylim([-4.5e-3 -3e-3])
% 
% grid on
% xlim([10 5e7])
% xlabel('Grados de Libertad','FontSize',22)
% legend({'ADINA \sigma_{Y}','\sigma_{Y} Q4','\sigma_{Y} Q8','\sigma_{Y} Q9','\sigma_{Y} Q12','\sigma_{Y} Q16','ADINA Desp Y','Desp Y Q4','Desp Y Q8','Desp Y Q9','Desp Y Q12','Desp Y Q16'},'FontSize',20,'Location','Best')
% 

% Error Global por numero de Grados de Libertad
figure(104)
set(figure(104),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(2*nNod_Q4_Iso_165(1,1:12),errorG_1_Q4_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(2*nNod_Q8_Iso_165(1,1:12),errorG_1_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(2*nNod_Q9_Iso_165(1,1:12),errorG_1_Q9_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(2*nNod_Q12_Iso_165(1,1:12),errorG_1_Q12_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(2*nNod_Q16_Iso_165(1,1:12),errorG_1_Q16_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog(([1e1 1e-7]./Const_Q4_Hom_Iso).^(1/Pend_Q4_Hom_Iso),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','b')
loglog(([1e1 1e-7]./Const_Q8_Hom_Iso).^(1/Pend_Q8_Hom_Iso),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','r')
loglog(([1e1 1e-7]./Const_Q9_Hom_Iso).^(1/Pend_Q9_Hom_Iso),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','g')
loglog(([1e1 1e-7]./Const_Q12_Hom_Iso).^(1/Pend_Q12_Hom_Iso),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','c')
loglog(([1e1 1e-7]./Const_Q16_Hom_Iso).^(1/Pend_Q16_Hom_Iso),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','m')
loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Error Global','FontSize', 22)
ylim([5e-7 1])

grid on
xlim([10 5e7])
xlabel('Grados de Libertad','FontSize', 22)
title('Evolución del Error Global','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16','Tendencia Q4','Tendencia Q8','Tendencia Q9','Tendencia Q12','Tendencia Q16'},'FontSize',20,'Location','Best')
% 
% 
% % Error Global por Numero de Elementos
% figure(105)
% set(figure(105),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% % set(gca,'fontsize',20)
% 
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x,y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(nEle_Q4_Iso_165(1,1:12),errorG_1_Q4_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(nEle_Q8_Iso_165(1,1:12),errorG_1_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(nEle_Q9_Iso_165(1,1:12),errorG_1_Q9_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(nEle_Q12_Iso_165(1,1:12),errorG_1_Q12_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(nEle_Q16_Iso_165(1,1:12),errorG_1_Q16_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global','FontSize', 22)
% ylim([5e-7 1])
% 
% grid on
% xlim([5 5e6])
% xlabel('Número de Elementos','FontSize', 22)
% title('Evolución del Error Global','FontSize',20)
% legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


%% Comparacion Mallas Isotropo

% Error Global por numero de Grados de Libertad
% figure(200)
% set(figure(200),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x, y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(2*nNod_Q8_Iso_165(1,1:12),errorG_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(2*nNod_Q8_r2_Iso_165(1,13:21),errorG_Q8_r2_Iso_165(1,13:21),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1 0.2 0.4])
% loglog(2*nNod_Q8_r2_Iso_165(1,22:31),errorG_Q8_r2_Iso_165(1,22:31),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4 0.2 0.1])
% loglog(2*nNod_Q8_r2_Iso_165(1,32:41),errorG_Q8_r2_Iso_165(1,32:41),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(2*nNod_Q8_r2_Iso_165(1,42:43),errorG_Q8_r2_Iso_165(1,42:43),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(2*nNod_Q8_r2_Iso_165(1,52:61),errorG_Q8_r2_Iso_165(1,52:61),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(2*nNod_Q8_r2_Iso_165(1,62:71),errorG_Q8_r2_Iso_165(1,62:71),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog(2*nNod_Q8_r2_Iso_165(1,72:81),errorG_Q8_r2_Iso_165(1,72:81),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','y')
% loglog(2*nNod_Q8_r2_Iso_165(1,82:91),errorG_Q8_r2_Iso_165(1,82:91),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4660 0.6740 0.1880])
% loglog(2*nNod_Q8_r2_Iso_165(1,92:101),errorG_Q8_r2_Iso_165(1,92:101),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.8500,0.3250,0.0980])
% loglog(2*nNod_Q8_r2_Iso_165(1,102:111),errorG_Q8_r2_Iso_165(1,102:111),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4940 0.1840 0.5560])
% loglog(2*nNod_Q8_r2_Iso_165(1,112:121),errorG_Q8_r2_Iso_165(1,112:121),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6350 0.0780 0.1840])
% loglog(2*nNod_Q8_r2_Iso_165(1,122:131),errorG_Q8_r2_Iso_165(1,122:131),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.3010 0.7450 0.9330])
% loglog(2*nNod_Q8_r2_Iso_165(1,132:141),errorG_Q8_r2_Iso_165(1,132:141),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.9290 0.6940 0.1250])
% loglog(2*nNod_Q8_r2_Iso_165(1,142:151),errorG_Q8_r2_Iso_165(1,142:151),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.9290 0.1250])
% loglog(2*nNod_Q8_r2_Iso_165(1,152:161),errorG_Q8_r2_Iso_165(1,152:161),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1250 0.6940 0.5])
% loglog([1 1e7],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global [%]','FontSize',22)
% ylim([5e-6 1])
% 
% grid on
% xlim([5 5e6])
% xlabel('Número de Grados de Libertad','FontSize',22)
% legend({'Error Objetivo','Homogeneo','Malla 1','Malla 2','Malla 3','Malla 4','Malla 5','Malla 6','Malla 7','Malla 8','Malla 9','Malla 10','Malla 11','Malla 12','Malla 13','Malla 14','Malla 15'},'FontSize',20,'Location','Best')


% Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
% figure(201)
% set(figure(201),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x, y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(2*nNod_Q8_Iso_165(1,1:12),errorG_1_Q8_Iso_165(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(2*nNod_Q8_r2_Iso_165(1,13:21),errorG_1_Q8_r2_Iso_165(1,13:21),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1 0.2 0.4])
% loglog(2*nNod_Q8_r2_Iso_165(1,22:31),errorG_1_Q8_r2_Iso_165(1,22:31),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4 0.2 0.1])
% loglog(2*nNod_Q8_r2_Iso_165(1,32:41),errorG_1_Q8_r2_Iso_165(1,32:41),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(2*nNod_Q8_r2_Iso_165(1,42:43),errorG_1_Q8_r2_Iso_165(1,42:43),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(2*nNod_Q8_r2_Iso_165(1,52:61),errorG_1_Q8_r2_Iso_165(1,52:61),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(2*nNod_Q8_r2_Iso_165(1,62:71),errorG_1_Q8_r2_Iso_165(1,62:71),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog(2*nNod_Q8_r2_Iso_165(1,72:81),errorG_1_Q8_r2_Iso_165(1,72:81),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','y')
% loglog(2*nNod_Q8_r2_Iso_165(1,82:91),errorG_1_Q8_r2_Iso_165(1,82:91),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4660 0.6740 0.1880])
% loglog(2*nNod_Q8_r2_Iso_165(1,92:101),errorG_1_Q8_r2_Iso_165(1,92:101),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.8500,0.3250,0.0980])
% loglog(2*nNod_Q8_r2_Iso_165(1,102:111),errorG_1_Q8_r2_Iso_165(1,102:111),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4940 0.1840 0.5560])
% loglog(2*nNod_Q8_r2_Iso_165(1,112:121),errorG_1_Q8_r2_Iso_165(1,112:121),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6350 0.0780 0.1840])
% loglog(2*nNod_Q8_r2_Iso_165(1,122:131),errorG_1_Q8_r2_Iso_165(1,122:131),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.3010 0.7450 0.9330])
% loglog(2*nNod_Q8_r2_Iso_165(1,132:141),errorG_1_Q8_r2_Iso_165(1,132:141),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.9290 0.6940 0.1250])
% loglog(2*nNod_Q8_r2_Iso_165(1,142:151),errorG_1_Q8_r2_Iso_165(1,142:151),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.9290 0.1250])
% loglog(2*nNod_Q8_r2_Iso_165(1,152:161),errorG_1_Q8_r2_Iso_165(1,152:161),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1250 0.6940 0.5])
% loglog(2*nNod_Q8_r2_Iso_165(1,162:171),errorG_1_Q8_r2_Iso_165(1,162:171),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.1250 0.5])
% loglog(2*nNod_Q8_r2_Iso_165(1,172:181),errorG_1_Q8_r2_Iso_165(1,172:181),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.5 0.1250])
% loglog([1 1e7],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global [%]','FontSize', 22)
% ylim([5e-6 1])
% 
% grid on
% xlim([5 5e6])
% xlabel('Número de Grados de Libertad','FontSize', 22)
% legend({'Error Objetivo','Homogeneo','Malla 1','Malla 2','Malla 3','Malla 4','Malla 5','Malla 6','Malla 7','Malla 8','Malla 9','Malla 10','Malla 11','Malla 12','Malla 13','Malla 14','Malla 15'},'FontSize',20,'Location','Best')


%% Comparacion Mallas Orotropo

% Error Global por numero de Grados de Libertad
% figure(300)
% set(figure(300),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x, y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(2*nNod_Q8_Ort_45(1,1:12),errorG_Q8_Ort_45(1,1:12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(2*nNod_Q8_r2_Ort_45(1,13:21),errorG_Q8_r2_Ort_45(1,13:21),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1 0.2 0.4])
% loglog(2*nNod_Q8_r2_Ort_45(1,22:31),errorG_Q8_r2_Ort_45(1,22:31),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4 0.2 0.1])
% loglog(2*nNod_Q8_r2_Ort_45(1,32:41),errorG_Q8_r2_Ort_45(1,32:41),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(2*nNod_Q8_r2_Ort_45(1,42:43),errorG_Q8_r2_Ort_45(1,42:43),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(2*nNod_Q8_r2_Ort_45(1,52:61),errorG_Q8_r2_Ort_45(1,52:61),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(2*nNod_Q8_r2_Ort_45(1,62:71),errorG_Q8_r2_Ort_45(1,62:71),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog(2*nNod_Q8_r2_Ort_45(1,72:81),errorG_Q8_r2_Ort_45(1,72:81),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','y')
% loglog(2*nNod_Q8_r2_Ort_45(1,82:91),errorG_Q8_r2_Ort_45(1,82:91),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4660 0.6740 0.1880])
% loglog(2*nNod_Q8_r2_Ort_45(1,92:101),errorG_Q8_r2_Ort_45(1,92:101),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.8500,0.3250,0.0980])
% loglog(2*nNod_Q8_r2_Ort_45(1,102:111),errorG_Q8_r2_Ort_45(1,102:111),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4940 0.1840 0.5560])
% loglog(2*nNod_Q8_r2_Ort_45(1,112:121),errorG_Q8_r2_Ort_45(1,112:121),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6350 0.0780 0.1840])
% loglog(2*nNod_Q8_r2_Ort_45(1,122:131),errorG_Q8_r2_Ort_45(1,122:131),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.3010 0.7450 0.9330])
% loglog(2*nNod_Q8_r2_Ort_45(1,132:141),errorG_Q8_r2_Ort_45(1,132:141),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.9290 0.6940 0.1250])
% loglog(2*nNod_Q8_r2_Ort_45(1,142:151),errorG_Q8_r2_Ort_45(1,142:151),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.9290 0.1250])
% loglog(2*nNod_Q8_r2_Ort_45(1,152:161),errorG_Q8_r2_Ort_45(1,152:161),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1250 0.6940 0.5])
% loglog([1 1e7],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global','FontSize',22)
% ylim([5e-6 1])
% 
% grid on
% xlim([5 5e6])
% xlabel('Número de Grados de Libertad','FontSize',22)
% legend({'Error Objetivo','Homogeneo','Malla 1','Malla 2','Malla 3','Malla 4','Malla 5','Malla 6','Malla 7','Malla 8','Malla 9','Malla 10','Malla 11','Malla 12','Malla 13','Malla 14','Malla 15'},'FontSize',20,'Location','Best')


% Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
% figure(301)
% set(figure(301),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x, y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(2*nNod_Q8_Ort_45(1,1:13),errorG_1_Q8_Ort_45(1,1:13),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(2*nNod_Q8_r2_Ort_45(1,12:21),errorG_1_Q8_r2_Ort_45(1,12:21),'LineStyle','-','LineWidth',2,'Marker','d','MarkerSize',14,'Color',[0.1 0.2 0.4])
% loglog(2*nNod_Q8_r2_Ort_45(1,22:31),errorG_1_Q8_r2_Ort_45(1,22:31),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4 0.2 0.1])
% loglog(2*nNod_Q8_r2_Ort_45(1,32:41),errorG_1_Q8_r2_Ort_45(1,32:41),'LineStyle','-','LineWidth',2,'Marker','d','MarkerSize',14,'Color','r')
% loglog(2*nNod_Q8_r2_Ort_45(1,42:43),errorG_1_Q8_r2_Ort_45(1,42:43),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(2*nNod_Q8_r2_Ort_45(1,52:61),errorG_1_Q8_r2_Ort_45(1,52:61),'LineStyle','-','LineWidth',2,'Marker','d','MarkerSize',14,'Color','c')    % Malla 5
% loglog(2*nNod_Q8_r2_Ort_45(1,62:71),errorG_1_Q8_r2_Ort_45(1,62:71),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog(2*nNod_Q8_r2_Ort_45(1,72:81),errorG_1_Q8_r2_Ort_45(1,72:81),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','y')
% loglog(2*nNod_Q8_r2_Ort_45(1,82:91),errorG_1_Q8_r2_Ort_45(1,82:91),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.4660 0.6740 0.1880])
% loglog(2*nNod_Q8_r2_Ort_45(1,92:101),errorG_1_Q8_r2_Ort_45(1,92:101),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.8500,0.3250,0.0980])
% loglog(2*nNod_Q8_r2_Ort_45(1,102:111),errorG_1_Q8_r2_Ort_45(1,102:111),'LineStyle','-','LineWidth',2,'Marker','d','MarkerSize',14,'Color',[0.4940 0.1840 0.5560]) %Malla 10
% loglog(2*nNod_Q8_r2_Ort_45(1,112:121),errorG_1_Q8_r2_Ort_45(1,112:121),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6350 0.0780 0.1840])
% loglog(2*nNod_Q8_r2_Ort_45(1,122:131),errorG_1_Q8_r2_Ort_45(1,122:131),'LineStyle','-','LineWidth',2,'Marker','s','MarkerSize',14,'Color',[0.3010 0.7450 0.9330])
% loglog(2*nNod_Q8_r2_Ort_45(1,132:141),errorG_1_Q8_r2_Ort_45(1,132:141),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.9290 0.6940 0.1250])
% loglog(2*nNod_Q8_r2_Ort_45(1,142:151),errorG_1_Q8_r2_Ort_45(1,142:151),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.9290 0.1250])
% loglog(2*nNod_Q8_r2_Ort_45(1,152:161),errorG_1_Q8_r2_Ort_45(1,152:161),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.1250 0.6940 0.5])    % Malla 15
% loglog(2*nNod_Q8_r2_Ort_45(1,162:171),errorG_1_Q8_r2_Ort_45(1,162:171),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.5 0.1250])
% loglog(2*nNod_Q8_r2_Ort_45(1,172:181),errorG_1_Q8_r2_Ort_45(1,172:181),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color',[0.6940 0.1250 0.5])
% loglog(2*nNod_Q8_r2_Ort_45(1,182:191),errorG_1_Q8_r2_Ort_45(1,182:191),'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',14,'Color',[0.9 0.3 0.1])
% loglog(2*nNod_Q8_r2_Ort_45(1,192:201),errorG_1_Q8_r2_Ort_45(1,192:201),'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',14,'Color',[0.3 0.9 0.1])
% loglog(2*nNod_Q8_r2_Ort_45(1,212:221),errorG_1_Q8_r2_Ort_45(1,212:221),'LineStyle','-','LineWidth',2,'Marker','p','MarkerSize',14,'Color',[0.1 0.3 0.9])
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global','FontSize', 22)
% ylim([5e-6 1])
% 
% grid on
% xlim([5e1 1e7])
% xlabel('Número de Grados de Libertad','FontSize', 22)
% legend({'Error Objetivo','Homogeneo','Malla 1','Malla 2','Malla 3','Malla 4','Malla 5','Malla 6','Malla 7','Malla 8','Malla 9','Malla 10','Malla 11','Malla 12','Malla 13','Malla 14','Malla 15','Malla 16','Malla 17','Malla 18','Malla 19','Malla 21'},'FontSize',20,'Location','Best')


%% Final

% % Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
% figure(400)
% set(figure(400),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)
% 
% t = 0 : 2*pi/360 : 2*pi; 
% x = exp(t);
% y = 50 + exp(3*t); 
% loglog(x, y,'LineStyle','-.','LineWidth',1)
% 
% hold on
% loglog(nEle_Q4_Ort_45(1,1:12),errorG_1_Q4_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(nEle_Q8_Ort_45(1,1:12),errorG_1_Q8_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(nEle_Q9_Ort_45(1,1:12),errorG_1_Q9_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(nEle_Q12_Ort_45(1,1:12),errorG_1_Q12_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(nEle_Q16_Ort_45(1,1:12),errorG_1_Q16_Ort_45(1,1:12),'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog(nEle_Q4_r2_Ort_45(1,402:411),errorG_1_Q4_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% loglog(nEle_Q8_r2_Ort_45(1,402:411),errorG_1_Q8_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% loglog(nEle_Q9_r2_Ort_45(1,402:411),errorG_1_Q9_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
% loglog(nEle_Q12_r2_Ort_45(1,402:411),errorG_1_Q12_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
% loglog(nEle_Q16_r2_Ort_45(1,402:411),errorG_1_Q16_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e9],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% ylabel('Error Global','FontSize', 22)
% ylim([5e-6 1])
% 
% grid on
% xlim([5e0 1e7])
% xlabel('Número de Elementos','FontSize', 22)
% legend({'Error Objetivo','Homogeneo Q4','Homogeneo Q8','Homogeneo Q9','Homogeneo Q12','Homogeneo Q16','Malla Refinada Q4','Malla Refinada Q8','Malla Refinada Q9','Malla Refinada Q12','Malla Refinada Q16'},'FontSize',20,'Location','Best')







% Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
figure(401)
% set(figure(401),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x, y,'LineStyle','-.','LineWidth',1,'Color','k')

hold on
loglog(2*nNod_Q4_Ort_45(1,1:12),errorG_1_Q4_Ort_45(1,1:12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','b')
loglog(2*nNod_Q8_Ort_45(1,1:12),errorG_1_Q8_Ort_45(1,1:12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','r')
loglog(2*nNod_Q9_Ort_45(1,1:12),errorG_1_Q9_Ort_45(1,1:12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','g')
loglog(2*nNod_Q12_Ort_45(1,1:12),errorG_1_Q12_Ort_45(1,1:12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','c')
loglog(2*nNod_Q16_Ort_45(1,1:12),errorG_1_Q16_Ort_45(1,1:12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','m')
loglog(2*nNod_Q4_r2_Ort_45(1,402:411),errorG_1_Q4_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(2*nNod_Q8_r2_Ort_45(1,402:411),errorG_1_Q8_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(2*nNod_Q9_r2_Ort_45(1,402:411),errorG_1_Q9_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(2*nNod_Q12_r2_Ort_45(1,402:411),errorG_1_Q12_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(2*nNod_Q16_r2_Ort_45(1,402:411),errorG_1_Q16_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([1 1e9],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Error Global','FontSize', 22)
ylim([5e-7 1])

grid on
xlim([1e1 1e7])
xlabel('Número de Grados de Libertad','FontSize', 22)
title('Evolución del Error Global','FontSize',20)
legend({'Error Objetivo','Homogenea Q4','Homogenea Q8','Homogenea Q9','Homogenea Q12','Homogenea Q16','Mejorada Q4','Mejorada Q8','Mejorada Q9','Mejorada Q12','Mejorada Q16'},'FontSize',20,'Location','Best')


% Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
figure(402)
% set(figure(402),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x, y,'LineStyle','-.','LineWidth',1,'Color','k')

hold on
loglog(2*nNod_Q4_r2_Ort_45(1,402:411),errorG_1_Q4_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(2*nNod_Q8_r2_Ort_45(1,402:411),errorG_1_Q8_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(2*nNod_Q9_r2_Ort_45(1,402:411),errorG_1_Q9_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(2*nNod_Q12_r2_Ort_45(1,402:411),errorG_1_Q12_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(2*nNod_Q16_r2_Ort_45(1,402:411),errorG_1_Q16_r2_Ort_45(1,402:411),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog(([1e1 1e-7]./Const_Q4_Mej_Ort).^(1/Pend_Q4_Mej_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','b')
loglog(([1e1 1e-7]./Const_Q8_Mej_Ort).^(1/Pend_Q8_Mej_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','r')
loglog(([1e1 1e-7]./Const_Q9_Mej_Ort).^(1/Pend_Q9_Mej_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','g')
loglog(([1e1 1e-7]./Const_Q12_Mej_Ort).^(1/Pend_Q12_Mej_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','c')
loglog(([1e1 1e-7]./Const_Q16_Mej_Ort).^(1/Pend_Q16_Mej_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','m')
loglog([1 1e9],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Error Global','FontSize', 22)
ylim([5e-7 1])

grid on
xlim([1e1 1e7])
xlabel('Número de Grados de Libertad','FontSize', 22)
title('Evolución del Error Global','FontSize',20)
legend({'Error Objetivo','Mejorada Q4','Mejorada Q8','Mejorada Q9','Mejorada Q12','Mejorada Q16','Tendencia Q4','Tendencia Q8','Tendencia Q9','Tendencia Q12','Tendencia Q16'},'FontSize',20,'Location','Best')


% Error Global (con U2_el < 1% del Promedio) por numero de Grados de Libertad
figure(403)
% set(figure(402),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x, y,'LineStyle','-.','LineWidth',1,'Color','k')

hold on

loglog(([1e1 1e-7]./Const_Q4_Mej_Ort).^(1/Pend_Q4_Mej_Ort),[1e1 1e-7],'LineStyle','-','LineWidth',1,'Color','b')
loglog(([1e1 1e-7]./Const_Q8_Mej_Ort).^(1/Pend_Q8_Mej_Ort),[1e1 1e-7],'LineStyle','-','LineWidth',1,'Color','r')
loglog(([1e1 1e-7]./Const_Q9_Mej_Ort).^(1/Pend_Q9_Mej_Ort),[1e1 1e-7],'LineStyle','-','LineWidth',1,'Color','g')
loglog(([1e1 1e-7]./Const_Q12_Mej_Ort).^(1/Pend_Q12_Mej_Ort),[1e1 1e-7],'LineStyle','-','LineWidth',1,'Color','c')
loglog(([1e1 1e-7]./Const_Q16_Mej_Ort).^(1/Pend_Q16_Mej_Ort),[1e1 1e-7],'LineStyle','-','LineWidth',1,'Color','m')
loglog(([1e1 1e-7]./Const_Q4_Hom_Ort).^(1/Pend_Q4_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','b')
loglog(([1e1 1e-7]./Const_Q8_Hom_Ort).^(1/Pend_Q8_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','r')
loglog(([1e1 1e-7]./Const_Q9_Hom_Ort).^(1/Pend_Q9_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','g')
loglog(([1e1 1e-7]./Const_Q12_Hom_Ort).^(1/Pend_Q12_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','c')
loglog(([1e1 1e-7]./Const_Q16_Hom_Ort).^(1/Pend_Q16_Hom_Ort),[1e1 1e-7],'LineStyle','-.','LineWidth',1,'Color','m')
loglog([1 1e9],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Error Global','FontSize', 22)
ylim([5e-7 1])

grid on
xlim([1e1 1e7])
xlabel('Número de Grados de Libertad','FontSize', 22)
title('Evolución del Error Global','FontSize',20)
legend({'Error Objetivo','Mejorada Q4','Mejorada Q8','Mejorada Q9','Mejorada Q12','Mejorada Q16','Homogenea Q4','Homogenea Q8','Homogenea Q9','Homogenea Q12','Homogenea Q16'},'FontSize',20,'Location','Best')


% 
% % Alpha Ortotropo vs E Isotropo: Tension Maxima de Von Mises
% figure(411)
% set(figure(411),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% 
% hold on
% plot(alpha_Q8_400_r2_Orthotropic_150_180_75(1,1:19),sigmavm_Q8_400_r2_Orthotropic_150_180_75(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% plot(alpha_Q8_400_r2_Orthotropic_500_50_75(1,1:19),sigmavm_Q8_400_r2_Orthotropic_500_50_75(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
% plot([-10 200],[sigmavm_Q8_400_r2_Isotropic(1,1) sigmavm_Q8_400_r2_Isotropic(1,1)],'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','k')
% hold off
% 
% grid on
% % ylim([ ])
% ylabel('\sigma_{VM} [MPa]','FontSize', 22)
% xlim([0 180])
% xlabel('\theta [Grados]','FontSize', 22)
% legend({'E1=150GPa E2=180GPa','E1=500GPa E2=50GPa','Isotropo'},'FontSize',20,'Location','Best')
% 
% 
% % Alpha Ortotropo vs E Isotropo: Desplazamiento Maximo Y
% figure(412)
% set(figure(412),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% 
% hold on
% plot(alpha_Q8_400_r2_Orthotropic_150_180_75(1,1:19),dispmaxy_Q8_400_r2_Orthotropic_150_180_75(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% for i_Punto=13:21
%     plot([-10 200],[dispmaxy_Q8_400_r2_Isotropic(1,i_Punto) dispmaxy_Q8_400_r2_Isotropic(1,i_Punto)],'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','k')
%     text(5,dispmaxy_Q8_400_r2_Isotropic(1,i_Punto)+0.05,num2str(i_Punto*10),'Color','k','FontSize',14)
% end
% hold off
% 
% grid on
% % ylim([ ])
% ylabel('Desplazamiento Máximo en Y [mm]','FontSize', 22)
% xlim([0 180])
% xlabel('\theta [Grados]','FontSize', 22)
% legend({'E1=150GPa E2=180GPa'},'FontSize',20,'Location','Best')
% 
% 
% % Alpha Ortotropo vs E Isotropo: Desplazamiento Maximo X
% figure(423)
% set(figure(423),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% 
% hold on
% plot(alpha_Q8_400_r2_Orthotropic_150_180_75(1,1:19),dispmaxx_Q8_400_r2_Orthotropic_150_180_75(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% for i_Punto=12:23
%     plot([-10 200],[dispmaxx_Q8_400_r2_Isotropic(1,i_Punto) dispmaxx_Q8_400_r2_Isotropic(1,i_Punto)],'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','k')
%     text(5,1.01*dispmaxx_Q8_400_r2_Isotropic(1,i_Punto),num2str(i_Punto*10),'Color','k','FontSize',14)
% end
% hold off
% 
% grid on
% % ylim([0.004 0.045])
% ylabel('Desplazamiento Máximo en X [mm]','FontSize', 22)
% xlim([0 180])
% xlabel('\theta [Grados]','FontSize', 22)
% legend({'E1=150GPa E2=180GPa'},'FontSize',20,'Location','Best')



% Alpha Ortotropo vs E Isotropo: Desplazamiento Maximo X
figure(434)
set(figure(434),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])

hold on
plot(alpha_Q16_404_r2_Orthotropic_10_10_5(1,1:19),dispmaxx_Q16_404_r2_Orthotropic_10_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','[0.9290 0.6940 0.1250]')
plot(alpha_Q16_404_r2_Orthotropic_25_10_5(1,1:19),dispmaxx_Q16_404_r2_Orthotropic_25_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
plot(alpha_Q8_400_r2_Orthotropic_50_10_5(1,1:19),dispmaxx_Q8_400_r2_Orthotropic_50_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
plot(alpha_Q8_400_r2_Orthotropic_100_10_5(1,1:19),dispmaxx_Q8_400_r2_Orthotropic_100_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
plot(alpha_Q8_400_r2_Orthotropic_150_10_5(1,1:19),dispmaxx_Q8_400_r2_Orthotropic_150_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
plot(alpha_Q16_404_r2_Orthotropic_200_10_5(1,1:19),dispmaxx_Q16_404_r2_Orthotropic_200_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
plot(alpha_Q16_404_r2_Orthotropic_400_10_5(1,1:19),dispmaxx_Q16_404_r2_Orthotropic_400_10_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','y')
for i_Punto=1:10
    plot([-10 200],[dispmaxx_Q8_400_r2_Isotropic(1,i_Punto) dispmaxx_Q8_400_r2_Isotropic(1,i_Punto)],'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','k')
    text(5,1.05*dispmaxx_Q8_400_r2_Isotropic(1,i_Punto),strcat(num2str(i_Punto*10),' GPa'),'Color','k','FontSize',14)
end
hold off

grid on
ylim([0.0035 0.05])
ylabel('Desplazamiento Máximo en X [mm]','FontSize', 22)
xlim([0 180])
xlabel('\theta [Grados]','FontSize', 22)
legend({'E1=10GPa','E1=25GPa','E1=50GPa','E1=100GPa','E1=150GPa','E1=200GPa','E1=400GPa'},'FontSize',20,'Location','Best')




%% SURF

% Alpha Ortotropo vs E Isotropo: Surf
figure(500)
% set(figure(450),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
surf(0:5:90,1:0.5:10,dispmaxx_Q16_404_r2_Orthotropic_10_5(1:19,:))
ylim([1 10])
xlim([0 90])
xlabel('\theta [Grados]','FontSize', 22)
ylabel('Relación E1/E2','FontSize', 22)
zlabel('Desplazamiento Máximo en X [mm]','FontSize', 22)


% % Alpha Ortotropo vs E Isotropo: Surf
% figure(501)
% % set(figure(450),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% surf(0:5:90,1:0.5:10,dispmaxy_Q16_404_r2_Orthotropic_10_5(1:19,:))
% % ylim([1 10])
% xlim([0 90])
% xlabel('\theta [Grados]','FontSize', 22)
% ylabel('Relación E1/E2','FontSize', 22)
% zlabel('Desplazamiento Máximo en Y [mm]','FontSize', 22)
% 
% 
% % Alpha Ortotropo vs E Isotropo: Surf
% figure(502)
% % set(figure(450),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% surf(0:5:90,1:0.5:10,sigmavm_Q16_404_r2_Orthotropic_10_5(1:19,:))
% % ylim([1 10])
% xlim([0 90])
% xlabel('\theta [Grados]','FontSize', 22)
% ylabel('Relación E1/E2','FontSize', 22)
% zlabel('\sigma_{VM} Máxima [MPa]','FontSize', 22)


%% DESPLAZAMIENTO PUNTO MAXIMO

% % Alpha Ortotropo vs E Isotropo: Desplazamiento del punto de Tension Maximo
% figure(600)
% set(figure(600),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% hold on
% graph_meshplot(Elements,Nodes,'k')
% plot(xvmmax_Q8_400_r2_Orthotropic_150_180_75(1,1:10),yvmmax_Q8_400_r2_Orthotropic_150_180_75(1,1:10),'LineStyle','-','LineWidth',2,'Marker','o','MarkerSize',10,'Color','r')
% for i_Punto = 1:10
%     if i_Punto == 10 || i_Punto == 9 || i_Punto == 12
%         text(xvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto),yvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto)+0.05,num2str((i_Punto-1)*10),'Color','k','FontSize',14);
%     elseif i_Punto == 19
%         text(xvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto),yvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto)+0.08,num2str((i_Punto-1)*10),'Color','k','FontSize',14);
%     else
%         text(xvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto),yvmmax_Q8_400_r2_Orthotropic_150_180_75(1,i_Punto)+0.02,num2str((i_Punto-1)*10),'Color','k','FontSize',14);
%     end 
% end
% hold off
% 
% grid on
% ylim([14.75 15.25])
% xlim([48.75 51.25])
% % legend({},'FontSize',20,'Location','Best')


%%

% % Alpha Ortotropo vs E Isotropo: Tension Maxima de Von Mises
% figure(700)
% set(figure(700),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
% 
% hold on
% plot(alpha_Q16_404_r2_Orthotropic_22_11_5(1,1:19),sigmavm_Q16_404_r2_Orthotropic_22_11_5(1,1:19),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
% for i_Punto=1:1
%     plot([-10 200],[sigmavm_Q8_400_r2_Isotropic(1,i_Punto) sigmavm_Q8_400_r2_Isotropic(1,i_Punto)],'LineStyle','-.','LineWidth',2,'Marker','*','MarkerSize',14,'Color','k')
% %     text(5,1.01*sigmavm_Q8_400_r2_Isotropic(1,i_Punto),num2str(i_Punto*10),'Color','k','FontSize',14)
% end
% hold off
% 
% grid on
% % ylim([ ])
% ylabel('\sigma_{VM} [MPa]','FontSize', 22)
% xlim([0 180])
% xlabel('\theta [Grados]','FontSize', 22)
% legend({'E1=22GPa E2=11GPa G12=5GPa v12=0','Isotropo'},'FontSize',20,'Location','Best')

