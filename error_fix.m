function etaG_1Avg = error_fix(Nodes,Elements,Simetric,eta_el,e2_el,U2_el,etaG,A_el)

%% Starting Stats  

disp('----------------------------------------')
disp('Error with no Mods')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el==max(eta_el)))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG)]))
disp('----------------------------------------')


%% Average Area
A_Avg = mean(A_el);


%%
if size(Elements,1)< 1

%% Eliminate U2_el < 0.1% U2_el_Avg
    
eta_el_01Avg = eta_el;
eta_el_01Avg_mark = eta_el;
e2_el_01Avg = e2_el;
U2_el_01Avg = U2_el;

Avg = mean(U2_el);
Avg01 = Avg/1000;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg01/A_Avg
        eta_el_01Avg(iLoop) = 0;
        eta_el_01Avg_mark(iLoop) = 1;
        e2_el_01Avg(iLoop) = 0;        
    else
        eta_el_01Avg_mark(iLoop) = 0;
    end
end

etaG_01Avg = sqrt(sum(e2_el_01Avg)/(sum(e2_el_01Avg) + sum(U2_el_01Avg)));

% Elemental Error
figure('Name','Elemental Error < 0.1% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_01Avg,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 0.1% U2 Avg','fontsize',13)

% Elemental Error Mark
figure('Name','Elemental Error < 0.1% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_01Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 0.1% U2 Avg Marked','fontsize',13)

disp('U2_el < 0.1% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_01Avg==max(eta_el_01Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_01Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_01Avg)]))
disp('----------------------------------------')

end


%% Eliminate U2_el < 1% U2_el_Avg

eta_el_1Avg = eta_el;
eta_el_1Avg_mark = eta_el;
e2_el_1Avg = e2_el;
U2_el_1Avg = U2_el;

Avg = mean(U2_el);
Avg1 = Avg/100;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg1/A_Avg
        eta_el_1Avg(iLoop) = 0;
        eta_el_1Avg_mark(iLoop) = 1;
        e2_el_1Avg(iLoop) = 0;
        U2_el_1Avg(iLoop) = 0;
    else
        eta_el_1Avg_mark(iLoop) = 0;
    end
end

etaG_1Avg = sqrt(sum(e2_el_1Avg)/(sum(e2_el_1Avg) + sum(U2_el)));

% Elemental Error
figure('Name','Elemental Error < 1% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_1Avg,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 1% U2 Avg','fontsize',13)

% Elemental Error
figure('Name','Elemental Error < 1% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_1Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 1% U2 Avg Marked','fontsize',13)

% Deformation Energy
figure('Name','Deformation Energy','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,U2_el_1Avg,[],'none',[],'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Deformation Energy','fontsize',13)

% Error Energy
figure('Name','Error Energy','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,e2_el_1Avg,[],'none',[],'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Error Energy','fontsize',13)

disp('U2_el < 1% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_1Avg==max(eta_el_1Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_1Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_1Avg)]))
disp('----------------------------------------')

%%
if size(Elements,1)< 1
%% Eliminate U2_el < 10% U2_el_Avg

eta_el_10Avg = eta_el;
eta_el_10Avg_mark = eta_el;
e2_el_10Avg = e2_el;

U2_el_10Avg = U2_el;
Avg = mean(U2_el);
Avg10 = Avg/10;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg10/A_Avg
        eta_el_10Avg(iLoop) = 0;
        eta_el_10Avg_mark(iLoop) = 1;
        e2_el_10Avg(iLoop) = 0;
    else
        eta_el_10Avg_mark(iLoop) = 0;
    end
end

etaG_10Avg = sqrt(sum(e2_el_10Avg)/(sum(e2_el_10Avg) + sum(U2_el_10Avg)));

% Elemental Error
figure('Name','Elemental Error < 10% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_10Avg,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar('fontsize',13)
title('Error Elemental ignorando U2 < 0.1% U2 Avg','fontsize',13)

% Elemental Error
figure('Name','Elemental Error < 10% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_10Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 10% U2 Avg Marked','fontsize',13)

disp('U2_el < 10% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_10Avg==max(eta_el_10Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_10Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_10Avg)]))
disp('----------------------------------------')



    
%% Eliminate U2_el < 50% U2_el_Avg

eta_el_50Avg = eta_el;
eta_el_50Avg_mark = eta_el;
e2_el_50Avg = e2_el;

U2_el_50Avg = U2_el;
Avg = mean(U2_el);
Avg50 = Avg/2;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg50/A_Avg
        eta_el_50Avg(iLoop) = 0;
        eta_el_50Avg_mark(iLoop) = 1;
        e2_el_50Avg(iLoop) = 0;
    else
        eta_el_50Avg_mark(iLoop) = 0;
    end
end

etaG_50Avg = sqrt(sum(e2_el_50Avg)/(sum(e2_el_50Avg) + sum(U2_el_50Avg)));

% Elemental Error
figure('Name','Elemental Error < 50% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_50Avg,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 50% U2 Avg','fontsize',13)

% Elemental Error
figure('Name','Elemental Error < 50% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_50Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 50% U2 Avg Marked','fontsize',13)

disp('U2_el < 50% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_50Avg==max(eta_el_50Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_50Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_50Avg)]))
disp('----------------------------------------')


%% Eliminate U2_el < 80% U2_el_Avg

eta_el_80Avg = eta_el;
eta_el_80Avg_mark = eta_el;
e2_el_80Avg = e2_el;

U2_el_80Avg = U2_el;
Avg = mean(U2_el);
Avg80 = Avg/1.25;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg80/A_Avg
        eta_el_80Avg(iLoop) = 0;
        eta_el_80Avg_mark(iLoop) = 1;
        e2_el_80Avg(iLoop) = 0;
    else
        eta_el_80Avg_mark(iLoop) = 0;        
    end
end

etaG_80Avg = sqrt(sum(e2_el_80Avg)/(sum(e2_el_80Avg) + sum(U2_el_80Avg)));

% Elemental Error
figure('Name','Elemental Error < 80% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_80Avg,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 80% U2 Avg','fontsize',13)

% Elemental Error
figure('Name','Elemental Error < 80% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_80Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error < 80% U2 Avg Marked','fontsize',13)

disp('U2_el < 80% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_80Avg==max(eta_el_80Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_80Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_80Avg)]))
disp('----------------------------------------')


%% Eliminate U2_el < 100% U2_el_Avg

eta_el_100Avg = eta_el;
eta_el_100Avg_mark = eta_el;
e2_el_100Avg = e2_el;

U2_el_100Avg = U2_el;
Avg = mean(U2_el);
Avg100 = Avg/1;
for iLoop = 1:length(U2_el)
    if U2_el(iLoop)/A_el<Avg100/A_Avg
        eta_el_100Avg(iLoop) = 0;
        eta_el_100Avg_mark(iLoop) = 0;
        e2_el_100Avg(iLoop) = 0;
    else
        eta_el_100Avg_mark(iLoop) = 1;        
    end
end

etaG_100Avg = sqrt(sum(e2_el_100Avg)/(sum(e2_el_100Avg) + sum(U2_el_100Avg)));

% Elemental Error
figure('Name','Elemental Error < 100% U2 Avg','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_100Avg,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error U2 > U2 Avg','fontsize',20)

% Elemental Error
figure('Name','Elemental Error < 100% U2 Avg Marked','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_100Avg_mark,[],'none',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar('fontsize',13)
title('Elemental Error < 100% U2 Avg Marked','fontsize',13)

disp('U2_el < 100% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_100Avg==max(eta_el_100Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_100Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_100Avg)]))
disp('----------------------------------------')


%% Eliminate the Corner

switch Simetric
    case 'Yes'
        Nod_ArIZq = find(Nodes(:,2)>28 & Nodes(:,1)<7);
    case 'No'
        Nod_ArIZq = find(Nodes(:,1)>43 & Nodes(:,1)<57 & Nodes(:,2)>28);
end

Ele_ArIzq = zeros(size(Elements,1),1);
for iDet = 1:length(Nod_ArIZq)
    Ele_ArIzq = Ele_ArIzq + (sum(~(Elements - Nod_ArIZq(iDet))'))';
end

EleDet = find(Ele_ArIzq);

eta_el_Det = eta_el_1Avg;
eta_el_Det(EleDet) = 0;
e2_el_Det = e2_el_1Avg;
e2_el_Det(EleDet) = 0;
U2_el_Det = U2_el_1Avg;

etaG_Det = sqrt(sum(e2_el_Det)/(sum(e2_el_Det) + sum(U2_el_Det)));

% Elemental Error
figure('Name','Elemental Error Detector1','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_Det,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error Detector1','fontsize',13)

disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_Det==max(eta_el_Det),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_Det))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_Det)]))
disp('----------------------------------------')


%% Elimina los siguientes 20

eta_el_Det15 = eta_el_Det;
e2_el_Det15 = e2_el_Det;
for iLoop = 1:20
    eta_el_Det15(eta_el_Det15==max(eta_el_Det15)) = 0;
    e2_el_Det15(eta_el_Det15==max(eta_el_Det15)) = 0;
end

U2_el_Det15 = U2_el_Det;

etaG_Det15 = sqrt(sum(e2_el_Det15)/(sum(e2_el_Det15) + sum(U2_el_Det15)));

% Elemental Error
figure('Name','Elemental Error Detector 1.5','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_Det15,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error Detector 1.5','fontsize',13)

disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_Det15==max(eta_el_Det15),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_Det15))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_Det15)]))
disp('----------------------------------------')


%% Eliminate the Square

switch Simetric
    case 'Yes'
        Nod_ArIZq2 = find(Nodes(:,2)>20 & Nodes(:,1)<20);
    case 'No'
        Nod_ArIZq2 = find(Nodes(:,1)>30 & Nodes(:,1)<70 & Nodes(:,2)>20);
end
Ele_ArIzq2 = zeros(size(Elements,1),1);
for iDet = 1:length(Nod_ArIZq2)
    Ele_ArIzq2 = Ele_ArIzq2 + (sum(~(Elements - Nod_ArIZq2(iDet))'))';
end

EleDet2 = find(Ele_ArIzq2);

eta_el_Det2 = eta_el_Det;
eta_el_Det2(EleDet2) = 0;
e2_el_Det2 = e2_el_Det;
e2_el_Det2(EleDet2) = 0;
U2_el_Det2 = U2_el;

etaG_Det2 = sqrt(sum(e2_el_Det2)/(sum(e2_el_Det2) + sum(U2_el_Det2)));

% Elemental Error
figure('Name','Elemental Error Detector2','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_Det2,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error Detector2','fontsize',13)

disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_Det2==max(eta_el_Det2),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_Det2))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_Det2)]))
disp('----------------------------------------')


%% Elimina los siguientes 20

eta_el_Det3 = eta_el_Det2;
e2_el_Det3 = e2_el_Det2;
for iLoop = 1:20
    eta_el_Det3(eta_el_Det3==max(eta_el_Det3)) = 0;
    e2_el_Det3(eta_el_Det3==max(eta_el_Det3)) = 0;
end

U2_el_Det3 = U2_el_Det2;

etaG_Det3 = sqrt(sum(e2_el_Det3)/(sum(e2_el_Det3) + sum(U2_el_Det3)));

% Elemental Error
figure('Name','Elemental Error Detector3','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_Det3,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error Detector3','fontsize',13)

% Deformation Energy
% figure('Name','Deformation Energy Detector3','NumberTitle','off')
% graph_scalarbandplot(Elements,Nodes,U2_el_Det3,[],'k',[],'flat')
% switch Simetric
%     case'Yes'
%         axis([ 0 50 0 30 ])
%     case 'No'
%         axis([ 0 100 0 30 ])
% end
% colorbar
% title('Deformation Energy Detector3','fontsize',13)

disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_Det3==max(eta_el_Det3),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_Det3))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_Det3)]))
disp('----------------------------------------')


%% Elimina los siguientes 30

eta_el_Det4 = eta_el_Det3;
e2_el_Det4 = e2_el_Det3;
for iLoop = 1:30
    eta_el_Det4(eta_el_Det4==max(eta_el_Det4)) = 0;
    e2_el_Det4(eta_el_Det4==max(eta_el_Det4)) = 0;
end

U2_el_Det4 = U2_el_Det3;

etaG_Det4 = sqrt(sum(e2_el_Det4)/(sum(e2_el_Det4) + sum(U2_el_Det4)));

% Elemental Error
figure('Name','Elemental Error Detector4','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el_Det4,[],'k',10,'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Elemental Error Detector4','fontsize',13)

% Deformation Energy
figure('Name','Deformation Energy Detector4','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,U2_el_Det4,[],'k',[],'flat')
switch Simetric
    case'Yes'
        axis([ 0 50 0 30 ])
    case 'No'
        axis([ 0 100 0 30 ])
end
colorbar
title('Deformation Energy Detector4','fontsize',13)

disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_Det4==max(eta_el_Det4),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_Det4))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_Det4)]))
disp('----------------------------------------')

end

