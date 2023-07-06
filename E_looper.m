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


%% E Paramter Selection

% G = 75e3;    %MPa
v = 0.3;


%% Parameters

Case = 'Final';  %% 'Final' ; 'Plate' ; 'PatchTest.X' ; 'PatchTest.Y' ; 'PatchTest.XY'
Ele_Type = 'Q8';  %Element Type%
Borders = 'Straight';  %% 'Straight' ; 'Curved'
TXT_Number = '400';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Material = 'Isotropic';  %% 'Orthotropic' ; 'Isotropic'
DAF = 5000;  %Displacement Amplifying Factor%
Simetric = 'No';  %% 'Yes' ; 'No'
Loads = 'Normal';  %% 'Normal ; 'Beam'


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
for E = 10e3:10e3:600e3

    %% Material's Properties
    C = (E/(1-v^2))*[ 1 v 0 ; v 1 0 ; 0 0 (1-v)/2 ];
    disp(strcat(['E: ',num2str(E)]))
    disp('Preparations COMPLETED')

    %% Stiffness Matrix
    K = calc_k_mejorado(Ele_Type,Nodes,Elements,C,t,nEle,nNodEle,EleDofs,nDofNod,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16);

    %% Displacement Calculation
    [D,De,Disp,DCG] = calc_disp(Case,Nodes,bc,K,R,DAF,nDofNod,nNod);

    %% Stress Calculation
    [StrAvgNod,StrGP,StrNod,StrAvgGP] = calc_stress(Ele_Type,Nodes,Elements,C,De,EleDofs,nEle,nNodEle,nNod,nDofNod,uGP1,nGP1,uGP4,nGP4,uGP9,nGP9,uBP9,nBP9,uGP16,nGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16);

    %% Save Data
    E_save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Disp,StrAvgNod,E)
    
    %% Loop Time
    disp('----------------------------------------')
    [hours,minutes,seconds] = calc_time();
    disp(strcat(['Loop Time: ',hours,':',minutes,':',seconds]))
    disp('----------------------------------------')

end

%% Finishing Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Finishing Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')

