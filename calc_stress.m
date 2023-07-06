function [StrAvgNod,StrGP,StrNod,StrAvgGP] = calc_stress(Ele_Type,Nodes,Elements,C,De,EleDofs,nEle,nNodEle,nNod,nDofNod,uGP1,nGP1,uGP4,nGP4,uGP9,nGP9,uBP9,nBP9,uGP16,nGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16)

% StrGP = 0; % Borrar esta variable cuando se necesite StrGP
StrNod = 0; % Borrar esta variable cuando se necesite StrNod
StrAvgGP = 0; % Borrar esta variable cuando se necesite StrAvgGP

switch Ele_Type
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q4'        
        % In the Gaussian Points
        StrGP = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP4   
                ksi = uGP4(iGP,1);
                eta = uGP4(iGP,2);  

                dN = 1/4*[ -(1-eta)   1-eta   1+eta  -(1+eta)
                           -(1-ksi) -(1+ksi)  1+ksi    1-ksi ];

                Jac = dN*NodEle;                      

                dNxy = Jac\dN;  

                B = zeros(size(C,2),nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

                StrGP(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
                StrGP(iEle,iGP,4) = sqrt(StrGP(iEle,iGP,1)^2+StrGP(iEle,iGP,2)^2-StrGP(iEle,iGP,1)*StrGP(iEle,iGP,2)+3*StrGP(iEle,iGP,3)^2);
            end
        end
        
        % In the Nodes
%         StrNod = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             NodEle = Nodes(Elements(iEle,:),:);
% 
%             for iNod = 1:nNod4   
%                 ksi = uNod4(iNod,1);
%                 eta = uNod4(iNod,2);  
% 
%                 dN = 1/4*[ -(1-eta)   1-eta   1+eta  -(1+eta)
%                            -(1-ksi) -(1+ksi)  1+ksi    1-ksi ];
% 
%                 Jac = dN*NodEle;                      
% 
%                 dNxy = Jac\dN;  
% 
%                 B = zeros(size(C,2),nDofNod*nNodEle);
%                 B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
%                 B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
% 
%                 StrNod(iEle,iNod,1:3) = C*B*De(EleDofs(iEle,:));
%                 StrNod(iEle,iNod,4) = sqrt(StrNod(iEle,iNod,1)^2+StrNod(iEle,iNod,2)^2-StrNod(iEle,iNod,1)*StrNod(iEle,iNod,2)+3*StrNod(iEle,iNod,3)^2);
%             end
%         end
        
        % In the Super-Convergent Points
        StrSC = zeros(nEle,nGP1,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP1
                ksi = uGP1(iGP,1);
                eta = uGP1(iGP,2);  

                dN = 1/4*[-(1-eta)   1-eta    1+eta  -(1+eta)
                          -(1-ksi) -(1+ksi)   1+ksi    1-ksi ];  

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
        StrSCNod = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            for iNod = 1:nNodEle

                N = 1;

                StrSCNod(iEle,iNod,:) = N*squeeze(StrSC(iEle,:,:));
            end
        end
        
        % Nodal Average
        StrAvgNod = zeros(nNod,4);
        for iNod = 1:nNod
            [I,J] = find(Elements == iNod);
            nShare = length(I);
            for ishare = 1:nShare
                StrAvgNod(iNod,:) = StrAvgNod(iNod,:) + squeeze(StrSCNod(I(ishare),J(ishare),:))';
            end
            StrAvgNod(iNod,:) = StrAvgNod(iNod,:)/nShare;
        end
        
        % Elemental Average
%         StrAvgNod_Ele = zeros(nEle,nNodEle,4);
%         for iNod = 1:nNod
%             [I,J] = find(Elements == iNod);
%             nShare = length(I);
%             for ishare = 1:nShare
%                 for icol = 1:4
%                     StrAvgNod_Ele(I(ishare),J(ishare),icol) = StrAvgNod_Ele(I(ishare),J(ishare),icol) + StrAvgNod(iNod,icol);
%                 end
%             end
%         end
        
        % Interpolating to the Gaussian Points
%         a = 1/sqrt(3);
%         rsInt = [ -a -a ; a -a ; a a ; -a a ];
%         StrAvgGP = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             for iNod = 1:nNodEle
%                 r = rsInt(iNod,1);
%                 s = rsInt(iNod,2);
% 
%                 N1 = (1-r)*(1-s)/4;
%                 N2 = (1+r)*(1-s)/4;
%                 N3 = (1+r)*(1+s)/4;
%                 N4 = (1-r)*(1+s)/4;
% 
%                 N = [N1 N2 N3 N4];
% 
%                 StrAvgGP(iEle,iNod,:) = N*squeeze(StrAvgNod_Ele(iEle,:,:));
%             end
%         end
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q8'  
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
        
        % In the Nodes
%         StrNod = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             NodEle = Nodes(Elements(iEle,:),:);
% 
%             for iNod = 1:nNod8   
%                 ksi = uNod8(iNod,1);
%                 eta = uNod8(iNod,2);  
% 
%                 dN = [ -((2*ksi+eta)*(eta-1))/4   -((eta-1)*(2*ksi-eta))/4  ((2*ksi+eta)*(eta+1))/4  ((eta+1)*(2*ksi-eta))/4  ksi*(eta-1)  1/2-eta^2/2   -ksi*(eta+1)  eta^2/2-1/2
%                        -((ksi+2*eta)*(ksi-1))/4  -((ksi-2*eta)*(ksi+1))/4  ((ksi+2*eta)*(ksi+1))/4  ((ksi-2*eta)*(ksi-1))/4  ksi^2/2-1/2  -eta*(ksi+1)  1/2-ksi^2/2   eta*(ksi-1) ];
% 
%                 Jac = dN*NodEle;
%                 dNxy = Jac\dN;
% 
%                 B = zeros(3,nDofNod*nNodEle);
%                 B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
%                 B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
% 
%                 StrNod(iEle,iNod,1:3) = C*B*De(EleDofs(iEle,:));
%                 StrNod(iEle,iNod,4) = sqrt(StrNod(iEle,iNod,1)^2+StrNod(iEle,iNod,2)^2-StrNod(iEle,iNod,1)*StrNod(iEle,iNod,2)+3*StrNod(iEle,iNod,3)^2);
%             end
%         end

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
        
        % Nodal Average
        StrAvgNod = zeros(nNod,4);
        for iNod = 1:nNod
            [I,J] = find(Elements == iNod);
            nShare = length(I);
            for ishare = 1:nShare
                StrAvgNod(iNod,:) = StrAvgNod(iNod,:) + squeeze(StrSCNod(I(ishare),J(ishare),:))';
            end
            StrAvgNod(iNod,:) = StrAvgNod(iNod,:)/nShare;
        end
        
        % Elemental Average
%         StrAvgNod_Ele = zeros(nEle,nNodEle,4);
%         for iNod = 1:nNod
%             [I,J] = find(Elements == iNod);
%             nShare = length(I);
%             for ishare = 1:nShare
%                 for icol = 1:4
%                     StrAvgNod_Ele(I(ishare),J(ishare),icol) = StrAvgNod_Ele(I(ishare),J(ishare),icol) + StrAvgNod(iNod,icol);
%                 end
%             end
%         end
        
        % Interpolating to the Gaussian Points
%         a = 1/sqrt(3);
%         rsInt = [ -a -a ; a -a ; a a ; -a a ];
%         StrAvgGP = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             for iNod = 1:nNodEle
%                 r = rsInt(iNod,1);
%                 s = rsInt(iNod,2);
% 
%                 N1 = (1-r)*(1-s)/4;
%                 N2 = (1+r)*(1-s)/4;
%                 N3 = (1+r)*(1+s)/4;
%                 N4 = (1-r)*(1+s)/4;
% 
%                 N = [N1 N2 N3 N4];
% 
%                 StrAvgGP(iEle,iNod,:) = N*squeeze(StrAvgNod_Ele(iEle,:,:));
%             end
%         end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q9' 
        % In the Gaussian Points
        StrGP = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP9   
                ksi = uGP9(iGP,1);
                eta = uGP9(iGP,2);  

                dN = [  0.25*eta*(-1+eta)*(2*ksi-1)		0.25*eta*(-1+eta)*(2*ksi+1)		0.25*eta*(1+eta)*(2*ksi+1)		0.25*eta*( 1+eta)*(2*ksi-1)		-ksi*eta*(-1+eta)					-1/2*(-1+eta)*(1+eta)*(2*ksi+1)		-ksi*eta*(1+eta)					-1/2*(-1+eta)*(1+eta)*(2*ksi-1)		2*ksi*(-1+eta)*(1+eta)
						0.25*ksi*(-1+2*eta)*(ksi-1)		0.25*ksi*(-1+2*eta)*(1+ksi)		0.25*ksi*(2*eta+1)*(1+ksi)		0.25*ksi*(2*eta+1)*(ksi-1)		-0.5*(ksi-1)*(1+ksi)*(-1+2*eta)		-ksi*eta*(1+ksi)                	-0.5*(ksi-1)*(1+ksi)*(2*eta+1)		-ksi*eta*(ksi-1)					2*(ksi-1)*(1+ksi)*eta ];
                
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
        
        % In the Nodes
%         StrNod = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             NodEle = Nodes(Elements(iEle,:),:);
% 
%             for iNod = 1:nNod9   
%                 ksi = uNod9(iNod,1);
%                 eta = uNod9(iNod,2);  
% 
%                 dN = [ 0.25*eta*(-1+eta)*(2*ksi-1)   0.25*eta*(-1+eta)*(2*ksi+1)   0.25*eta*(1+eta)*(2*ksi+1)   0.25*eta*( 1+eta)*(2*ksi-1)   -ksi*eta*(-1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi+1)   -ksi*eta*(1+eta)                 -1/2*(-1+eta)*(1+eta)*(2*ksi-1)   2*ksi*(-1+eta)*(1+eta)
%                        0.25*ksi*(-1+2*eta)*(ksi-1)   0.25*ksi*(-1+2*eta)*(1+ksi)   0.25*ksi*(2*eta+1)*(1+ksi)   0.25*ksi*(2*eta+1)*(ksi-1)    -0.5*(ksi-1)*(1+ksi)*(-1+2*eta)   -ksi*eta*(1+ksi)                  -0.5*(ksi-1)*(1+ksi)*(2*eta+1)   -ksi*eta*(ksi-1)                  2*(ksi-1)*(1+ksi)*eta  ];
% 
%                 Jac = dN*NodEle;
%                 dNxy = Jac\dN;
% 
%                 B = zeros(3,nDofNod*nNodEle);
%                 B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
%                 B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
% 
%                 StrNod(iEle,iNod,1:3) = C*B*De(EleDofs(iEle,:));
%                 StrNod(iEle,iNod,4) = sqrt(StrNod(iEle,iNod,1)^2+StrNod(iEle,iNod,2)^2-StrNod(iEle,iNod,1)*StrNod(iEle,iNod,2)+3*StrNod(iEle,iNod,3)^2);
%             end
%         end

        % In the Super-Convergent Points
        StrSC = zeros(nEle,nGP4,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nGP4   
                ksi = uGP4(iGP,1);
                eta = uGP4(iGP,2);  

                dN = [  0.25*eta*(-1+eta)*(2*ksi-1)		0.25*eta*(-1+eta)*(2*ksi+1)		0.25*eta*(1+eta)*(2*ksi+1)		0.25*eta*( 1+eta)*(2*ksi-1)		-ksi*eta*(-1+eta)					-1/2*(-1+eta)*(1+eta)*(2*ksi+1)		-ksi*eta*(1+eta)					-1/2*(-1+eta)*(1+eta)*(2*ksi-1)		2*ksi*(-1+eta)*(1+eta)
						0.25*ksi*(-1+2*eta)*(ksi-1)		0.25*ksi*(-1+2*eta)*(1+ksi)		0.25*ksi*(2*eta+1)*(1+ksi)		0.25*ksi*(2*eta+1)*(ksi-1)		-0.5*(ksi-1)*(1+ksi)*(-1+2*eta)		-ksi*eta*(1+ksi)                	-0.5*(ksi-1)*(1+ksi)*(2*eta+1)		-ksi*eta*(ksi-1)					2*(ksi-1)*(1+ksi)*eta ];

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
        rsExt = sqrt(3)*[ -a -a ; a -a ; a a ; -a a ; 0 -a ;  a 0 ; 0 a ; -a 0 ; 0 0 ];
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
        
        % Nodal Average
        StrAvgNod = zeros(nNod,4);
        for iNod = 1:nNod
            [I,J] = find(Elements == iNod);
            nShare = length(I);
            for ishare = 1:nShare
                StrAvgNod(iNod,:) = StrAvgNod(iNod,:) + squeeze(StrSCNod(I(ishare),J(ishare),:))';
            end
            StrAvgNod(iNod,:) = StrAvgNod(iNod,:)/nShare;
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q12'  
        % In the Gaussian Points
        StrGP = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

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

                StrGP(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
                StrGP(iEle,iGP,4) = sqrt(StrGP(iEle,iGP,1)^2+StrGP(iEle,iGP,2)^2-StrGP(iEle,iGP,1)*StrGP(iEle,iGP,2)+3*StrGP(iEle,iGP,3)^2);
            end
        end
        
        % In the Nodes
%         StrNod = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             NodEle = Nodes(Elements(iEle,:),:);
% 
%             for iNod = 1:nNod12   
%                 ksi = uNod12(iNod,1);
%                 eta = uNod12(iNod,2);  
% 
%                 dN = [ (9*eta^3)/32 - (9*eta^2)/32 + (27*eta*ksi^2)/32 - (9*eta*ksi)/16 - (5*eta)/16 - (27*ksi^2)/32 + (9*ksi)/16 + 5/16, - (9*eta^3)/32 + (9*eta^2)/32 - (27*eta*ksi^2)/32 - (9*eta*ksi)/16 + (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16, (9*eta^3)/32 + (9*eta^2)/32 + (27*eta*ksi^2)/32 + (9*eta*ksi)/16 - (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16,   (5*eta)/16 + (9*ksi)/16 + (9*eta*ksi)/16 - (27*eta*ksi^2)/32 - (9*eta^2)/32 - (9*eta^3)/32 - (27*ksi^2)/32 + 5/16, (27*eta)/32 - (9*ksi)/16 + (9*eta*ksi)/16 - (81*eta*ksi^2)/32 + (81*ksi^2)/32 - 27/32,                                     (27*eta^3)/32 - (9*eta^2)/32 - (27*eta)/32 + 9/32, (27*eta)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta^3)/32 + (9*eta^2)/32 - (27*eta)/32 - 9/32, (9*eta*ksi)/16 - (9*ksi)/16 - (27*eta)/32 + (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32, (81*eta*ksi^2)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (27*eta)/32 + (81*ksi^2)/32 - 27/32,                                   - (27*eta^3)/32 + (9*eta^2)/32 + (27*eta)/32 - 9/32
%                        (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 - (9*ksi^2)/32 - (5*ksi)/16 + 5/16,   (9*eta)/16 + (5*ksi)/16 + (9*eta*ksi)/16 - (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*ksi^2)/32 - (9*ksi^3)/32 + 5/16, (27*eta^2*ksi)/32 + (27*eta^2)/32 + (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16, - (27*eta^2*ksi)/32 + (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16,                                   - (27*ksi^3)/32 + (9*ksi^2)/32 + (27*ksi)/32 - 9/32, (81*eta^2*ksi)/32 - (27*ksi)/32 - (9*eta*ksi)/16 - (9*eta)/16 + (81*eta^2)/32 - 27/32,                                     (27*ksi)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32, (9*eta*ksi)/16 - (27*ksi)/32 - (9*eta)/16 + (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 + (9*ksi^2)/32 - (27*ksi)/32 - 9/32, (27*ksi)/32 - (9*eta)/16 - (9*eta*ksi)/16 - (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi)/32 + 9/32, (27*ksi)/32 - (9*eta)/16 + (9*eta*ksi)/16 - (81*eta^2*ksi)/32 + (81*eta^2)/32 - 27/32 ];
% 
%                 Jac = dN*NodEle;
%                 dNxy = Jac\dN;
% 
%                 B = zeros(3,nDofNod*nNodEle);
%                 B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
%                 B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
% 
%                 StrNod(iEle,iNod,1:3) = C*B*De(EleDofs(iEle,:));
%                 StrNod(iEle,iNod,4) = sqrt(StrNod(iEle,iNod,1)^2+StrNod(iEle,iNod,2)^2-StrNod(iEle,iNod,1)*StrNod(iEle,iNod,2)+3*StrNod(iEle,iNod,3)^2);
%             end
%         end

        % In the Super-Convergent Points
        StrSC = zeros(nEle,nBP9,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nBP9   
                ksi = uBP9(iGP,1);
                eta = uBP9(iGP,2);  

                dN = [ (9*eta^3)/32 - (9*eta^2)/32 + (27*eta*ksi^2)/32 - (9*eta*ksi)/16 - (5*eta)/16 - (27*ksi^2)/32 + (9*ksi)/16 + 5/16, - (9*eta^3)/32 + (9*eta^2)/32 - (27*eta*ksi^2)/32 - (9*eta*ksi)/16 + (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16, (9*eta^3)/32 + (9*eta^2)/32 + (27*eta*ksi^2)/32 + (9*eta*ksi)/16 - (5*eta)/16 + (27*ksi^2)/32 + (9*ksi)/16 - 5/16,   (5*eta)/16 + (9*ksi)/16 + (9*eta*ksi)/16 - (27*eta*ksi^2)/32 - (9*eta^2)/32 - (9*eta^3)/32 - (27*ksi^2)/32 + 5/16, (27*eta)/32 - (9*ksi)/16 + (9*eta*ksi)/16 - (81*eta*ksi^2)/32 + (81*ksi^2)/32 - 27/32,                                     (27*eta^3)/32 - (9*eta^2)/32 - (27*eta)/32 + 9/32, (27*eta)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta^3)/32 + (9*eta^2)/32 - (27*eta)/32 - 9/32, (9*eta*ksi)/16 - (9*ksi)/16 - (27*eta)/32 + (81*eta*ksi^2)/32 - (81*ksi^2)/32 + 27/32,                                     (27*eta)/32 - (9*eta^2)/32 - (27*eta^3)/32 + 9/32, (81*eta*ksi^2)/32 - (9*ksi)/16 - (9*eta*ksi)/16 - (27*eta)/32 + (81*ksi^2)/32 - 27/32,                                   - (27*eta^3)/32 + (9*eta^2)/32 + (27*eta)/32 - 9/32
                       (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 - (9*ksi^2)/32 - (5*ksi)/16 + 5/16,   (9*eta)/16 + (5*ksi)/16 + (9*eta*ksi)/16 - (27*eta^2*ksi)/32 - (27*eta^2)/32 - (9*ksi^2)/32 - (9*ksi^3)/32 + 5/16, (27*eta^2*ksi)/32 + (27*eta^2)/32 + (9*eta*ksi)/16 + (9*eta)/16 + (9*ksi^3)/32 + (9*ksi^2)/32 - (5*ksi)/16 - 5/16, - (27*eta^2*ksi)/32 + (27*eta^2)/32 - (9*eta*ksi)/16 + (9*eta)/16 - (9*ksi^3)/32 + (9*ksi^2)/32 + (5*ksi)/16 - 5/16,                                   - (27*ksi^3)/32 + (9*ksi^2)/32 + (27*ksi)/32 - 9/32, (81*eta^2*ksi)/32 - (27*ksi)/32 - (9*eta*ksi)/16 - (9*eta)/16 + (81*eta^2)/32 - 27/32,                                     (27*ksi)/32 - (9*ksi^2)/32 - (27*ksi^3)/32 + 9/32, (9*eta*ksi)/16 - (27*ksi)/32 - (9*eta)/16 + (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 + (9*ksi^2)/32 - (27*ksi)/32 - 9/32, (27*ksi)/32 - (9*eta)/16 - (9*eta*ksi)/16 - (81*eta^2*ksi)/32 - (81*eta^2)/32 + 27/32,                                     (27*ksi^3)/32 - (9*ksi^2)/32 - (27*ksi)/32 + 9/32, (27*ksi)/32 - (9*eta)/16 + (9*eta*ksi)/16 - (81*eta^2*ksi)/32 + (81*eta^2)/32 - 27/32 ];

                Jac = dN*NodEle;                      

                dNxy = Jac\dN;          

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

                StrSC(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
                StrSC(iEle,iGP,4) = sqrt(StrSC(iEle,iGP,1)^2+StrSC(iEle,iGP,2)^2-StrSC(iEle,iGP,1)*StrSC(iEle,iGP,2)+3*StrSC(iEle,iGP,3)^2);
            end
        end

        % Extrapolating to the Nodes
        a16  = 1/3;
        b16  = 1;
        rsExt = 3/sqrt(5)*[ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ];
        StrSCNod = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            for iNod = 1:nNodEle
                r = rsExt(iNod,1);
                s = rsExt(iNod,2);

                N9 =      (1 - r^2)*(1 - s^2);        
                N8 = 0.50*(1 - r  )*(1 - s^2) - 0.5*N9;
                N7 = 0.50*(1 - r^2)*(1 + s  ) - 0.5*N9;
                N6 = 0.50*(1 + r  )*(1 - s^2) - 0.5*N9;
                N5 = 0.50*(1 - r^2)*(1 - s  ) - 0.5*N9;
                N4 = 0.25*(1 - r  )*(1 + s  ) - 0.5*(N7 + N8 + 0.5*N9);
                N3 = 0.25*(1 + r  )*(1 + s  ) - 0.5*(N6 + N7 + 0.5*N9);
                N2 = 0.25*(1 + r  )*(1 - s  ) - 0.5*(N5 + N6 + 0.5*N9);
                N1 = 0.25*(1 - r  )*(1 - s  ) - 0.5*(N5 + N8 + 0.5*N9);

                N = [ N1 N2 N3 N4 N5 N6 N7 N8 N9 ];

                StrSCNod(iEle,iNod,:) = N*squeeze(StrSC(iEle,:,:));
            end
        end
        
        % Nodal Average
        StrAvgNod = zeros(nNod,4);
        for iNod = 1:nNod
            [I,J] = find(Elements == iNod);
            nShare = length(I);
            for ishare = 1:nShare
                StrAvgNod(iNod,:) = StrAvgNod(iNod,:) + squeeze(StrSCNod(I(ishare),J(ishare),:))';
            end
            StrAvgNod(iNod,:) = StrAvgNod(iNod,:)/nShare;
        end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q16' 
        % In the Gaussian Points
        StrGP = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

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

                StrGP(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
                StrGP(iEle,iGP,4) = sqrt(StrGP(iEle,iGP,1)^2+StrGP(iEle,iGP,2)^2-StrGP(iEle,iGP,1)*StrGP(iEle,iGP,2)+3*StrGP(iEle,iGP,3)^2);
            end
        end
        
        % In the Nodes
%         StrNod = zeros(nEle,nNodEle,4);
%         for iEle = 1:nEle
%             NodEle = Nodes(Elements(iEle,:),:);
% 
%             for iNod = 1:nNod16   
%                 ksi = uNod16(iNod,1);
%                 eta = uNod16(iNod,2);  
% 
%                 dN = [ (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 - (27*eta*ksi^2)/256 + (9*eta*ksi)/128 + eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256, - (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 + (27*eta*ksi^2)/256 + (9*eta*ksi)/128 - eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 - (27*eta*ksi^2)/256 - (9*eta*ksi)/128 + eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, - (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 + (27*eta*ksi^2)/256 - (9*eta*ksi)/128 - eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256,   - (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 + (81*eta*ksi^2)/256 - (9*eta*ksi)/128 - (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 - (729*eta*ksi^2)/256 - (243*eta*ksi)/128 + (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   - (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 + (81*eta*ksi^2)/256 + (9*eta*ksi)/128 - (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 - (729*eta*ksi^2)/256 + (243*eta*ksi)/128 + (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256,   (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 - (81*eta*ksi^2)/256 - (9*eta*ksi)/128 + (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, - (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 + (729*eta*ksi^2)/256 + (243*eta*ksi)/128 - (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 - (81*eta*ksi^2)/256 + (9*eta*ksi)/128 + (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, - (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 + (729*eta*ksi^2)/256 - (243*eta*ksi)/128 - (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256, (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 - (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 + (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256, - (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 + (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 - (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 - (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 + (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, - (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 + (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 - (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256
%                        (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 + (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 + (9*ksi^2)/256 + ksi/256 - 1/256, - (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 + (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 + (9*ksi^2)/256 - ksi/256 - 1/256, (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 - (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, - (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 - (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 - (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 - (9*ksi^2)/256 - (27*ksi)/256 + 9/256,   (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 - (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 - (243*ksi^2)/256 + (27*ksi)/256 + 27/256, - (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 + (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256,   (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 + (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 + (243*ksi^2)/256 + (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 - (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 - (9*ksi^2)/256 + (27*ksi)/256 + 9/256,   - (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 + (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 + (243*ksi^2)/256 - (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 + (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256,   - (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 - (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 - (243*ksi^2)/256 - (27*ksi)/256 + 27/256, (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 + (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 + (243*ksi^2)/256 + (729*ksi)/256 - 243/256, - (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 + (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 + (243*ksi^2)/256 - (729*ksi)/256 - 243/256, (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 - (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 - (243*ksi^2)/256 + (729*ksi)/256 + 243/256, - (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 - (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 - (243*ksi^2)/256 - (729*ksi)/256 + 243/256];
% 
%                 Jac = dN*NodEle;
%                 dNxy = Jac\dN;
% 
%                 B = zeros(3,nDofNod*nNodEle);
%                 B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
%                 B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
%                 B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  
% 
%                 StrNod(iEle,iNod,1:3) = C*B*De(EleDofs(iEle,:));
%                 StrNod(iEle,iNod,4) = sqrt(StrNod(iEle,iNod,1)^2+StrNod(iEle,iNod,2)^2-StrNod(iEle,iNod,1)*StrNod(iEle,iNod,2)+3*StrNod(iEle,iNod,3)^2);
%             end
%         end

        % In the Super-Convergent Points
        StrSC = zeros(nEle,nBP9,4);
        for iEle = 1:nEle
            NodEle = Nodes(Elements(iEle,:),:);

            for iGP = 1:nBP9   
                ksi = uBP9(iGP,1);
                eta = uBP9(iGP,2);  

                dN = [ (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 - (27*eta*ksi^2)/256 + (9*eta*ksi)/128 + eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256, - (243*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 + (27*eta*ksi^2)/256 + (9*eta*ksi)/128 - eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (9*eta^3)/256 + (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (9*eta^2)/256 - (27*eta*ksi^2)/256 - (9*eta*ksi)/128 + eta/256 - (27*ksi^2)/256 - (9*ksi)/128 + 1/256, - (243*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (9*eta^3)/256 - (243*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (9*eta^2)/256 + (27*eta*ksi^2)/256 - (9*eta*ksi)/128 - eta/256 + (27*ksi^2)/256 - (9*ksi)/128 - 1/256,   - (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 + (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 + (81*eta*ksi^2)/256 - (9*eta*ksi)/128 - (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 - (729*eta*ksi^2)/256 - (243*eta*ksi)/128 + (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   - (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 + (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 + (81*eta*ksi^2)/256 + (9*eta*ksi)/128 - (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 - (729*eta*ksi^2)/256 + (243*eta*ksi)/128 + (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256,   (729*eta^3*ksi^2)/256 + (81*eta^3*ksi)/128 - (243*eta^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (243*eta^2)/256 - (81*eta*ksi^2)/256 - (9*eta*ksi)/128 + (27*eta)/256 + (81*ksi^2)/256 + (9*ksi)/128 - 27/256, - (729*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (27*eta^3)/256 - (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 + (9*eta^2)/256 + (729*eta*ksi^2)/256 + (243*eta*ksi)/128 - (27*eta)/256 + (243*ksi^2)/256 + (81*ksi)/128 - 9/256,   (729*eta^3*ksi^2)/256 - (81*eta^3*ksi)/128 - (243*eta^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (243*eta^2)/256 - (81*eta*ksi^2)/256 + (9*eta*ksi)/128 + (27*eta)/256 - (81*ksi^2)/256 + (9*ksi)/128 + 27/256, - (729*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (27*eta^3)/256 + (243*eta^2*ksi^2)/256 - (81*eta^2*ksi)/128 - (9*eta^2)/256 + (729*eta*ksi^2)/256 - (243*eta*ksi)/128 - (27*eta)/256 - (243*ksi^2)/256 + (81*ksi)/128 + 9/256, (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 - (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 - (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 + (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256, - (2187*eta^3*ksi^2)/256 - (243*eta^3*ksi)/128 + (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 + (2187*eta*ksi^2)/256 + (243*eta*ksi)/128 - (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 - (729*eta^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 - (243*eta^2)/256 - (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 + (729*eta)/256 - (729*ksi^2)/256 - (81*ksi)/128 + 243/256, - (2187*eta^3*ksi^2)/256 + (243*eta^3*ksi)/128 + (729*eta^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/128 + (243*eta^2)/256 + (2187*eta*ksi^2)/256 - (243*eta*ksi)/128 - (729*eta)/256 + (729*ksi^2)/256 - (81*ksi)/128 - 243/256
                       (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 + (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 + (9*ksi^2)/256 + ksi/256 - 1/256, - (243*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 + (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 + (9*ksi^2)/256 - ksi/256 - 1/256, (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (27*eta^2*ksi)/256 - (27*eta^2)/256 + (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (9*eta*ksi)/128 - (9*eta)/128 - (9*ksi^3)/256 - (9*ksi^2)/256 + ksi/256 + 1/256, - (243*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (27*eta^2*ksi)/256 - (27*eta^2)/256 - (81*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (9*eta*ksi)/128 - (9*eta)/128 + (9*ksi^3)/256 - (9*ksi^2)/256 - ksi/256 + 1/256, - (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 - (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 - (9*ksi^2)/256 - (27*ksi)/256 + 9/256,   (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 - (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 - (243*ksi^2)/256 + (27*ksi)/256 + 27/256, - (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 + (729*eta^2*ksi)/256 + (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 + (27*ksi^3)/256 + (9*ksi^2)/256 - (27*ksi)/256 - 9/256,   (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (81*eta^2*ksi)/256 + (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 - (243*ksi^3)/256 + (243*ksi^2)/256 + (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 + (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 - (243*eta^2)/256 - (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 - (9*ksi^2)/256 + (27*ksi)/256 + 9/256,   - (729*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 + (81*eta^2)/256 - (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 + (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 + (243*ksi^2)/256 - (27*ksi)/256 - 27/256, (729*eta^2*ksi^3)/256 - (243*eta^2*ksi^2)/256 - (729*eta^2*ksi)/256 + (243*eta^2)/256 + (243*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (243*eta*ksi)/128 + (81*eta)/128 - (27*ksi^3)/256 + (9*ksi^2)/256 + (27*ksi)/256 - 9/256,   - (729*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (81*eta^2*ksi)/256 - (81*eta^2)/256 + (81*eta*ksi^3)/128 - (81*eta*ksi^2)/128 - (9*eta*ksi)/128 + (9*eta)/128 + (243*ksi^3)/256 - (243*ksi^2)/256 - (27*ksi)/256 + 27/256, (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 + (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 + (243*ksi^2)/256 + (729*ksi)/256 - 243/256, - (2187*eta^2*ksi^3)/256 - (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 + (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 + (243*ksi^2)/256 - (729*ksi)/256 - 243/256, (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 - (2187*eta^2*ksi)/256 - (729*eta^2)/256 + (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 - (243*eta*ksi)/128 - (81*eta)/128 - (729*ksi^3)/256 - (243*ksi^2)/256 + (729*ksi)/256 + 243/256, - (2187*eta^2*ksi^3)/256 + (729*eta^2*ksi^2)/256 + (2187*eta^2*ksi)/256 - (729*eta^2)/256 - (243*eta*ksi^3)/128 + (81*eta*ksi^2)/128 + (243*eta*ksi)/128 - (81*eta)/128 + (729*ksi^3)/256 - (243*ksi^2)/256 - (729*ksi)/256 + 243/256];

                Jac = dN*NodEle;                      

                dNxy = Jac\dN;          

                B = zeros(3,nDofNod*nNodEle);
                B(1,1:2:nDofNod*nNodEle) = dNxy(1,:);
                B(2,2:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,1:2:nDofNod*nNodEle) = dNxy(2,:);
                B(3,2:2:nDofNod*nNodEle) = dNxy(1,:);  

                StrSC(iEle,iGP,1:3) = C*B*De(EleDofs(iEle,:));
                StrSC(iEle,iGP,4) = sqrt(StrSC(iEle,iGP,1)^2+StrSC(iEle,iGP,2)^2-StrSC(iEle,iGP,1)*StrSC(iEle,iGP,2)+3*StrSC(iEle,iGP,3)^2);
            end
        end

        % Extrapolating to the Nodes
        a16  = 1/3;
        b16  = 1;
        rsExt = 3/sqrt(5)*[ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
        StrSCNod = zeros(nEle,nNodEle,4);
        for iEle = 1:nEle
            for iNod = 1:nNodEle
                r = rsExt(iNod,1);
                s = rsExt(iNod,2);

                N9 =      (1 - r^2)*(1 - s^2);        
                N8 = 0.50*(1 - r  )*(1 - s^2) - 0.5*N9;
                N7 = 0.50*(1 - r^2)*(1 + s  ) - 0.5*N9;
                N6 = 0.50*(1 + r  )*(1 - s^2) - 0.5*N9;
                N5 = 0.50*(1 - r^2)*(1 - s  ) - 0.5*N9;
                N4 = 0.25*(1 - r  )*(1 + s  ) - 0.5*(N7 + N8 + 0.5*N9);
                N3 = 0.25*(1 + r  )*(1 + s  ) - 0.5*(N6 + N7 + 0.5*N9);
                N2 = 0.25*(1 + r  )*(1 - s  ) - 0.5*(N5 + N6 + 0.5*N9);
                N1 = 0.25*(1 - r  )*(1 - s  ) - 0.5*(N5 + N8 + 0.5*N9);

                N = [ N1 N2 N3 N4 N5 N6 N7 N8 N9 ];

                StrSCNod(iEle,iNod,:) = N*squeeze(StrSC(iEle,:,:));
            end
        end
        
        % Nodal Average
        StrAvgNod = zeros(nNod,4);
        for iNod = 1:nNod
            [I,J] = find(Elements == iNod);
            nShare = length(I);
            for ishare = 1:nShare
                StrAvgNod(iNod,:) = StrAvgNod(iNod,:) + squeeze(StrSCNod(I(ishare),J(ishare),:))';
            end
            StrAvgNod(iNod,:) = StrAvgNod(iNod,:)/nShare;
        end
        
end


disp('Stresses CALCULATED')