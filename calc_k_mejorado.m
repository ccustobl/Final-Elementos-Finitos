function K = calc_k_mejorado(Ele_Type,Nodes,Elements,C,t,nEle,nNodEle,EleDofs,nDofNod,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16)

%% Stiffness Matrix

A = cell(3,nEle);
for iEle = 1:nEle
    Ke = zeros(nDofNod*nNodEle);
    NodEle = Nodes(Elements(iEle,:),:);
    
    switch Ele_Type
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 'Q4'
            for iGP = 1:nGP4
                ksi = uGP4(iGP,1);
                eta = uGP4(iGP,2);

                dN = 1/4*[ -(1-eta)   1-eta    1+eta  -(1+eta)
                           -(1-ksi) -(1+ksi)   1+ksi    1-ksi ];

                Jac = dN*NodEle;
                dNxy = Jac\dN;

                B = zeros(size(C,2),nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

                Ke = B'*C*B*wGP4(iGP,1)*wGP4(iGP,2)*det(Jac)*t+Ke;                
            end
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 'Q8'
            for iGP = 1:nGP9
                ksi = uGP9(iGP,1);
                eta = uGP9(iGP,2);

                dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
                       -((ksi+2*eta)*(ksi-1))/4   -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1)];

                Jac = dN*NodEle;
                dNxy = Jac\dN;

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);

                Ke = B'*C*B*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac)*t+Ke;
            end
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 'Q9'
            for iGP = 1:nGP9
                ksi = uGP9(iGP,1);
                eta = uGP9(iGP,2);

                dN = [ 0.25*eta*(-1+eta)*(2*ksi-1)   0.25*eta*(-1+eta)*(2*ksi+1)   0.25*eta*(1+eta)*(2*ksi+1)   0.25*eta*( 1+eta)*(2*ksi-1)   -ksi*eta*(-1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi+1)   -ksi*eta*(1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi-1)   2*ksi*(-1+eta)*(1+eta)
                       0.25*ksi*(-1+2*eta)*(ksi-1)   0.25*ksi*(-1+2*eta)*(1+ksi)   0.25*ksi*(2*eta+1)*(1+ksi)   0.25*ksi*(2*eta+1)*(ksi-1)    -0.5*(ksi-1)*(1+ksi)*(-1+2*eta)   -ksi*eta*(1+ksi)                  -0.5*(ksi-1)*(1+ksi)*(2*eta+1)   -ksi*eta*(ksi-1)                  2*(ksi-1)*(1+ksi)*eta  ];

                Jac = dN*NodEle;
                dNxy = Jac\dN;

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);

                Ke = B'*C*B*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac)*t+Ke;
            end
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 'Q12'
            for iGP = 1:nGP16
                ksi = uGP16(iGP,1);
                eta = uGP16(iGP,2);

                dN = [ (9*eta^3)/32 - (9*eta^2)/32 + (27*eta*ksi^2)/32 - (9*eta*ksi)/16 - (5*eta)/16 - (27*ksi^2)/32 + (9*ksi)/16 + 5/16, - (9*eta^3)/32 + (9*eta^2)/32 - (27*eta*ksi^2)/32 - (9*eta*ksi)/16 + (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16, (9*eta^3)/32 + (9*eta^2)/32 + (27*eta*ksi^2)/32 + (9*eta*ksi)/16 - (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16,   (5*eta)/16 + (9*ksi)/16 + (9*eta*ksi)/16 - (27*eta*ksi^2)/32 - (9*eta^2)/32 - (9*eta^3)/32 - (27*ksi^2)/32 + 5/16, (27*eta)/32 - (9*ksi)/16 + (9*eta*ksi)/16 - (81*eta*ksi^2)/32 + (81*ksi^2)/32 - 27/32,                                     (27*eta^3)/32 - (9*eta^2)/32 - (27*eta)/32 + 9/32, (27*eta)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta^3)/32 + (9*eta^2)/32 - (27*eta)/32 - 9/32, (9*eta*ksi)/16 - (9*ksi)/16 - (27*eta)/32 + (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32, (81*eta*ksi^2)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (27*eta)/32 + (81*ksi^2)/32 - 27/32,                                   - (27*eta^3)/32 + (9*eta^2)/32 + (27*eta)/32 - 9/32
                       (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 - (9*ksi^2)/32 - (5*ksi)/16 + 5/16,   (9*eta)/16 + (5*ksi)/16 + (9*eta*ksi)/16 - (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*ksi^2)/32 - (9*ksi^3)/32 + 5/16, (27*eta^2*ksi)/32 + (27*eta^2)/32 + (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16, - (27*eta^2*ksi)/32 + (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16,                                   - (27*ksi^3)/32 + (9*ksi^2)/32 + (27*ksi)/32 - 9/32, (81*eta^2*ksi)/32 - (27*ksi)/32 - (9*eta*ksi)/16 - (9*eta)/16 + (81*eta^2)/32 - 27/32,                                     (27*ksi)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32, (9*eta*ksi)/16 - (27*ksi)/32 - (9*eta)/16 + (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 + (9*ksi^2)/32 - (27*ksi)/32 - 9/32, (27*ksi)/32 - (9*eta)/16 - (9*eta*ksi)/16 - (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi)/32 + 9/32, (27*ksi)/32 - (9*eta)/16 + (9*eta*ksi)/16 - (81*eta^2*ksi)/32 + (81*eta^2)/32 - 27/32 ];

                Jac = dN*NodEle;
                dNxy = Jac\dN;

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);

                Ke = B'*C*B*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac)*t+Ke;
            end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        case 'Q16'
            for iGP = 1:nGP16
                ksi = uGP16(iGP,1);
                eta = uGP16(iGP,2);

                dN = [ (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 - (27*eta*ksi^2)/256 + (9*eta*ksi)/128 + eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256, - (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 + (27*eta*ksi^2)/256 + (9*eta*ksi)/128 - eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 - (27*eta*ksi^2)/256 - (9*eta*ksi)/128 + eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, - (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 + (27*eta*ksi^2)/256 - (9*eta*ksi)/128 - eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256,   - (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 + (81*eta*ksi^2)/256 - (9*eta*ksi)/128 - (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 - (729*eta*ksi^2)/256 - (243*eta*ksi)/128 + (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   - (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 + (81*eta*ksi^2)/256 + (9*eta*ksi)/128 - (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 - (729*eta*ksi^2)/256 + (243*eta*ksi)/128 + (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256,   (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 - (81*eta*ksi^2)/256 - (9*eta*ksi)/128 + (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, - (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 + (729*eta*ksi^2)/256 + (243*eta*ksi)/128 - (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 - (81*eta*ksi^2)/256 + (9*eta*ksi)/128 + (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, - (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 + (729*eta*ksi^2)/256 - (243*eta*ksi)/128 - (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256, (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 - (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 + (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256, - (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 + (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 - (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 - (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 + (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, - (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 + (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 - (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256
                       (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 + (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 + (9*ksi^2)/256 + ksi/256 - 1/256, - (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 + (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 + (9*ksi^2)/256 - ksi/256 - 1/256, (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 - (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, - (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 - (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 - (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 - (9*ksi^2)/256 - (27*ksi)/256 + 9/256,   (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 - (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 - (243*ksi^2)/256 + (27*ksi)/256 + 27/256, - (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 + (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256,   (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 + (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 + (243*ksi^2)/256 + (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 - (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 - (9*ksi^2)/256 + (27*ksi)/256 + 9/256,   - (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 + (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 + (243*ksi^2)/256 - (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 + (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256,   - (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 - (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 - (243*ksi^2)/256 - (27*ksi)/256 + 27/256, (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 + (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 + (243*ksi^2)/256 + (729*ksi)/256 - 243/256, - (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 + (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 + (243*ksi^2)/256 - (729*ksi)/256 - 243/256, (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 - (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 - (243*ksi^2)/256 + (729*ksi)/256 + 243/256, - (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 - (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 - (243*ksi^2)/256 - (729*ksi)/256 + 243/256];       
                Jac = dN*NodEle;
                dNxy = Jac\dN;

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);

                Ke = B'*C*B*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac)*t+Ke;
            end            
    end
   
    I = repmat(EleDofs(iEle,:)',1,nDofNod*nNodEle);
    J = repmat(EleDofs(iEle,:),nDofNod*nNodEle,1);
    A{1,iEle} = I;
    A{2,iEle} = J;
    A{3,iEle} = Ke;    
   
end

I = vertcat(A{1,:});
J = vertcat(A{2,:});
S = vertcat(A{3,:});
K = sparse(I,J,S);

disp('Stiffness Matrix CALCULATED')

