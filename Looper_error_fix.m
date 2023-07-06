function etaG_1Avg = Looper_error_fix(Nodes,Elements,Simetric,eta_el,e2_el,U2_el,etaG,A_el)

%% Starting Stats  

disp('----------------------------------------')
disp('Error with no Mods')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el==max(eta_el)))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG)]))
disp('----------------------------------------')


%% Average Area
A_Avg = mean(A_el);


%% Eliminate U2_el < 0.1% U2_el_Avg

% eta_el_01Avg = eta_el;
% eta_el_01Avg_mark = eta_el;
% e2_el_01Avg = e2_el;
% 
% U2_el_01Avg = U2_el;
% Avg = mean(U2_el);
% Avg01 = Avg/1000;
% for iLoop = 1:length(U2_el)
%     if U2_el(iLoop)/A_el<Avg01/A_Avg
%         eta_el_01Avg(iLoop) = 0;
%         eta_el_01Avg_mark(iLoop) = 0;
%         e2_el_01Avg(iLoop) = 0;        
%     else
%         eta_el_01Avg_mark(iLoop) = 1;
%     end
% end
% 
% etaG_01Avg = sqrt(sum(e2_el_01Avg)/(sum(e2_el_01Avg) + sum(U2_el_01Avg)));
% 
% disp('U2_el < 0.1% U2_el_Avg')
% disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_01Avg==max(eta_el_01Avg),1))]))
% disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_01Avg))]))
% disp(strcat(['Relative Error (Eta): ',num2str(etaG_01Avg)]))
% disp('----------------------------------------')


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
        eta_el_1Avg_mark(iLoop) = 0;
        e2_el_1Avg(iLoop) = 0;
    else
        eta_el_1Avg_mark(iLoop) = 1;
    end
end

etaG_1Avg = sqrt(sum(e2_el_1Avg)/(sum(e2_el_1Avg) + sum(U2_el_1Avg)));

disp('U2_el < 1% U2_el_Avg')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el_1Avg==max(eta_el_1Avg),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el_1Avg))]))
disp(strcat(['Relative Error (Eta): ',num2str(etaG_1Avg)]))
disp('----------------------------------------')


