function [etaG,eta_el,e2_el,U2_el,A_el] = calc_error(Ele_Type,Nodes,Elements,nEle,C,StrAvgNod,StrGP,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uGP16,nGP16,wGP16)

% eta_el, e2 and U2 Calculation
invC = C\eye(3);
eta_el = zeros(nEle,1);
e2_el = zeros(nEle,1);
U2_el = zeros(nEle,1);
A_el = zeros(nEle,1);

switch Ele_Type
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q4'
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP4        
                ksi = uGP4(iGP,1);
                eta = uGP4(iGP,2); 

                dN = 1/4*[ -(1-eta)   1-eta    1+eta  -(1+eta)
                           -(1-ksi) -(1+ksi)   1+ksi    1-ksi ];  

                Jac = dN*NodEle;
                
                A_el(iEle) = A_el(iEle) + det(Jac);

                N4 = (1-ksi)*(1+eta)/4;
                N3 = (1+ksi)*(1+eta)/4;
                N2 = (1+ksi)*(1-eta)/4;
                N1 = (1-ksi)*(1-eta)/4;

                N = [ N1 N2 N3 N4 ];

                StrEle = squeeze(StrGP(iEle,iGP,1:3));
                
                % Interpolating from the Nodes to the Gaussian Points
                Str_Star = (N*StrAvgNod(Elements(iEle,:),1:3))';

                e2_el(iEle) = e2_el(iEle)+(Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP4(iGP,1)*wGP4(iGP,2)*det(Jac);

                U2_el(iEle) = U2_el(iEle)+StrEle'*invC*StrEle*wGP4(iGP,1)*wGP4(iGP,2)*det(Jac);
            end

            eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle)+U2_el(iEle)));    
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 'Q8'
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP9        
                ksi = uGP9(iGP,1);
                eta = uGP9(iGP,2); 

                dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
                       -((ksi+2*eta)*(ksi-1))/4   -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1) ];

                Jac = dN*NodEle;
                
                A_el(iEle) = A_el(iEle) + det(Jac);

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
                Str_Star = (N*StrAvgNod(Elements(iEle,:),1:3))';

                e2_el(iEle) = e2_el(iEle) + (Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);

                U2_el(iEle) = U2_el(iEle) + StrEle'*invC*StrEle*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);
            end

            eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle) + U2_el(iEle)));    
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 'Q9'
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP9        
                ksi = uGP9(iGP,1);
                eta = uGP9(iGP,2); 

                dN = [ 0.25*eta*(-1+eta)*(2*ksi-1)   0.25*eta*(-1+eta)*(2*ksi+1)   0.25*eta*(1+eta)*(2*ksi+1)   0.25*eta*( 1+eta)*(2*ksi-1)   -ksi*eta*(-1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi+1)   -ksi*eta*(1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi-1)   2*ksi*(-1+eta)*(1+eta)
                       0.25*ksi*(-1+2*eta)*(ksi-1)   0.25*ksi*(-1+2*eta)*(1+ksi)   0.25*ksi*(2*eta+1)*(1+ksi)   0.25*ksi*(2*eta+1)*(ksi-1)    -0.5*(ksi-1)*(1+ksi)*(-1+2*eta)   -ksi*eta*(1+ksi)                  -0.5*(ksi-1)*(1+ksi)*(2*eta+1)   -ksi*eta*(ksi-1)                  2*(ksi-1)*(1+ksi)*eta  ];

                Jac = dN*NodEle;
                
                A_el(iEle) = A_el(iEle) + det(Jac);

                N9 =      (1 - ksi^2)*(1 - eta^2);        
                N8 = 0.50*(1 - ksi  )*(1 - eta^2) - 0.5*N9;
                N7 = 0.50*(1 - ksi^2)*(1 + eta  ) - 0.5*N9;
                N6 = 0.50*(1 + ksi  )*(1 - eta^2) - 0.5*N9;
                N5 = 0.50*(1 - ksi^2)*(1 - eta  ) - 0.5*N9;
                N4 = 0.25*(1 - ksi  )*(1 + eta  ) - 0.5*(N7 + N8 + 0.5*N9);
                N3 = 0.25*(1 + ksi  )*(1 + eta  ) - 0.5*(N6 + N7 + 0.5*N9);
                N2 = 0.25*(1 + ksi  )*(1 - eta  ) - 0.5*(N5 + N6 + 0.5*N9);
                N1 = 0.25*(1 - ksi  )*(1 - eta  ) - 0.5*(N5 + N8 + 0.5*N9);

                N = [ N1 N2 N3 N4 N5 N6 N7 N8 N9 ];

                StrEle = squeeze(StrGP(iEle,iGP,1:3));
                Str_Star = (N*StrAvgNod(Elements(iEle,:),1:3))';

                e2_el(iEle) = e2_el(iEle) + (Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);

                U2_el(iEle) = U2_el(iEle) + StrEle'*invC*StrEle*wGP9(iGP,1)*wGP9(iGP,2)*det(Jac);
            end

            eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle) + U2_el(iEle)));    
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 'Q12'
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP16        
                ksi = uGP16(iGP,1);
                eta = uGP16(iGP,2); 

                dN = [ (9*eta^3)/32 - (9*eta^2)/32 + (27*eta*ksi^2)/32 - (9*eta*ksi)/16 - (5*eta)/16 - (27*ksi^2)/32 + (9*ksi)/16 + 5/16, - (9*eta^3)/32 + (9*eta^2)/32 - (27*eta*ksi^2)/32 - (9*eta*ksi)/16 + (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16, (9*eta^3)/32 + (9*eta^2)/32 + (27*eta*ksi^2)/32 + (9*eta*ksi)/16 - (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16,   (5*eta)/16 + (9*ksi)/16 + (9*eta*ksi)/16 - (27*eta*ksi^2)/32 - (9*eta^2)/32 - (9*eta^3)/32 - (27*ksi^2)/32 + 5/16, (27*eta)/32 - (9*ksi)/16 + (9*eta*ksi)/16 - (81*eta*ksi^2)/32 + (81*ksi^2)/32 - 27/32,                                     (27*eta^3)/32 - (9*eta^2)/32 - (27*eta)/32 + 9/32, (27*eta)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta^3)/32 + (9*eta^2)/32 - (27*eta)/32 - 9/32, (9*eta*ksi)/16 - (9*ksi)/16 - (27*eta)/32 + (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32, (81*eta*ksi^2)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (27*eta)/32 + (81*ksi^2)/32 - 27/32,                                   - (27*eta^3)/32 + (9*eta^2)/32 + (27*eta)/32 - 9/32
                       (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 - (9*ksi^2)/32 - (5*ksi)/16 + 5/16,   (9*eta)/16 + (5*ksi)/16 + (9*eta*ksi)/16 - (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*ksi^2)/32 - (9*ksi^3)/32 + 5/16, (27*eta^2*ksi)/32 + (27*eta^2)/32 + (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16, - (27*eta^2*ksi)/32 + (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16,                                   - (27*ksi^3)/32 + (9*ksi^2)/32 + (27*ksi)/32 - 9/32, (81*eta^2*ksi)/32 - (27*ksi)/32 - (9*eta*ksi)/16 - (9*eta)/16 + (81*eta^2)/32 - 27/32,                                     (27*ksi)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32, (9*eta*ksi)/16 - (27*ksi)/32 - (9*eta)/16 + (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 + (9*ksi^2)/32 - (27*ksi)/32 - 9/32, (27*ksi)/32 - (9*eta)/16 - (9*eta*ksi)/16 - (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi)/32 + 9/32, (27*ksi)/32 - (9*eta)/16 + (9*eta*ksi)/16 - (81*eta^2*ksi)/32 + (81*eta^2)/32 - 27/32 ];

                Jac = dN*NodEle;
                
                A_el(iEle) = A_el(iEle) + det(Jac);

                N1 =   (9*eta^3*ksi)/32 - (9*eta^3)/32 - (9*eta^2*ksi)/32 + (9*eta^2)/32 + (9*eta*ksi^3)/32 - (9*eta*ksi^2)/32 - (5*eta*ksi)/16 + (5*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16;
                N2 = - (9*eta^3*ksi)/32 - (9*eta^3)/32 + (9*eta^2*ksi)/32 + (9*eta^2)/32 - (9*eta*ksi^3)/32 - (9*eta*ksi^2)/32 + (5*eta*ksi)/16 + (5*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16;
                N3 =   (9*eta^3*ksi)/32 + (9*eta^3)/32 + (9*eta^2*ksi)/32 + (9*eta^2)/32 + (9*eta*ksi^3)/32 + (9*eta*ksi^2)/32 - (5*eta*ksi)/16 - (5*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16;
                N4 = - (9*eta^3*ksi)/32 + (9*eta^3)/32 - (9*eta^2*ksi)/32 + (9*eta^2)/32 - (9*eta*ksi^3)/32 + (9*eta*ksi^2)/32 + (5*eta*ksi)/16 - (5*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16;
                N5 =   (27*eta*ksi)/32 - (27*ksi)/32 - (9*eta)/32 + (9*eta*ksi^2)/32 - (27*eta*ksi^3)/32 - (9*ksi^2)/32 + (27*ksi^3)/32 + 9/32;
                N6 =   (9*ksi)/32 - (27*eta)/32 - (27*eta*ksi)/32 - (9*eta^2*ksi)/32 + (27*eta^3*ksi)/32 - (9*eta^2)/32 + (27*eta^3)/32 + 9/32;
                N7 =   (9*eta)/32 + (27*ksi)/32 + (27*eta*ksi)/32 - (9*eta*ksi^2)/32 - (27*eta*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32;
                N8 =   (27*eta)/32 - (9*ksi)/32 - (27*eta*ksi)/32 + (9*eta^2*ksi)/32 + (27*eta^3*ksi)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32;
                N9 =   (27*ksi)/32 - (9*eta)/32 - (27*eta*ksi)/32 + (9*eta*ksi^2)/32 + (27*eta*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32;
                N10 =  (27*eta)/32 + (9*ksi)/32 + (27*eta*ksi)/32 - (9*eta^2*ksi)/32 - (27*eta^3*ksi)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32;
                N11 =  (9*eta)/32 - (27*ksi)/32 - (27*eta*ksi)/32 - (9*eta*ksi^2)/32 + (27*eta*ksi^3)/32 - (9*ksi^2)/32 + (27*ksi^3)/32 + 9/32;
                N12 =  (27*eta*ksi)/32 - (9*ksi)/32 - (27*eta)/32 + (9*eta^2*ksi)/32 - (27*eta^3*ksi)/32 - (9*eta^2)/32 + (27*eta^3)/32 + 9/32;

                N = [ N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 ];

                StrEle = squeeze(StrGP(iEle,iGP,1:3));
                Str_Star = (N*StrAvgNod(Elements(iEle,:),1:3))';

                e2_el(iEle) = e2_el(iEle) + (Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac);

                U2_el(iEle) = U2_el(iEle) + StrEle'*invC*StrEle*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac);
            end

            eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle) + U2_el(iEle)));    
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    case 'Q16'
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP16        
                ksi = uGP16(iGP,1);
                eta = uGP16(iGP,2); 

                dN = [ (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 - (27*eta*ksi^2)/256 + (9*eta*ksi)/128 + eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256, - (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 + (27*eta*ksi^2)/256 + (9*eta*ksi)/128 - eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 - (27*eta*ksi^2)/256 - (9*eta*ksi)/128 + eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, - (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 + (27*eta*ksi^2)/256 - (9*eta*ksi)/128 - eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256,   - (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 + (81*eta*ksi^2)/256 - (9*eta*ksi)/128 - (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 - (729*eta*ksi^2)/256 - (243*eta*ksi)/128 + (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   - (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 + (81*eta*ksi^2)/256 + (9*eta*ksi)/128 - (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 - (729*eta*ksi^2)/256 + (243*eta*ksi)/128 + (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256,   (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 - (81*eta*ksi^2)/256 - (9*eta*ksi)/128 + (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, - (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 + (729*eta*ksi^2)/256 + (243*eta*ksi)/128 - (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 - (81*eta*ksi^2)/256 + (9*eta*ksi)/128 + (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, - (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 + (729*eta*ksi^2)/256 - (243*eta*ksi)/128 - (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256, (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 - (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 + (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256, - (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 + (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 - (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 - (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 + (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, - (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 + (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 - (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256
                       (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 + (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 + (9*ksi^2)/256 + ksi/256 - 1/256, - (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 + (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 + (9*ksi^2)/256 - ksi/256 - 1/256, (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 - (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, - (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 - (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 - (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 - (9*ksi^2)/256 - (27*ksi)/256 + 9/256,   (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 - (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 - (243*ksi^2)/256 + (27*ksi)/256 + 27/256, - (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 + (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256,   (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 + (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 + (243*ksi^2)/256 + (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 - (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 - (9*ksi^2)/256 + (27*ksi)/256 + 9/256,   - (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 + (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 + (243*ksi^2)/256 - (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 + (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256,   - (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 - (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 - (243*ksi^2)/256 - (27*ksi)/256 + 27/256, (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 + (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 + (243*ksi^2)/256 + (729*ksi)/256 - 243/256, - (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 + (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 + (243*ksi^2)/256 - (729*ksi)/256 - 243/256, (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 - (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 - (243*ksi^2)/256 + (729*ksi)/256 + 243/256, - (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 - (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 - (243*ksi^2)/256 - (729*ksi)/256 + 243/256];

                Jac = dN*NodEle;
                
                A_el(iEle) = A_el(iEle) + det(Jac);

                % N = [ (81*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 - (9*eta^3*ksi)/256 + (9*eta^3)/256 - (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 - (9*eta^2)/256 - (9*eta*ksi^3)/256 + (9*eta*ksi^2)/256 + (eta*ksi)/256 - eta/256 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (81*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 + (9*eta^3*ksi)/256 + (9*eta^3)/256 + (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 - (9*eta^2)/256 + (9*eta*ksi^3)/256 + (9*eta*ksi^2)/256 - (eta*ksi)/256 - eta/256 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, (81*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 - (9*eta^3*ksi)/256 - (9*eta^3)/256 + (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 - (9*eta^2)/256 - (9*eta*ksi^3)/256 - (9*eta*ksi^2)/256 + (eta*ksi)/256 + eta/256 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, - (81*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 + (9*eta^3*ksi)/256 - (9*eta^3)/256 - (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 - (9*eta^2)/256 + (9*eta*ksi^3)/256 - (9*eta*ksi^2)/256 - (eta*ksi)/256 + eta/256 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (243*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 + (243*eta^3*ksi)/256 - (81*eta^3)/256 + (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 + (81*eta^2)/256 + (27*eta*ksi^3)/256 - (9*eta*ksi^2)/256 - (27*eta*ksi)/256 + (9*eta)/256 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256, (243*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 - (27*eta^3*ksi)/256 - (27*eta^3)/256 - (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 + (9*eta^2)/256 - (243*eta*ksi^3)/256 - (243*eta*ksi^2)/256 + (27*eta*ksi)/256 + (27*eta)/256 + (81*ksi^3)/256 + (81*ksi^2)/256 - (9*ksi)/256 - 9/256, - (243*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 + (243*eta^3*ksi)/256 + (81*eta^3)/256 - (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 + (81*eta^2)/256 + (27*eta*ksi^3)/256 + (9*eta*ksi^2)/256 - (27*eta*ksi)/256 - (9*eta)/256 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256, (243*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 - (27*eta^3*ksi)/256 + (27*eta^3)/256 + (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 + (9*eta^2)/256 - (243*eta*ksi^3)/256 + (243*eta*ksi^2)/256 + (27*eta*ksi)/256 - (27*eta)/256 - (81*ksi^3)/256 + (81*ksi^2)/256 + (9*ksi)/256 - 9/256, (243*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 - (243*eta^3*ksi)/256 - (81*eta^3)/256 - (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 + (81*eta^2)/256 - (27*eta*ksi^3)/256 - (9*eta*ksi^2)/256 + (27*eta*ksi)/256 + (9*eta)/256 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256, - (243*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 + (27*eta^3*ksi)/256 + (27*eta^3)/256 - (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 + (9*eta^2)/256 + (243*eta*ksi^3)/256 + (243*eta*ksi^2)/256 - (27*eta*ksi)/256 - (27*eta)/256 + (81*ksi^3)/256 + (81*ksi^2)/256 - (9*ksi)/256 - 9/256, (243*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 - (243*eta^3*ksi)/256 + (81*eta^3)/256 + (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 + (81*eta^2)/256 - (27*eta*ksi^3)/256 + (9*eta*ksi^2)/256 + (27*eta*ksi)/256 - (9*eta)/256 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256, - (243*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 + (27*eta^3*ksi)/256 - (27*eta^3)/256 + (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 + (9*eta^2)/256 + (243*eta*ksi^3)/256 - (243*eta*ksi^2)/256 - (27*eta*ksi)/256 + (27*eta)/256 - (81*ksi^3)/256 + (81*ksi^2)/256 + (9*ksi)/256 - 9/256, (729*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 - (729*eta^3*ksi)/256 + (243*eta^3)/256 - (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 - (81*eta^2)/256 - (729*eta*ksi^3)/256 + (243*eta*ksi^2)/256 + (729*eta*ksi)/256 - (243*eta)/256 + (243*ksi^3)/256 - (81*ksi^2)/256 - (243*ksi)/256 + 81/256, - (729*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 + (729*eta^3*ksi)/256 + (243*eta^3)/256 + (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 - (81*eta^2)/256 + (729*eta*ksi^3)/256 + (243*eta*ksi^2)/256 - (729*eta*ksi)/256 - (243*eta)/256 - (243*ksi^3)/256 - (81*ksi^2)/256 + (243*ksi)/256 + 81/256, (729*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 - (729*eta^3*ksi)/256 - (243*eta^3)/256 + (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 - (81*eta^2)/256 - (729*eta*ksi^3)/256 - (243*eta*ksi^2)/256 + (729*eta*ksi)/256 + (243*eta)/256 - (243*ksi^3)/256 - (81*ksi^2)/256 + (243*ksi)/256 + 81/256, - (729*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 + (729*eta^3*ksi)/256 - (243*eta^3)/256 - (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 - (81*eta^2)/256 + (729*eta*ksi^3)/256 - (243*eta*ksi^2)/256 - (729*eta*ksi)/256 + (243*eta)/256 + (243*ksi^3)/256 - (81*ksi^2)/256 - (243*ksi)/256 + 81/256];
                
                N1  =   (81*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 - (9*eta^3*ksi)/256 + (9*eta^3)/256 - (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 - (9*eta^2)/256 - (9*eta*ksi^3)/256 + (9*eta*ksi^2)/256 + (eta*ksi)/256 - eta/256 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256;
                N2  = - (81*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 + (9*eta^3*ksi)/256 + (9*eta^3)/256 + (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 - (9*eta^2)/256 + (9*eta*ksi^3)/256 + (9*eta*ksi^2)/256 - (eta*ksi)/256 - eta/256 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256;
                N3  =   (81*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 - (9*eta^3*ksi)/256 - (9*eta^3)/256 + (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 - (9*eta^2)/256 - (9*eta*ksi^3)/256 - (9*eta*ksi^2)/256 + (eta*ksi)/256 + eta/256 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256;
                N4  = - (81*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 + (9*eta^3*ksi)/256 - (9*eta^3)/256 - (81*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 - (9*eta^2)/256 + (9*eta*ksi^3)/256 - (9*eta*ksi^2)/256 - (eta*ksi)/256 + eta/256 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256;
                N5  = - (243*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 + (243*eta^3*ksi)/256 - (81*eta^3)/256 + (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 + (81*eta^2)/256 + (27*eta*ksi^3)/256 - (9*eta*ksi^2)/256 - (27*eta*ksi)/256 + (9*eta)/256 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256;
                N6  =   (243*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 - (27*eta^3*ksi)/256 - (27*eta^3)/256 - (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 + (9*eta^2)/256 - (243*eta*ksi^3)/256 - (243*eta*ksi^2)/256 + (27*eta*ksi)/256 + (27*eta)/256 + (81*ksi^3)/256 + (81*ksi^2)/256 - (9*ksi)/256 - 9/256;
                N7  = - (243*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 + (243*eta^3*ksi)/256 + (81*eta^3)/256 - (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 + (81*eta^2)/256 + (27*eta*ksi^3)/256 + (9*eta*ksi^2)/256 - (27*eta*ksi)/256 - (9*eta)/256 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256;
                N8  =   (243*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 - (27*eta^3*ksi)/256 + (27*eta^3)/256 + (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 + (9*eta^2)/256 - (243*eta*ksi^3)/256 + (243*eta*ksi^2)/256 + (27*eta*ksi)/256 - (27*eta)/256 - (81*ksi^3)/256 + (81*ksi^2)/256 + (9*ksi)/256 - 9/256;
                N9  =   (243*eta^3*ksi^3)/256 + (81*eta^3*ksi^2)/256 - (243*eta^3*ksi)/256 - (81*eta^3)/256 - (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 + (81*eta^2)/256 - (27*eta*ksi^3)/256 - (9*eta*ksi^2)/256 + (27*eta*ksi)/256 + (9*eta)/256 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256;
                N10 = - (243*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 + (27*eta^3*ksi)/256 + (27*eta^3)/256 - (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 + (9*eta^2*ksi)/256 + (9*eta^2)/256 + (243*eta*ksi^3)/256 + (243*eta*ksi^2)/256 - (27*eta*ksi)/256 - (27*eta)/256 + (81*ksi^3)/256 + (81*ksi^2)/256 - (9*ksi)/256 - 9/256;
                N11 =   (243*eta^3*ksi^3)/256 - (81*eta^3*ksi^2)/256 - (243*eta^3*ksi)/256 + (81*eta^3)/256 + (243*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 + (81*eta^2)/256 - (27*eta*ksi^3)/256 + (9*eta*ksi^2)/256 + (27*eta*ksi)/256 - (9*eta)/256 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256;
                N12 = - (243*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 + (27*eta^3*ksi)/256 - (27*eta^3)/256 + (81*eta^2*ksi^3)/256 - (81*eta^2*ksi^2)/256 - (9*eta^2*ksi)/256 + (9*eta^2)/256 + (243*eta*ksi^3)/256 - (243*eta*ksi^2)/256 - (27*eta*ksi)/256 + (27*eta)/256 - (81*ksi^3)/256 + (81*ksi^2)/256 + (9*ksi)/256 - 9/256;
                N13 =   (729*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 - (729*eta^3*ksi)/256 + (243*eta^3)/256 - (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 - (81*eta^2)/256 - (729*eta*ksi^3)/256 + (243*eta*ksi^2)/256 + (729*eta*ksi)/256 - (243*eta)/256 + (243*ksi^3)/256 - (81*ksi^2)/256 - (243*ksi)/256 + 81/256;
                N14 = - (729*eta^3*ksi^3)/256 - (243*eta^3*ksi^2)/256 + (729*eta^3*ksi)/256 + (243*eta^3)/256 + (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 - (81*eta^2)/256 + (729*eta*ksi^3)/256 + (243*eta*ksi^2)/256 - (729*eta*ksi)/256 - (243*eta)/256 - (243*ksi^3)/256 - (81*ksi^2)/256 + (243*ksi)/256 + 81/256;
                N15 =   (729*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 - (729*eta^3*ksi)/256 - (243*eta^3)/256 + (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 - (243*eta^2*ksi)/256 - (81*eta^2)/256 - (729*eta*ksi^3)/256 - (243*eta*ksi^2)/256 + (729*eta*ksi)/256 + (243*eta)/256 - (243*ksi^3)/256 - (81*ksi^2)/256 + (243*ksi)/256 + 81/256;
                N16 = - (729*eta^3*ksi^3)/256 + (243*eta^3*ksi^2)/256 + (729*eta^3*ksi)/256 - (243*eta^3)/256 - (243*eta^2*ksi^3)/256 + (81*eta^2*ksi^2)/256 + (243*eta^2*ksi)/256 - (81*eta^2)/256 + (729*eta*ksi^3)/256 - (243*eta*ksi^2)/256 - (729*eta*ksi)/256 + (243*eta)/256 + (243*ksi^3)/256 - (81*ksi^2)/256 - (243*ksi)/256 + 81/256;

                N = [ N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 ];
                
                StrEle = squeeze(StrGP(iEle,iGP,1:3));
                Str_Star = (N*StrAvgNod(Elements(iEle,:),1:3))';

                e2_el(iEle) = e2_el(iEle) + (Str_Star-StrEle)'*invC*(Str_Star-StrEle)*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac);

                U2_el(iEle) = U2_el(iEle) + StrEle'*invC*StrEle*wGP16(iGP,1)*wGP16(iGP,2)*det(Jac);
            end

            eta_el(iEle) = sqrt(e2_el(iEle)/(e2_el(iEle) + U2_el(iEle)));    
        end
        
end

% etaG Calculation
etaG = sqrt(sum(e2_el)/(sum(e2_el) + sum(U2_el)));

disp('Error CALCULATED')