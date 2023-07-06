%% Parameters in Q8

% Parameters
nDofNod = 2;
nNodEle = 8;      

% Gauss' Parameters

% Sub (4 GP)
a4 = 1/sqrt(3);
uGP4 = [ -a4 -a4 ; a4 -a4 ; a4 a4 ; -a4 a4 ];
nGP4 = size(uGP4,1);
wGP4 = ones(nGP4,2);

% Full (9 GP)
a9 = sqrt(0.6);
uGP9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0];
nGP9 = size(uGP9,1);
w1 = 5/9;
w2 = 8/9;
wGP9 = [ w1 w1 ; w1 w1 ; w1 w1 ; w1 w1 ; w2 w1 ; w1 w2 ; w2 w1 ; w1 w2 ; w2 w2 ];


%% Stress in Q8

% In the Gaussian Points
StrGP = zeros(nEle,nNodEle,4);
for iEle = 1:nEle
    NodEle = Nodes(Elements(iEle,:),:);

    for iGP = 1:nGP9   
        ksi = uGP9(iGP,1);
        eta = uGP9(iGP,2);  

        dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
               -((ksi+2*eta)*(ksi-1))/4  -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1) ];

        Jac = dN*NodEle;
        dNxy = Jac\dN;

        B = zeros(3,nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

        StrGP(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
        StrGP(iEle,iGP,4) = sqrt(StrGP(iEle,iGP,1)^2+StrGP(iEle,iGP,2)^2-StrGP(iEle,iGP,1)*StrGP(iEle,iGP,2)+3*StrGP(iEle,iGP,3)^2);
    end
end

% In the Super-Convergent Points
StrSC = zeros(nEle,nGP4,4);
for iEle = 1:nEle
    NodEle = Nodes(Elements(iEle,:),:);

    for iGP = 1:nGP4   
        ksi = uGP4(iGP,1);
        eta = uGP4(iGP,2);  

        dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
               -((ksi+2*eta)*(ksi-1))/4   -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1) ];

        Jac = dN*NodEle;                      

        dNxy = Jac\dN;          

        B = zeros(size(C,2),nDofNod*nNodEle);
        B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
        B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
        B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

        StrSC(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
        StrSC(iEle,iGP,4) = sqrt(StrSC(iEle,iGP,1)^2+StrSC(iEle,iGP,2)^2-StrSC(iEle,iGP,1)*StrSC(iEle,iGP,2)+3*StrSC(iEle,iGP,3)^2);
    end
end

% Extrapolating to the Nodes
a = 1;
rsExt = sqrt(3)*[ -a -a ; a -a ; a a ; -a a ; 0 -a ;  a 0 ; 0 a ; -a 0  ];
StrSCNod = zeros(nEle,nNodEle,4);
for iEle = 1:nEle
    for iNod = 1:nNodEle
        r = rsExt(iNod,1);
        s = rsExt(iNod,2);

        N1 = (1-r)*(1-s)/4;
        N2 = (1+r)*(1-s)/4;
        N3 = (1+r)*(1+s)/4;
        N4 = (1-r)*(1+s)/4;

        N = [N1 N2 N3 N4];

        StrSCNod(iEle,iNod,:) = N*squeeze(StrSC(iEle,:,:));
    end
end


%% Error ZZ in Q8

for iEle = 1:nEle
    NodEle = Nodes(Elements(iEle,:),:);

    for iGP = 1:nGP9        
        ksi = uGP9(iGP,1);
        eta = uGP9(iGP,2); 

        dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
               -((ksi+2*eta)*(ksi-1))/4   -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1) ];

        Jac = dN*NodEle;

        N8 = 0.50*(1 - ksi  )*(1 - eta^2);
        N7 = 0.50*(1 - ksi^2)*(1 + eta  );
        N6 = 0.50*(1 + ksi  )*(1 - eta^2);
        N5 = 0.50*(1 - ksi^2)*(1 - eta  );
        N4 = 0.25*(1 - ksi  )*(1 + eta  ) - 0.5*(N7 + N8);
        N3 = 0.25*(1 + ksi  )*(1 + eta  ) - 0.5*(N6 + N7);
        N2 = 0.25*(1 + ksi  )*(1 - eta  ) - 0.5*(N5 + N6);
        N1 = 0.25*(1 - ksi  )*(1 - eta  ) - 0.5*(N5 + N8);

        N = [ N1 N2 N3 N4 N5 N6 N7 N8 ];

        StrEle = squeeze(StrGP(iEle,iGP,1:3));
        Str_Star = (N*StrAvg(Elements(iEle,:),1:3))';

        e2_el(iEle) = e2_el(iEle) + (Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);

        U2_el(iEle) = U2_el(iEle) + StrEle'*invC*StrEle*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);
    end

    eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle) + U2_el(iEle)));    
end
