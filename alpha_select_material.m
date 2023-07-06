function [C] = alpha_select_material(Material,Alpha,E1,E2,G12,v12)

switch Material
    case 'Orthotropic'
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
        error('Isotropic Material')
end