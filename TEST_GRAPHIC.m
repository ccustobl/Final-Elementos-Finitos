close all

figure(1)
set(figure(1),'defaultAxesColorOrder',[[0 0 0];[0 0 0]])
set(gca,'fontsize',20)

yyaxis left

x = 0 : 1000;
y = 200+log(x);
semilogx(x, y)

hold on
line([1  1e7],[13.16  13.16],'Color','k','LineStyle','-')

semilogx(nEle_Q4_Ort_45(1,1:10),sigmaxx_Q4_Ort_45(1,1:10),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','b')
semilogx(nEle_Q8_Ort_45(1,1:10),sigmaxx_Q8_Ort_45(1,1:10),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','r')
semilogx(nEle_Q9_Ort_45(1,1:10),sigmaxx_Q9_Ort_45(1,1:10),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','g')
semilogx(nEle_Q12_Ort_45(1,1:9),sigmaxx_Q12_Ort_45(1,1:9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','c')
semilogx(nEle_Q16_Ort_45(1,1:9),sigmaxx_Q16_Ort_45(1,1:9),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',14,'Color','m')
ylabel('Tensión en X Máxima [MPa]','FontSize', 22)
set(gca,'YTick',linspace(1,16,16))
ylim([1 16])

yyaxis right
semilogx(nEle_Q4_Ort_45(1,1:10),dispmaxx_Q4_Ort_45(1,1:10),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','b')
semilogx(nEle_Q8_Ort_45(1,1:10),dispmaxx_Q8_Ort_45(1,1:10),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','r')
semilogx(nEle_Q9_Ort_45(1,1:10),dispmaxx_Q9_Ort_45(1,1:10),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','g')
semilogx(nEle_Q12_Ort_45(1,1:9),dispmaxx_Q12_Ort_45(1,1:9),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','c')
semilogx(nEle_Q16_Ort_45(1,1:9),dispmaxx_Q16_Ort_45(1,1:9),'LineStyle','-.','LineWidth',2,'Marker','s','MarkerSize',14,'Color','m')

semilogx([1 1e7],[0.002451 0.002451],'Color','k','LineStyle','-.')
hold off

ylabel('Desplazamiento en X Máximo [mm]','FontSize',22)
set(gca,'YTick',linspace(1.25e-3,2.75e-3,7))
ylim([1.25e-3 2.75e-3])

grid on
xlim([5 5e6])
xlabel('Número de Elementos','FontSize',22)