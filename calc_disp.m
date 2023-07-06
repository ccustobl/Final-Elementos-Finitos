function [D,De,Disp,DCG] = calc_disp(Case,Nodes,bc,K,R,DAF,nDofNod,nNod)

% Reduction
% Fix = bc;
Free =~ bc;
Kr = K(Free,Free);
Rr = R(Free); 
   
% Solver
% Dr = Kr\Rr;
Dr = mldivide(Kr,Rr);

% Reconstruction
De = zeros(length(bc),1);
De(Free) = De(Free) + Dr;

% Displacements
D = reshape(De,nDofNod,nNod);
Disp = D';
%DC = Nodes + Disp(1:nNod,1:2);
if strcmp(Case(1:5),'Patch')==1
    DAF = 40000;
end
DCG = Nodes + DAF*Disp(1:nNod,1:2);

% Reactions
% Reac = zeros(nNod,nDofNod);
% Reac(Fix) = K(Fix,Free)*De(Free);
% Reac = (reshape(Reac,nDofNod,[]))';

clear K bc R

disp('Displacements CALCULATED')