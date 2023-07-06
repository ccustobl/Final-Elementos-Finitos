function Looper_Main(TXT_Number,Ele_Type,Ref_R,Ref_R_Number,Calculate_K,Save_K,Material,DAF,Simetric)

tic

%% Starting Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Starting Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')


%% Parameters
Case = 'Final';  %% 'Final'
Borders = 'Straight';  %% 'Straight'
Loads = 'Normal';

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

%% Finishing Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Finishing Time: ',hours,':',minutes,':',seconds]))

%% Error Fixing
% if strcmp(TXT_Number(1,1),'0')==0
    etaG_1 = Looper_error_fix(Nodes,Elements,Simetric,eta_el,e2_el,U2_el,etaG,A_el);
% else
%     etaG_1 = 0;
% end

%% Data Save
Data_Save(Nodes,Ele_Type,TXT_Number,Ref_R,Ref_R_Number,Material,Simetric,nNod,nEle,etaG,etaG_1,Disp,StrAvgNod,E,Alpha)

%% Error Fixing Time
disp('----------------------------------------')
toc
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Error Fixing Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')

