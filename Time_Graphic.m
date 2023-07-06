clear 
close all
clc
format short


%% Data Load Loop
Data = { 'nNod' 'nEle' 'errorG' 'errorG_1' 'sigmaxx' 'sigmaxy' 'sigmavm' 'dispmaxx' 'dispmaxy' };  %Measured Variables%
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


%% Time Vectors

% Matriz Homogenea
Q4_Hom_Ort_Final =  [0.262 0.274 0.314 0.524 2.050 7.450  91.741  1087.158];
Q8_Hom_Ort_Final =  [0.292 0.319 0.422 0.782 3.074 13.494 160.792 1595.252];
Q9_Hom_Ort_Final =  [0.311 0.352 0.451 0.895 3.404 16.855 202.367 1852.148];
Q12_Hom_Ort_Final = [0.353 0.390 0.568 1.262 4.739 24.682 282.075];
Q16_Hom_Ort_Final = [0.418 0.490 0.737 1.850 8.244 44.334 527.465];
Length_Hom_Q4 = length(Q4_Hom_Ort_Final);
Length_Hom_Q8 = length(Q8_Hom_Ort_Final);
Length_Hom_Q9 = length(Q9_Hom_Ort_Final);
Length_Hom_Q12 = length(Q12_Hom_Ort_Final);
Length_Hom_Q16 = length(Q16_Hom_Ort_Final);

% Matriz Refinada
Q4_Ref_Ort_Final =  [1.029 2.509 2.756  8.964  22.637  114.348 333.824 1267.692 3805.020];
Q8_Ref_Ort_Final =  [1.545 3.592 4.934  14.912 37.506  197.603 552.111 1822.238 5482.620];
Q9_Ref_Ort_Final =  [1.680 4.372 6.436  19.209 52.353  218.613 661.592 2130.678 6153.433];
Q12_Ref_Ort_Final = [2.104 5.730 9.342  27.815 76.498  340.415];
Q16_Ref_Ort_Final = [3.382 9.524 15.774 52.952 140.235 598.402];
Q4_Ref_Ort_Final = fliplr(Q4_Ref_Ort_Final);
Q8_Ref_Ort_Final = fliplr(Q8_Ref_Ort_Final);
Q9_Ref_Ort_Final = fliplr(Q9_Ref_Ort_Final);
Q12_Ref_Ort_Final = fliplr(Q12_Ref_Ort_Final);
Q16_Ref_Ort_Final = fliplr(Q16_Ref_Ort_Final);
Length_Ref_Q4 = length(Q4_Ref_Ort_Final);
Length_Ref_Q8 = length(Q8_Ref_Ort_Final);
Length_Ref_Q9 = length(Q9_Ref_Ort_Final);
Length_Ref_Q12 = length(Q12_Ref_Ort_Final);
Length_Ref_Q16 = length(Q16_Ref_Ort_Final);


%% Graficos

% Error Global/Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(1)
set(figure(1),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4)./(2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4)),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8)./(2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8)),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9)./(2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9)),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12)./(2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12)),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16)./(2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16)),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([10^-11 10^-1])
xlabel('Error Global/Grados de Libertad','FontSize', 22)
title('Error Global/Grados de Libertad vs Tiempo de Corrida','FontSize',20)
legend({' ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(10)
set(figure(10),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog((1-errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4))./(2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4)),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog((1-errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8))./(2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8)),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog((1-errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9))./(2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9)),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog((1-errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12))./(2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12)),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog((1-errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16))./(2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16)),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([10^-6 10^-1])
xlabel('(1-Error Global)/Grados de Libertad','FontSize', 22)
title('(1-Error Global)/Grados de Libertad vs Tiempo de Corrida','FontSize',20)
legend({' ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(11)
set(figure(11),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50e3 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog((2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4))./(1-errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4)),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog((2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8))./(1-errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8)),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog((2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9))./(1-errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9)),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog((2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12))./(1-errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12)),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog((2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16))./(1-errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16)),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([10^1 5e7])
xlabel('Grados de Libertad/(1-Error Global)','FontSize', 22)
title('Grados de Libertad/(1-Error Global) vs Tiempo de Corrida','FontSize',20)
legend({' ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(20)
set(figure(20),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50e3 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog((2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4)),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog((2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8)),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog((2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9)),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog((2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12)),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog((2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16)),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
% loglog([1 1e8],[10^-5 10^-5],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([10^1 5e7])
xlabel('Grados de Libertad','FontSize', 22)
title('Grados de Libertad vs Tiempo de Corrida','FontSize',20)
legend({' ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(30)
set(figure(30),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-4 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([15^-5 10^0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(40)
set(figure(40),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-4 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)
ylim([10^-1 1e4])

grid on
xlim([15^-5 10^0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Numero de Grados de Libertad vs Tiempo: HOMOGENEO
figure(50)
set(figure(50),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4),(2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4))./Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8),(2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8))./Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9),(2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9))./Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12),(2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12))./Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16),(2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16))./Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-4 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Grados de Libertad/Tiempo [1/s]','FontSize', 22)
ylim([10^2 10^4])

grid on
xlim([15^-5 10^0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Grados de Libertad/Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo ','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


%% REFINADO

% Error Global/Numero de Grados de Libertad vs Tiempo: REFINADO
figure(100)
set(figure(100),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_r2_Ort_45(1,402:410)./(2*nNod_Q4_r2_Ort_45(1,402:410)),Q4_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_r2_Ort_45(1,402:410)./(2*nNod_Q8_r2_Ort_45(1,402:410)),Q8_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_r2_Ort_45(1,402:410)./(2*nNod_Q9_r2_Ort_45(1,402:410)),Q9_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_r2_Ort_45(1,405:410)./(2*nNod_Q12_r2_Ort_45(1,405:410)),Q12_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_r2_Ort_45(1,405:410)./(2*nNod_Q16_r2_Ort_45(1,405:410)),Q16_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
hold off
ylabel('Tiempo [s]','FontSize', 22)

ylim([5e-1 5e4])

grid on
xlim([1e-12 1e-4])
xlabel('Error Global/Grados de Libertad','FontSize', 22)
title('Error Global/Grados de Libertad vs Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Error Global vs Numero de Grados de Libertad/Tiempo: REFINADO
figure(110)
set(figure(110),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_r2_Ort_45(1,402:410),Q4_Ref_Ort_Final./(2*nNod_Q4_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_r2_Ort_45(1,402:410),Q8_Ref_Ort_Final./(2*nNod_Q8_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_r2_Ort_45(1,402:410),Q9_Ref_Ort_Final./(2*nNod_Q9_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_r2_Ort_45(1,405:410),Q12_Ref_Ort_Final./(2*nNod_Q12_r2_Ort_45(1,405:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_r2_Ort_45(1,405:410),Q16_Ref_Ort_Final./(2*nNod_Q16_r2_Ort_45(1,405:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-5 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Grados de Libertad/Tiempo [1/s]','FontSize', 22)

ylim([1e-4 1e-2])

grid on
xlim([1e-6 1e0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Grados de Libertad/Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')


% Error Global vs Numero de Grados de Libertad/Tiempo: REFINADO
figure(120)
set(figure(120),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_r2_Ort_45(1,402:410),Q4_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_r2_Ort_45(1,402:410),Q8_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_r2_Ort_45(1,402:410),Q9_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_r2_Ort_45(1,405:410),Q12_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_r2_Ort_45(1,405:410),Q16_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-5 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)

ylim([5e-1 1e4])

grid on
xlim([1e-6 1e-1])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')



%%


% Error Global vs Numero de Grados de Libertad/Tiempo: REFINADO
figure(200)
set(figure(200),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4),Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8),Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9),Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12),Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16),Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','m')
loglog(errorG_1_Q4_r2_Ort_45(1,402:410),Q4_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_r2_Ort_45(1,402:410),Q8_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_r2_Ort_45(1,402:410),Q9_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_r2_Ort_45(1,405:410),Q12_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_r2_Ort_45(1,405:410),Q16_Ref_Ort_Final,'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-5 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Tiempo [s]','FontSize', 22)

ylim([1e-1 1e4])

grid on
xlim([1e-6 1e0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo','Homogenea Q4','Homogenea Q8','Homogenea Q9','Homogenea Q12','Homogenea Q16','Mejorada Q4','Mejorada Q8','Mejorada Q9','Mejorada Q12','Mejorada Q16'},'FontSize',20,'Location','Best')



% Error Global vs Numero de Grados de Libertad/Tiempo: REFINADO
figure(210)
set(figure(210),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

t = 0 : 2*pi/360 : 2*pi; 
x = exp(t);
y = 50 + exp(3*t); 
loglog(x,y,'LineStyle','-.','LineWidth',1)

hold on
loglog(errorG_1_Q4_Ort_45(1,1:Length_Hom_Q4),(2*nNod_Q4_Ort_45(1,1:Length_Hom_Q4))./Q4_Hom_Ort_Final(1,1:Length_Hom_Q4),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','b')
loglog(errorG_1_Q8_Ort_45(1,1:Length_Hom_Q8),(2*nNod_Q8_Ort_45(1,1:Length_Hom_Q8))./Q8_Hom_Ort_Final(1,1:Length_Hom_Q8),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','r')
loglog(errorG_1_Q9_Ort_45(1,1:Length_Hom_Q9),(2*nNod_Q9_Ort_45(1,1:Length_Hom_Q9))./Q9_Hom_Ort_Final(1,1:Length_Hom_Q9),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','g')
loglog(errorG_1_Q12_Ort_45(1,1:Length_Hom_Q12),(2*nNod_Q12_Ort_45(1,1:Length_Hom_Q12))./Q12_Hom_Ort_Final(1,1:Length_Hom_Q12),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','c')
loglog(errorG_1_Q16_Ort_45(1,1:Length_Hom_Q16),(2*nNod_Q16_Ort_45(1,1:Length_Hom_Q16))./Q16_Hom_Ort_Final(1,1:Length_Hom_Q16),'LineStyle','-.','LineWidth',1,'Marker','o','MarkerSize',10,'Color','m')
loglog(errorG_1_Q4_r2_Ort_45(1,402:410),Q4_Ref_Ort_Final./(2*nNod_Q4_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
loglog(errorG_1_Q8_r2_Ort_45(1,402:410),Q8_Ref_Ort_Final./(2*nNod_Q8_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
loglog(errorG_1_Q9_r2_Ort_45(1,402:410),Q9_Ref_Ort_Final./(2*nNod_Q9_r2_Ort_45(1,402:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
loglog(errorG_1_Q12_r2_Ort_45(1,405:410),Q12_Ref_Ort_Final./(2*nNod_Q12_r2_Ort_45(1,405:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
loglog(errorG_1_Q16_r2_Ort_45(1,405:410),Q16_Ref_Ort_Final./(2*nNod_Q16_r2_Ort_45(1,405:410)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
loglog([10^-5 10^-5],[1e-5 1e8],'LineStyle','-.','LineWidth',1,'Marker','*','MarkerSize',14,'Color','k')
hold off
ylabel('Grados de Libertad/Tiempo [1/s]','FontSize', 22)

ylim([1e-4 1e-2])

grid on
xlim([1e-6 1e0])
xlabel('Error Global','FontSize', 22)
title('Error Global vs Grados de Libertad/Tiempo de Corrida','FontSize',20)
legend({'Error Objetivo','Q4','Q8','Q9','Q12','Q16'},'FontSize',20,'Location','Best')
