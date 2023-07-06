%% FINAL: Corridas para almacenar datos
%%
%%
clc
close all
clear all
%% INICIALIZACION
%Mallas
mallas=[117];% 1 2 4 8 10 16 20 24 32 64 72 90 115 128/mejoradas: 27 54 63 81 108 117/especiales: 100 101
BiasMode='no';  %'no' '0.8' '0.5' '0.2' '0.1'
IntType='FULL'; %'FULL' 'SUB'
for ij=1:length(mallas)
    maux=num2str(mallas(ij));
    switch BiasMode
        case 'no'
            baux=' 1';baux2='_nb';
        case '0.8'
            baux=' 08';baux2='_08';
        case '0.5'
            baux=' 05';baux2='_05';
        case '0.2'
            baux=' 02';baux2='_02';
        case '0.1'
            baux=' 01';baux2='_01';
    end
nodes=textread(strcat('F:\ITBA UNIFICADO\4 AÑO\2do Cuatrimestre\Elementos Finitos\final\FINAL\MALLAS ADINA\Bias',baux,'\div',maux,baux2,'_nod.txt'));
nodes=nodes(:,[2 3]);
elements=textread(strcat('F:\ITBA UNIFICADO\4 AÑO\2do Cuatrimestre\Elementos Finitos\final\FINAL\MALLAS ADINA\Bias',baux,'\div',maux,baux2,'_ele.txt'));
elements=elements(:,[2:1:17]);

nDofNod = 2;                    % Numero de grados de libertad por nodo
nNodEle = 16;                   % Numero de nodos por elemento
nEle = size(elements,1);        % Numero de elementos
nNod = size(nodes,1);           % Numero de nodos
nDofTot = nDofNod*nNod;         % Numero de grados de libertad
doftotales(ij)=nDofTot;
dof=reshape(1:nDofTot,2,[])';
%% Matriz Constitutiva (plane stress)   
E=200e3; %Pa
NU=0.3;
t=1; %espesor
C = E/(1 - NU^2)*[ 1.0     NU         0.0
                    NU    1.0         0.0
                   0.0    0.0     (1 - NU)/2 ];
%% GAUSS
switch IntType
    case 'FULL'
        [wpg, upg, npg] = gauss([4,4]); strInt=' Full';
    case 'SUB'
        [wpg, upg, npg] = gauss([3,3]); strInt=' Sub';
end
%% Matriz de Rigidez (4x4 Puntos de Gauss para FULL)
tic
K = sparse(nDofTot,nDofTot);
nodeDofs = reshape(1:nDofTot,nDofNod,nNod)';
for iele = 1:nEle
%     Ke = zeros(nDofNod*nNodEle);
    Ke = sparse(nDofNod*nNodEle,nDofNod*nNodEle);
    nodesEle = nodes(elements(iele,:),:);
    for ipg = 1:npg
        % Punto de Gauss
        ksi = upg(ipg,1);
        eta = upg(ipg,2);  
        % Derivadas de las funciones de forma respecto de ksi, eta
        dN = shapefunsder([ksi eta],'Q16');
        % Derivadas de x,y, respecto de ksi, eta
        jac = dN*nodesEle;                      
        % Derivadas de las funciones de forma respecto de x,y.
        dNxy = jac\dN;          % dNxy = inv(jac)*dN
        B = zeros(size(C,2),nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle-1) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle-1) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
        Ke = Ke + B'*C*B*wpg(ipg)*det(jac)*t;
    end
    eleDofs = nodeDofs(elements(iele,:),:);
    eleDofs = reshape(eleDofs',[],1);
    K(eleDofs,eleDofs) = K(eleDofs,eleDofs) + Ke;  
end
%% GAUSS 4X4 PARA EL RESTO DEL CODIGO:
[wpg, upg, npg] = gauss([4,4]);
%% CARGAS
%Son los elementos cuyo nodo 1, estan en y=200 & x>=150 %nodes(elements(:,1),1)>=150 || nodes(elements(:,1),2)==200;
EleLoad=find(nodes(elements(:,1),1)>=150 & nodes(elements(:,1),2)==200);
R=zeros(nNod,nDofNod);
P=-0.05; %N/mm^2 (50 kN/m^2) //Sobre mm de largo y mm de espesor (El - porque va para abajo)
P=P/2; %Division de los pesos.Ver linea 4
P=P/mallas(ij);
P=P*t*150;
for i=1:length(EleLoad)
  %Para cada nodo 1 de los elementos involucrados le pongo la carga segun
  %su pesos
  R(elements(EleLoad(i),1),2)=R(elements(EleLoad(i),1),2)+0.25*P;
  R(elements(EleLoad(i),5),2)=R(elements(EleLoad(i),5),2)+0.75*P;
  R(elements(EleLoad(i),9),2)=R(elements(EleLoad(i),9),2)+0.75*P;
  R(elements(EleLoad(i),2),2)=R(elements(EleLoad(i),2),2)+0.25*P;
end
RSUM(ij)=sum(sum(R));
%% CONDICIONES DE BORDE
bc=true(nNod,nDofNod);
piso=find(nodes(:,2)<1e-5);
bc(piso,:)=false;
fixed=~bc;
free=reshape(bc',[],1);
%% DESPLAZAMIENTOS
Rr=reshape(R',[],1);
disp=zeros(nNod*nDofNod,1);
disp(free)=K(free,free)\Rr(free);
D=reshape(disp,nDofNod,nNod)';
toc
scale=10000;
nodePosition=nodes+scale*D;
figure()
title('Deformada')
meshplot(elements,nodes,'b');
meshplot(elements,nodePosition,'r');
legend('Original','Deformada')
nodePosition=nodes+scale*D;
% dmax(ij)=max(abs(disp));
[dxmax,rowx]=max(abs(D(:,1)));
[dymax,rowy]=max(abs(D(:,2)));
dmax(ij)=dymax;
dmaxX(ij)=dxmax;
rowx(ij)=rowx;
rowy(ij)=rowy;
%% Tensiones en los nodos extrapolando desde los de SC
stressSC=zeros(nEle,nNodEle,3);
a   = sqrt(5)/3;
PG=[-a -a;a -a;a a;-a a;0 -a;a 0;0 a;-a 0;0 0];
nPG=size(PG,1);
stressnodos=zeros(nEle,nNodEle,3);
for iele=1:nEle
    stressPG=zeros(9,3); %9 puntos de gauss, 3 tensiones
    nodesEle=nodes(elements(iele,:),:);
    eleDofs = reshape(nodeDofs(elements(iele,:),:)',[],1);
    for ipg=1:nPG;
        ksi= PG(ipg,1);
        eta= PG(ipg,2);
        dN=shapefunsder([ksi,eta],'Q16');
        jac = dN*nodesEle;
        dNxy=jac\dN;
        B = zeros(size(C,2),nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle-1) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle-1) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);
        stressPG(ipg,:)=C*B*disp(eleDofs);
    end
    rsExt=3/sqrt(5)*[-1 -1;1 -1;1 1;-1 1;-1/3 -1;1 -1/3;1/3 1;-1 1/3;1/3 -1;1 1/3;-1/3 1;-1 -1/3;-1/3 -1/3;1/3 -1/3;1/3 1/3;-1/3 1/3];%Nodos Q16 visto desde sistema rs
    %Extrapolo con funciones de forma del Q19:
    for inod=1:nNodEle
        r=rsExt(inod,1);
        s=rsExt(inod,2);
        NQ9=shapefuns([r s],'Q9');
        stressnodos(iele,inod,:)=NQ9*stressPG;
    end
end
%% Promediado de tensiones en los nodos
stressavg=zeros(nNod,3);
for inode = 1:nNod
    [I,J] = find(elements == inode);
    nShare = length(I);
    
    for ishare = 1:nShare
       stressavg(inode,:) = stressavg(inode,:) + squeeze(stressnodos(I(ishare),J(ishare),:))';
    end
   
    stressavg(inode,:) = stressavg(inode,:) / nShare;
end
% figure()
% scalarbandplot(elements,nodes,stressavg(:,1),[],'k',[],'interp');
% title('Tension en X promediadas')
% figure()
% scalarbandplot(elements,nodes,stressavg(:,2),[],'k',[],'interp');
% title('Tension en Y Promediada')
% figure()
% scalarbandplot(elements,nodes,stressavg(:,3),[],'k',[],'interp');
% title('Tension en XY Promediada')
%% Tensiones de Von Mises
stressVM=sqrt((stressavg(:,1).^2)-(stressavg(:,1).*stressavg(:,2))+(stressavg(:,2).^2)+3*(stressavg(:,3).^2));
figure()
scalarbandplot(elements,nodes,stressVM,[],'k',[],'interp');
title('Tensiones VM')
VMmax(ij)=max(max(stressVM));
%% Calculo de etal_el, e2, U2

invC =inv(C);
eta_el = zeros(nEle,1);
e2_el = zeros(nEle,1);
U2_el = zeros(nEle,1);

rsInt = ones(1,2)*3; %*1,*2,*3
[wpg, upg, npg] = gauss(rsInt);
for iele = 1:nEle
    nodesEle = nodes(elements(iele,:),:);
    eleDofs = reshape(nodeDofs(elements(iele,:),:)',[],1);
    NODOSELE=elements(iele,:);
    for ipg = 1:npg
        % Punto de Gauss
        ksi = upg(ipg,1);
        eta = upg(ipg,2);  
        % Derivadas de las funciones de forma respecto de ksi, eta
        dN=shapefunsder([ksi,eta],'Q16');
        % Derivadas de x,y, respecto de ksi, eta
        jac = dN*nodesEle;                      
        % Derivadas de las funciones de forma respecto de x,y.
        dNxy = jac\dN;          % dNxy = inv(jac)*dN
        % Campo de tensiones real:
        B = zeros(size(C,1),nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle-1) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle-1) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);
        
        eleStress= C*B*disp(eleDofs);
        
        % Campo de tensiones mejorado:
        NQ16=shapefuns([ksi,eta],'Q16');
        starStress = ( NQ16 * stressavg(elements(iele,:),:))'; % Tensiones Promediadas
        starStressNODOS=(NQ16*[stressnodos(iele,:,1)' stressnodos(iele,:,2)' stressnodos(iele,:,3)'])';
        
        e2_el(iele) = e2_el(iele) + (starStress - eleStress)' * invC * (starStress - eleStress) * wpg(ipg) * det(jac);
        
        U2_el(iele) = U2_el(iele) + eleStress' * invC * eleStress * wpg(ipg) *det(jac);
    end
    
    eta_el(iele) = sqrt( e2_el(iele) / (e2_el(iele) + U2_el(iele)) );
end

etaG(ij) = sqrt( sum(e2_el) / (sum(e2_el) + sum(U2_el)) );
%Plot de Error en cada elemento
figure()
scalarbandplot(elements,nodes,eta_el,[],'k',[],'flat'); %nodes %nodePosition
title('Error en cada elemento')
end
%% Plot Error Global
figure()
plot(doftotales,etaG,'r*-')
hold on
for i=1:ij
    text(doftotales(i)+10,etaG(i),num2str(etaG(i)))
end
title('Error Global')
xlabel('Cantidad de Grados de Libertad')
ylabel('Error Global')
%% Tasa convergencia
figure()
plot(log(doftotales),log(100*etaG),'r*-')
hold on
title('Tasa de Convergencia')
xlabel('log Cantidad de Grados de Libertad')
ylabel('log Error Global')
%% Convergencia de Tension de VM  (Maxima Absoluta)
figure()
%Calculo tension maxima
plot(doftotales,VMmax,'r*-')
title('\sigma_{VM} máxima')
xlabel('Cantidad de Grados de Libertad')
ylabel('Tension de VM Maxima Absoluta')
%% Convergencia Desplazamiento
figure()
plot(doftotales,dmax,'*r-')
title('Desplazamiento Maximo')
xlabel('Cantidad de Grados de Libertad')
ylabel('Desplazamiento máximo')
%% Datos para el error
switch IntType
        case 'FULL'
            errorq16full.mallas=mallas;    %Guardo mallas
            errorq16full.etaG=etaG;        %Guardo error
            errorq16full.doftot=doftotales;%Guardo doftotales
            errorq16full.dymax=dmax;       %Guardo disp max en Y
            errorq16full.dxmax=dmaxX;      %Guardo disp max en X
            errorq16full.VMmax=VMmax;      %Guardo VM max
            errorq16full.K=K;              %Guardo matriz K
        case 'SUB'
            errorq16sub.mallas=mallas;    %Guardo mallas
            errorq16sub.etaG=etaG;        %Guardo error
            errorq16sub.doftot=doftotales;%Guardo doftotales
            errorq16sub.dymax=dmax;       %Guardo disp max en Y
            errorq16sub.dxmax=dmaxX;      %Guardo disp max en X
            errorq16sub.VMmax=VMmax;      %Guardo VM max
            errorq16sub.K=K;              %Guardo matriz K
end
% save('errorq16fullesp117.mat','errorq16full');
% save('errorq16subesp117.mat','errorq16sub');