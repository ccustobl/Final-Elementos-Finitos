function [nDofNod,nNodEle,nEle,nNod,nDofTot,t,NodeDofs,EleDofs,uGP1,nGP1,wGP1,uGP4,nGP4,wGP4,uGP9,nGP9,wGP9,uBP9,nBP9,wBP9,uGP16,nGP16,wGP16,uNod4,nNod4,uNod8,nNod8,uNod9,nNod9,uNod12,nNod12,uNod16,nNod16] = select_parameters(Ele_Type,Elements,Nodes)

% Fill
uGP1 = 0;
nGP1 = 0;
wGP1 = 0;

uGP4 = 0;
nGP4 = 0;
wGP4 = 0;

uGP9 = 0;
nGP9 = 0;
wGP9 = 0;

uBP9 = 0;
nBP9 = 0;
wBP9 = 0;

uGP16 = 0;
nGP16 = 0;
wGP16 = 0;

uNod4 = 0;
nNod4= 0;
uNod8 = 0;
nNod8= 0;
uNod9 = 0;
nNod9= 0;
uNod12 = 0;
nNod12= 0;
uNod16 = 0;
nNod16= 0;


switch Ele_Type
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q4'
        % Parameters
        nDofNod = 2;
        nNodEle = 4;
        
        % Gauss' Parameters
        
        % Sub (1 GP)
        a1 = 0;
        uGP1 = [a1 a1];
        nGP1 = size(uGP1,1);
        wGP1 = ones(nGP1,2);

        % Full (4 GP)
        a4 = 1/sqrt(3);
        uGP4 = [ -a4 -a4 ; a4 -a4 ; a4 a4 ; -a4 a4 ];
        nGP4 = size(uGP4,1);
        wGP4 = ones(nGP4,2);
        
        % 4 Nods
        a4 = 1;
        uNod4 = [ -a4 -a4 ; a4 -a4 ; a4 a4 ; -a4 a4 ];
        nNod4 = size(uNod4,1);
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    case 'Q8'
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
        uGP9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0 ];
        nGP9 = size(uGP9,1);
        w1 = 5/9;
        w2 = 8/9;
        wGP9 = [ w1 w1 ; w1 w1 ; w1 w1 ; w1 w1 ; w2 w1 ; w1 w2 ; w2 w1 ; w1 w2 ; w2 w2 ];
        
        % 8 Nods + Center
        a8 = 1;
        uNod8 = [ -a8 -a8 ; a8 -a8 ; a8 a8 ; -a8 a8 ; 0 -a8 ; a8 0 ; 0 a8 ; -a8 0 ; 0 0 ];
        nNod8 = size(uNod8,1);
        
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    case 'Q9'
        % Parameters
        nDofNod = 2;
        nNodEle = 9;
        
        % Gauss' Parameters

        % Sub (4 GP)
        a4 = 1/sqrt(3);
        uGP4 = [ -a4 -a4 ; a4 -a4 ; a4 a4 ; -a4 a4 ];
        nGP4 = size(uGP4,1);
        wGP4 = ones(nGP4,2);

        % Full (9 GP)
        a9 = sqrt(0.6);
        uGP9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0 ];
        nGP9 = size(uGP9,1);
        w1 = 5/9;
        w2 = 8/9;
        wGP9 = [ w1 w1 ; w1 w1 ; w1 w1 ; w1 w1 ; w2 w1 ; w1 w2 ; w2 w1 ; w1 w2 ; w2 w2 ];
        
        % 9 Nod
        a9 = 1;
        uNod9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0 ];
        nNod9 = size(uNod9,1);
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q12'
        % Parameters
        nDofNod = 2;
        nNodEle = 12;
        
        % Gauss' Parameters
        
        % Sub (9 BP)
        a9 = sqrt(5)/3;
        uBP9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0];
        nBP9 = size(uBP9,1);
        w1 = 5/9;
        w2 = 8/9;
        wBP9 = [ w1 w1 ; w1 w1 ; w1 w1 ; w1 w1 ; w2 w1 ; w1 w2 ; w2 w1 ; w1 w2 ; w2 w2 ];

        % Full (16 GP)
        a16  = sqrt((3 - 2*sqrt(6/5))/7);
        b16  = sqrt((3 + 2*sqrt(6/5))/7);
        uGP16 = [ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
        nGP16 = size(uGP16,1);
        wa16 = (18 + sqrt(30))/36;
        wb16 = (18 - sqrt(30))/36;
        wGP16  = [ wb16 wb16 ; wb16 wb16 ; wb16 wb16 ; wb16 wb16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wa16 ; wa16 wa16 ; wa16 wa16 ; wa16 wa16 ];
        
        % 12 Nod + 4 Center 
        a12  = sqrt((3 - 2*sqrt(6/5))/7);
        b12  = sqrt((3 + 2*sqrt(6/5))/7);
        uNod12 = [ -b12 -b12 ; b12 -b12 ; b12 b12 ; -b12 b12 ; -a12 -b12 ; b12 -a12 ; a12 b12 ; -b12 a12 ; a12 -b12 ; b12 a12 ; -a16 b12 ; -b12 -a12 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
        nNod12 = size(uNod12,1);
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q16'
        % Parameters
        nDofNod = 2;
        nNodEle = 16;
        
        % Gauss' Parameters
        
        % Sub (9 BP)
        a9 = sqrt(5)/3;
        uBP9 = [ -a9 -a9 ; a9 -a9 ; a9 a9 ; -a9 a9 ; 0 -a9 ; a9 0 ; 0 a9 ; -a9 0  ; 0 0];
        nBP9 = size(uBP9,1);
        w1 = 5/9;
        w2 = 8/9;
        wBP9 = [ w1 w1 ; w1 w1 ; w1 w1 ; w1 w1 ; w2 w1 ; w1 w2 ; w2 w1 ; w1 w2 ; w2 w2 ];

        % Full (16 GP)
        a16  = sqrt((3 - 2*sqrt(6/5))/7);
        b16  = sqrt((3 + 2*sqrt(6/5))/7);
        uGP16 = [ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
        nGP16 = size(uGP16,1);
        wa16 = (18 + sqrt(30))/36;
        wb16 = (18 - sqrt(30))/36;
        wGP16  = [ wb16 wb16 ; wb16 wb16 ; wb16 wb16 ; wb16 wb16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wb16 ; wb16 wa16 ; wa16 wa16 ; wa16 wa16 ; wa16 wa16 ; wa16 wa16 ];
        
        % 16 Nod
        a16  = sqrt((3 - 2*sqrt(6/5))/7);
        b16  = sqrt((3 + 2*sqrt(6/5))/7);
        uNod16 = [ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
        nNod16 = size(uNod16,1);
       
end


% Paramenters
nEle = size(Elements,1);
nNod = size(Nodes,1);
nDofTot = nNod*nDofNod;
t = 1; %mm

% Dofs of each Node
NodeDofs = reshape(1:nDofTot,nDofNod,nNod)';

% Dofs of each Element
EleDofs = zeros(nEle,nDofNod*nNodEle);
for iEle = 1:nEle
    EleDofs(iEle,:) = reshape(NodeDofs(Elements(iEle,:),:)',[],nNodEle*nDofNod);
end

