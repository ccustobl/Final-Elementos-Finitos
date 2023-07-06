%Codigo Elemento Q8
clear
clc
close all
format short g

t = 1;  %mm

Nodes = load('TXT/Full/Nodes_Full_Q8_2.txt');
Nodes = Nodes(:,3:4);                
Elements = load('TXT/Full/Elements_Full_Q8_2.txt');
Elements = Elements(:,2:9);    

nDofNod = 2;                    % Número de grados de libertad por nodo
nel = size(Elements,1);         % Número de elementos
nNod = size(Nodes,1);           % Número de nodos
nNodEle = size(Elements,2);     % Número de nodos por elemento
nDofTot = nDofNod*nNod;         % Número de grados de libertad
nDims = size(Nodes,2);          % Número de dimensiones del problema
dof=reshape(1:nDofTot,2,[])';


%% Condiciones de borde:
bc=false(nNod,nDofNod);
NodLefBotbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
bc(NodLefBotbc,:) = true;
NodLefUpbc = find(abs(Nodes(:,1) - 0) <1e-9 );
bc(NodLefUpbc,1) = true;

%% Cargas externas:
R = zeros(nNod,nDofNod);
Lmax = max(Nodes(:,1));
hmax = max(Nodes(:,2));
q = 1;      %N/mm2        
% Right Side
NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
EleRigLoad = zeros(size(Elements,1),1);
for iLoad = 1:length(NodRigLoad)
    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
end
EleLoad = find(EleRigLoad);
NodLoad = zeros(length(EleLoad),3);
NodLoad(:,3) = 1;
for iLoad = 1:length(NodRigLoad)
   [I,~] = find(Elements==NodRigLoad(iLoad));
   for jLoad = 1:length(I)
      NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
      NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
   end
end
NodLoad(:,3) = [];
for iEle = 1:length(EleLoad)
    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/2;
    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/2;
end
% Left Side
NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
EleRigLoad = zeros(size(Elements,1),1);
for iLoad = 1:length(NodRigLoad)
    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
end
EleLoad = find(EleRigLoad);
NodLoad = zeros(length(EleLoad),3);
NodLoad(:,3) = 1;
for iLoad = 1:length(NodRigLoad)
   [I,~] = find(Elements==NodRigLoad(iLoad));
   for jLoad = 1:length(I)
      NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
      NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
   end
end
NodLoad(:,3) = [];
for iEle = 1:length(EleLoad)
    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/2;
    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/2;
end


%% Relacion Constituitva:

% Isotropo

E = 165e3;   %MPa
%         G = 75e3;    %MPa
v = 0.3;        
C = (E/(1-v^2))*[ 1 v 0 ; v 1 0 ; 0 0 (1-v)/2 ];

% Ortotropo

% t = 1; % Espesor
% E1=150E3;
% E2=180E3;
% E3=200E3;
% v12=0.3;
% v21=E2*v12/E1;
% v13=0.3;
% v31=E3*v13/E1;
% v23=0.3;
% v32=E3*v23/E2;
% G=75E3;
% S=[1/E1 -v21/E2 -v31/E3 0 0 0
%   -v12/E1  1/E2 -v32/E3 0 0 0
%   -v13/E1 -v23/E2  1/E3 0 0 0
%    0 0 0 1/G 0 0
%    0 0 0  0  1/G 0
%    0 0 0 0 0 1/G];
% 
% C=inv(S);
% 
%         
% Plane stress:
% C11=C(1,1)-(C(1,3)*C(3,1)/C(3,3));
% C12=C(1,2)-(C(3,2)*C(1,3)/C(3,3));
% C21=C(2,1)-(C(2,3)*C(3,1)/C(3,3));
% C22=C(2,2)-(C(2,3)*C(3,2)/C(3,3));
% 
% C=[C11 C12 0
%    C21 C22 0
%    0    0  C(4,4)];

   
%% Matriz de rigidez
rsInt = ones(1,2)*2; %*1,*2,*3
[wpg, upg, npg] = gauss(rsInt);

K = sparse(nDofTot,nDofTot); 
for iele = 1:nel
    Ke = zeros(nDofNod*nNodEle);
    nodesEle = Nodes(Elements(iele,:),:);
    for ipg = 1:npg
        % Punto de Gauss
        ksi = upg(ipg,1);
        eta = upg(ipg,2);  
        % Derivadas de las funciones de forma respecto de ksi, eta
        dN = shapefunsder([ksi eta],'Q8');  
        % Derivadas de x,y, respecto de ksi, eta
        jac = dN*nodesEle;               
        
        % Derivadas de las funciones de forma respecto de x,y.
        dNxy = jac\dN;          % dNxy = inv(jac)*dN
        
        B = zeros(size(C,2),nDofNod*nNodEle);
        B(1,1:2:2*nNodEle-1) = dNxy(1,:);
        B(2,2:2:2*nNodEle) = dNxy(2,:);
        B(3,1:2:2*nNodEle-1) = dNxy(2,:);
        B(3,2:2:2*nNodEle) = dNxy(1,:); 
        
        
        Ke = Ke + t*B'*C*B*wpg(ipg)*det(jac);
         
    end
    
    eleDofs =dof(Elements(iele,:),:);
    eleDofs=reshape(eleDofs',[],1);
    K(eleDofs,eleDofs) = K(eleDofs,eleDofs) + Ke;  
end
disp(strcat('Tiempo en armar matriz de rigidez->',num2str(toc),'seg'))

%% Calculo desplazamientos

%Reducción matriz
isFixed = reshape(bc',[],1);
isFree = ~isFixed;

%Solver
Dr = K(isFree,isFree)\R(isFree);

%Reconstrucción
D = zeros(nDofTot,1);

D(isFree) = Dr;
%%Reacciones:
Reacc=K*D;

%Sumatorias de fuerza en x e y igual a cero.
sumX=sum(Reacc(1:2:nDofTot-1));
sumY=sum(Reacc(2:2:nDofTot));

Dplot = (reshape(D,nDofNod,[]))';
nodePosition = Nodes + Dplot(:,1:2);
DCG = Nodes + Dplot*5000;

%% -----------------------Post-Proceso-------------------------------------

%Calculo de tensiones en nodos del elemento a partir de puntos superconvergentes.
a=sqrt(3)/3;
PG=[-a -a
     a -a
     a  a
    -a  a];
nPG=size(PG,1);

stressnodos=zeros(nel,nNodEle,3);
for iele = 1:nel
    stressPG=zeros(4,3); %4ptos gauss,3 tensiones.
    nodesEle = Nodes(Elements(iele,:),:);
    eleDofs =dof(Elements(iele,:),:);
    eleDofs=reshape(eleDofs',[],1);
 
    for ipg = 1:nPG
        % Punto de Gauss
        ksi = PG(ipg,1);
        eta = PG(ipg,2);  
        % Derivadas de las funciones de forma respecto de ksi, eta
        dN = shapefunsder([ksi eta],'Q8');  
        % Derivadas de x,y, respecto de ksi, eta
        jac = dN*nodesEle;                      
        % Derivadas de las funciones de forma respecto de x,y.
        dNxy = jac\dN;          % dNxy = inv(jac)*dN
        
        B = zeros(size(C,2),nDofNod*nNodEle);
        B(1,1:2:2*nNodEle-1) = dNxy(1,:);
        B(2,2:2:2*nNodEle) = dNxy(2,:);
        B(3,1:2:2*nNodEle-1) = dNxy(2,:);
        B(3,2:2:2*nNodEle) = dNxy(1,:); 

        stressPG(ipg,:)=C*B*D(eleDofs);
    end
       Rsextrapolacion=sqrt(3)*[-1 -1   %Nodos del Q8 visto desde sistema rs.
                                 1 -1
                                 1  1
                                -1  1
                                 0 -1
                                 1  0
                                 0  1
                                -1  0];
       %Extrapolo con funciones de forma del Q4:
       for inod=1:nNodEle
           r=Rsextrapolacion(inod,1);
           s=Rsextrapolacion(inod,2);
           NQ4=shapefuns([r s],'Q4');
           stressnodos(iele,inod,:)=NQ4*stressPG;
       end
   
end

%% Promedio de tensiones en los nodos:
stressavg=zeros(nNod,3);
for inode = 1:nNod
    [I,J] = find(Elements == inode);
    nShare = length(I);
    
    for ishare = 1:nShare
       stressavg(inode,:) = stressavg(inode,:) + squeeze(stressnodos(I(ishare),J(ishare),:))';
    end
   
    stressavg(inode,:) = stressavg(inode,:) / nShare;
end

%% Estimador de error ZZ:

invC=inv(C);
eta_el= zeros(nel,1);
e2_el= zeros(nel,1);
U2_el= zeros(nel,1);

rsInt = ones(1,2)*3; %*1,*2,*3
[wpg, upg, npg] = gauss(rsInt);

for iele =1:nel
    nodesEle = Nodes(Elements(iele,:),:);
    eleDofs = dof(Elements(iele,:),:);
    eleDofs = reshape(eleDofs',[],1);
    NODOSELE=Elements(iele,:);
    
    for ipg = 1:npg
        % Punto de Gauss
        ksi = upg(ipg,1);
        eta = upg(ipg,2);
        
        % Derivadas de las funciones de forma respecto de ksi, eta
         dNQ8 = shapefunsder([ksi eta],'Q8');
        % Derivadas de x,y, respecto de ksi, eta
        jac = dNQ8*nodesEle; 
        
        
        % Derivadas de las funciones de forma respecto de x,y.
        dNxy = jac\dNQ8;          % dNxy = inv(jac)*dN
        
        %Campo de tensiones real:
        B = zeros(size(C,1),nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle-1) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle-1) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);
        
        eleStress =C*B*D(eleDofs);
        
        % Campo de tensiones mejorado:
        NQ8=shapefuns([ksi eta],'Q8');
        starStress = ( NQ8 * stressavg(NODOSELE,:))'; % Tensiones Promediadas
        starStressNODOS=(NQ8*[stressnodos(iele,:,1)' stressnodos(iele,:,2)' stressnodos(iele,:,3)'])';
        
        
        e2_el(iele) = e2_el(iele) + (starStress - eleStress)' * ... 
                    invC * (starStress- eleStress) * wpg(ipg) * det(jac);
        
        U2_el(iele) = U2_el(iele) + eleStress' * invC * eleStress * ...;
                      wpg(ipg) * det(jac);

  
    end
    eta_el(iele) = sqrt( e2_el(iele) / (e2_el(iele) + U2_el(iele)) );
    
end


etaGlobal=sqrt(sum(e2_el)/(sum(e2_el)+sum(U2_el)))

%% Graficos

% Mesh
figure('Name','Mesh','NumberTitle','off')
for iNod = 1:length(Nodes)
    text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod));
end    
graph_meshplot(Elements,Nodes,'b')
title('Mesh','fontsize',13)

% Initial & Displaced Structure
figure('Name','Initial & Displaced Structure','NumberTitle','off')
hold on
graph_meshplot(Elements,Nodes,'b')
graph_meshplot(Elements,DCG,'r')
hold off
title('Initial & Displaced Structure')

% Elemental Error
figure('Name','Elemental Error','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
axis([ 0 100 0 30 ])
colorbar
title('Elemental Error','fontsize',13)

% Avg Stress_XX in the SC
figure('Name','Avg \sigma_X_X in the SC [MPa]','NumberTitle','off')
graph_scalarbandplot(Elements,Nodes,stressavg(:,1),[],'k',13,'interp')
axis([ 0 100 0 30 ])
colorbar
title('Avg \sigma_X_X in the SC [MPa]','fontsize',13)

