%Codigo Elemento Q8
clear
clc
close all
format short g


nodes=load('nodos.txt');
nodes(:,[1 4 5])=[];
elements=load('elements.txt');
elements(:,[1 10])=[]; 

nDofNod = 2;                    % Número de grados de libertad por nodo
nel = size(elements,1);         % Número de elementos
nNod = size(nodes,1);           % Número de nodos
nNodEle = size(elements,2);     % Número de nodos por elemento
nDofTot = nDofNod*nNod;         % Número de grados de libertad
nDims = size(nodes,2);          % Número de dimensiones del problema
dof=reshape(1:nDofTot,2,[])';


%% Condiciones de borde:
bc=false(nNod,nDofNod);
for inod=1:nNod
    if nodes(inod,1)<1E-9
    bc(inod,:)=true;
    end
end

%% Cargas externas:
R=zeros(nDofTot,1);
q=1; %N/mm
for iele=1:nel
    nodesEle = nodes(elements(iele,:),:);
    eleDofs=dof(elements(iele,:),:);
    eleDofs=reshape(eleDofs',[],1);
   
    if nodesEle(1,2)+100<1E-9 && nodesEle(1,1)>=100
        
    Rsup=zeros(nNodEle,nDofNod);
    %Gauss1D:
    npg=2;
    [wpg,upg]=gauss1D(npg);
    for ipg=1:npg
        ksi=upg(ipg);
        eta=-1;
        dN=shapefunsder([ksi eta],'Q8');
        J=dN*nodesEle;
        sgm=+q;
        N=shapefuns([ksi eta],'Q8');
        Rsup=Rsup+N'*[-sgm*J(1,2) sgm*J(1,1)]*wpg(ipg);
    end
    Rsup=reshape(Rsup',[],1);
    R(eleDofs)=R(eleDofs)+Rsup;  
    end  
end
CargaTotal=sum(R); %Tiene que ser 50N

%% Relacion Constituitva:
t = 1; % Espesor
E1=150E3;
E2=180E3;
E3=200E3;
v12=0.3;
v21=E2*v12/E1;
v13=0.3;
v31=E3*v13/E1;
v23=0.3;
v32=E3*v23/E2;
G=75E3;
S=[1/E1 -v21/E2 -v31/E3 0 0 0
  -v12/E1  1/E2 -v32/E3 0 0 0
  -v13/E1 -v23/E2  1/E3 0 0 0
   0 0 0 1/G 0 0
   0 0 0  0  1/G 0
   0 0 0 0 0 1/G];

C=inv(S);

        
%Plane stress:
C11=C(1,1)-(C(1,3)*C(3,1)/C(3,3));
C12=C(1,2)-(C(3,2)*C(1,3)/C(3,3));
C21=C(2,1)-(C(2,3)*C(3,1)/C(3,3));
C22=C(2,2)-(C(2,3)*C(3,2)/C(3,3));

C=[C11 C12 0
   C21 C22 0
   0    0  C(4,4)];

   
%% Matriz de rigidez
rsInt = ones(1,2)*2; %*1,*2,*3
[wpg, upg, npg] = gauss(rsInt);

K = sparse(nDofTot,nDofTot); 
for iele = 1:nel
    Ke = zeros(nDofNod*nNodEle);
    nodesEle = nodes(elements(iele,:),:);
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
    
    eleDofs =dof(elements(iele,:),:);
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
nodePosition = nodes + Dplot(:,1:2);


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
    nodesEle = nodes(elements(iele,:),:);
    eleDofs =dof(elements(iele,:),:);
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
    [I,J] = find(elements == inode);
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
    nodesEle = nodes(elements(iele,:),:);
    eleDofs = dof(elements(iele,:),:);
    eleDofs = reshape(eleDofs',[],1);
    NODOSELE=elements(iele,:);
    
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


