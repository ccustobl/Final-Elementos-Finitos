clear 
close all
clc


%% LST

syms ksi eta real
N = [ (1-ksi-eta)*(1-2*ksi*eta) ksi*(2*ksi-eta) eta*(2*eta-1) 4*ksi*(1-ksi-eta) 4*ksi*eta 4*eta*(1-ksi-eta) ];
dN = [ diff(N,ksi) ; diff(N,eta) ];


%% Q12

a12  = 1/3;
b12  = 1;
uNod12 = [ -b12 -b12 ; b12 -b12 ; b12 b12 ; -b12 b12 ; -a12 -b12 ; b12 -a12 ; a12 b12 ; -b12 a12 ; a12 -b12 ; b12 a12 ; -a12 b12 ; -b12 -a12 ];
nNod12 = size(uNod12,1);
A = zeros(12);
for iGP = 1:nNod12
    ksi = uNod12(iGP,1);
    eta = uNod12(iGP,2);
    Pol = [ 1 ksi eta ksi^2 eta*ksi eta^2 ksi^3 ksi^2*eta ksi*eta^2 eta^3 ksi^3*eta ksi*eta^3 ];
    A(iGP,:) = Pol;
    
end

syms ksi eta real
Pol = [ 1 ksi eta ksi^2 eta*ksi eta^2 ksi^3 ksi^2*eta ksi*eta^2 eta^3 ksi^3*eta ksi*eta^3 ];
N = Pol/A;
dN = [ diff(N,ksi) ; diff(N,eta) ];


%% Q16

a16  = 1/3;
b16  = 1;
uNod16 = [ -b16 -b16 ; b16 -b16 ; b16 b16 ; -b16 b16 ; -a16 -b16 ; b16 -a16 ; a16 b16 ; -b16 a16 ; a16 -b16 ; b16 a16 ; -a16 b16 ; -b16 -a16 ; -a16 -a16 ; a16 -a16 ; a16 a16 ; -a16 a16 ];
nNod16 = size(uGP16,1);

A = zeros(16);
for iGP = 1:nNod16
    ksi = uNod16(iGP,1);
    eta = uNod16(iGP,2);
    Pol = [ 1 ksi eta ksi^2 eta*ksi eta^2 ksi^3 ksi^2*eta ksi*eta^2 eta^3 ksi^3*eta ksi^2*eta^2 ksi*eta^3 ksi^3*eta^2 ksi^2*eta^3 ksi^3*eta^3 ];
    A(iGP,:) = Pol;
    
end

syms ksi eta real
Pol = [ 1 ksi eta ksi^2 eta*ksi eta^2 ksi^3 ksi^2*eta ksi*eta^2 eta^3 ksi^3*eta ksi^2*eta^2 ksi*eta^3 ksi^3*eta^2 ksi^2*eta^3 ksi^3*eta^3 ];
N = Pol/A;
dN = [ diff(N,ksi) ; diff(N,eta) ];

