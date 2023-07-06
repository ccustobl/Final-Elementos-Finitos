function [C,E,Alpha] = select_material(Material)

switch Material
    case 'Orthotropic'
        E1 = 150e3;   %MPa 150e3
        E2 = 180e3;   %MPa 180e3
%         E3 = 200e3;   %MPa
        G12 = 75e3;     %MPa
        v12 = 0.3;
        Alpha = 90;    %Degrees
        alpha = Alpha*pi/180;
        
%         v12 = v12_J*E1/E2;
        v21 = v12*E2/E1;
        
        m = cos(-alpha);
        n = sin(-alpha);
        T1 = [ m^2 n^2 2*m*n ; n^2 m^2 -2*m*n ; -m*n m*n m^2-n^2 ];
        m = cos(alpha);
        n = sin(alpha);
        T2 = [ m^2 n^2 m*n ; n^2 m^2 -m*n ; -2*m*n 2*m*n m^2-n^2 ];
        
        Q11 = E1/(1-v12*v21);
        Q12 = (v12*E2)/(1-v12*v21);
        Q21 = (v21*E1)/(1-v12*v21);
        Q22 = E2/(1-v12*v21);
        Q66 = G12;
        Q = [ Q11 Q12 0 ; Q21 Q22 0 ; 0 0 Q66 ]; 
        C = T1*Q*T2;

        E = 0; %NO TOCAR, afecta save_k y load_k, Data_Load y Data_Save

        
        % Verifico T1 y T2
%         m = cos(alpha);
%         n = sin(alpha);
%         T1 = [ m^2 n^2 2*m*n ; n^2 m^2 -2*m*n ; -m*n m*n m^2-n^2 ];
%         T2 = [ m^2 n^2 m*n ; n^2 m^2 -m*n ; -2*m*n 2*m*n m^2-n^2 ];
%         T1_inv = inv(T1);
%         T2_inv = inv(T2);
%         T1_inv==T2'
%         T2_inv==T1'
        
    case 'Isotropic'
        E = 165e3;   %MPa
%         G = 75e3;    %MPa
        v = 0.3;        
        C = (E/(1-v^2))*[ 1 v 0 ; v 1 0 ; 0 0 (1-v)/2 ];
        
        Alpha = 0; %NO TOCAR, afecta save_k y load_k, Data_Load y Data_Save
        
end