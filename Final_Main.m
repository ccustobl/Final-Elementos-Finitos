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


%% User Parameter Selection

Case = 'Final';  %% 'Final' ; 'Plate' ; 'PatchTest.X' ; 'PatchTest.Y' ; 'PatchTest.XY'
Ele_Type = 'Q8';  %Element Type%
Borders = 'Straight';  %% 'Straight' ; 'Curved'
TXT_Number = '4';  %Mesh Number%
Ref_R = 'No';  %% 'Yes' ; 'No'
Ref_R_Number = '2';  %R Refinement Number%
Calculate_K = 'Yes';  %% 'Yes' ; 'No'
Save_K = 'No';  %% 'Yes' ; 'No'
Material = 'Isotropic';  %% 'Orthotropic' ; 'Isotropic'
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

%% Material's Properties
[C,E,Alpha] = select_material(Material);

%% Boundary Conditions
bc = select_boundary_conditions(Simetric,Ele_Type,Case,Loads,Nodes,nNod,nDofNod);

%% Loads
R = select_loads(Simetric,Ele_Type,Case,Loads,Nodes,Elements,nNod,nDofNod,t);
disp('Preparations COMPLETED')

%% Stiffness Matrix
if strcmp(Calculate_K,'Yes')==1
    K = calc_k_mejorado(Ele_Type,Nodes,Elements,C,t,nEle,nNodEle,EleDofs,nDofNod,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16);
    save_k(K,Simetric,Ele_Type,Save_K,TXT_Number,Ref_R,Ref_R_Number,Material,E,Alpha);
else
    K = load_k(Simetric,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,E,Alpha);
end

%% Displacement Calculation
[D,De,Disp,DCG] = calc_disp(Case,Nodes,bc,K,R,DAF,nDofNod,nNod);

%% Stress Calculation
[StrAvgNod,StrGP,StrNod,StrAvgGP] = calc_stress(Ele_Type,Nodes,Elements,C,De,EleDofs,nEle,nNodEle,nNod,nDofNod,uGP1,nGP1,uGP4,nGP4,uGP9,nGP9,uBP9,nBP9,uGP16,nGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16);

%% Error Calculation
[etaG,eta_el,e2_el,U2_el,A_el] = calc_error(Ele_Type,Nodes,Elements,nEle,C,StrAvgNod,StrGP,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16);

%% Display
print_data_end(etaG,eta_el,StrAvgNod,Nodes,Disp);

%% Graphs
graphic(Simetric,Material,TXT_Number,Case,Elements,Nodes,DCG,StrAvgNod,eta_el,U2_el,e2_el);

%% Finishing Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Finishing Time: ',hours,':',minutes,':',seconds]))

%% Error Fixing
if strcmp(Case(1:5),'Final')==1
    etaG_1 = error_fix(Nodes,Elements,Simetric,eta_el,e2_el,U2_el,etaG,A_el);
end

%% Data Save
if strcmp(Case(1:5),'Final')==1
    Data_Save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Simetric,nNod,nEle,etaG,etaG_1,Disp,StrAvgNod,E,Alpha)
end

%% Error Fixing Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Error Fixing Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')
