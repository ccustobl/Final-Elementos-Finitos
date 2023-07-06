clear 
close all
clc
format short
tic


%% Starting Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Starting Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')


%% Alpha Parameters Selection

E2 = 10e3;     %MPa
% E3 = 200e3;     %MPa
G12 = 5e3;     %MPa
v12 = 0.3;


%% Parameters

Case = 'Final';  %% 'Final' ; 'Plate' ; 'PatchTest.X' ; 'PatchTest.Y' ; 'PatchTest.XY'
Ele_Type = 'Q16';  %Element Type%
Borders = 'Straight';  %% 'Straight' ; 'Curved'
TXT_Number = '404';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Orthotropic';  %% 'Orthotropic' ; 'Isotropic'
DAF = 5000;  %Displacement Amplifying Factor%
Simetric = 'No';  %% 'Yes' ; 'No'
Loads = 'Normal';  %% 'Normal ; 'Beam'
if strcmp(Material(1:5),'Ortho')==1
    Simetric = 'No';
end

%% Mesh Selection
[Nodes,Elements] = select_mesh(Ele_Type,Case,Simetric,TXT_Number,Ref_R,Ref_R_Number,Borders);

%% Parameters
[nDofNod,nNodEle,nEle,nNod,nDofTot,t,NodeDofs,EleDofs,uGP1,nGP1,wGP1,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uBP9,nBP9,wBP9,uGP16,nGP16,wGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16] = select_parameters(Ele_Type,Elements,Nodes);

%% Display    
print_data_start(Case,Ref_R,Ref_R_Number,TXT_Number,Ele_Type,nNod,nEle,Borders,Material);

%% Boundary Conditions
bc = select_boundary_conditions(Simetric,Ele_Type,Case,Loads,Nodes,nNod,nDofNod);

%% Loads
R = select_loads(Simetric,Ele_Type,Case,Loads,Nodes,Elements,nNod,nDofNod,t);

%% Loop
for i_Rel = 5.5:0.5:10
    %% E1
    E1 = E2*i_Rel;
    disp('----------------------------------------')
    [hours,minutes,seconds] = calc_time();
    disp(strcat(['Relacion: ',num2str(i_Rel)]))
    disp('----------------------------------------')
    
    for Alpha = 0:5:90
        
        
        %% Material's Properties
        [C] = alpha_select_material(Material,Alpha,E1,E2,G12,v12);

        disp(strcat(['Alpha: ',num2str(Alpha)]))
        disp('Preparations COMPLETED')

        %% Stiffness Matrix
        K = calc_k_mejorado(Ele_Type,Nodes,Elements,C,t,nEle,nNodEle,EleDofs,nDofNod,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16);

        %% Displacement Calculation
        [D,De,Disp,DCG] = calc_disp(Case,Nodes,bc,K,R,DAF,nDofNod,nNod);

        %% Stress Calculation
        [StrAvgNod,StrGP,StrNod,StrAvgGP] = calc_stress(Ele_Type,Nodes,Elements,C,De,EleDofs,nEle,nNodEle,nNod,nDofNod,uGP1,nGP1,uGP4,nGP4,uGP9,nGP9,uBP9,nBP9,uGP16,nGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16);

        %% Save Data
        surf_save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Disp,StrAvgNod,i_Rel,E2,G12,Alpha);

        %% Loop Time
        disp('----------------------------------------')
        [hours,minutes,seconds] = calc_time();
        disp(strcat(['Loop Time: ',hours,':',minutes,':',seconds]))
        disp('----------------------------------------')


    end
end

%% Finishing Time
disp('----------------------------------------')
toc
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Finishing Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')