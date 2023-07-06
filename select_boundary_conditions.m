function bc = select_boundary_conditions(Simetric,Ele_Type,Case,Loads,Nodes,nNod,nDofNod)

bc = false(nNod,nDofNod);

switch Case
    
    case 'Final'
        switch Simetric
            case 'Yes'
                NodLefBotbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
                bc(NodLefBotbc,:) = true;
                NodLefbc = find(abs(Nodes(:,1) - 0) <1e-9);
                bc(NodLefbc,1) = true;
            case 'No'
                % Simetricas
%                 NodLefBotbc = find(abs(Nodes(:,1) - 50) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
%                 bc(NodLefBotbc,:) = true;
%                 NodLefUpbc = find(abs(Nodes(:,1) - 50) <1e-9 & abs(Nodes(:,2) - 15) <1e-9);
%                 bc(NodLefUpbc,1) = true;

                % No Simetricas
                NodLefBotbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
                bc(NodLefBotbc,:) = true;
                NodLefUpbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 30) <1e-9 ); % & abs(Nodes(:,2) - 30) <1e-9
                bc(NodLefUpbc,1) = true;
        end
        
    case 'Plate'
        switch Loads
            case 'Normal'
                NodLefBotbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
                bc(NodLefBotbc,:) = true;
                NodLefUpbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 30) <1e-9);
                bc(NodLefUpbc,1) = true;
            case 'Beam'
                NodLefBotbc = find(abs(Nodes(:,1) - 0) <1e-9 & abs(Nodes(:,2) - 0) <1e-9);
                bc(NodLefBotbc,:) = true;
                NodLefUpbc = find(abs(Nodes(:,1) - 0) <1e-9);
                bc(NodLefUpbc,:) = true;
        end

    case 'PatchTest.X'
        switch Ele_Type
            case 'Q4'
                bc(1,1:2) = true;
                bc(4,1) = true;
                
            case 'Q8'
                bc(1,1:2) = true;
%                bc(3,1) = true;
%                bc(7,1) = true;        
                bc(6,1) = true;
                bc(9,1) = true;
                
            case 'Q9'
                bc(1,1:2) = true;
                bc(3,1) = true;
                bc(7,1) = true;  
                
            case 'Q12'
                bc(1,1:2) = true;
                bc(5,1) = true;
                bc(7,1) = true;
                bc(9,1) = true;
                
            case 'Q16'
                bc(1,1:2) = true;
                bc(5,1) = true;
                bc(9,1) = true;
                bc(13,1) = true;
        end
           
    case 'PatchTest.Y'
        switch Ele_Type
            case 'Q4'
                bc(1,1:2) = true;
                bc(2,2) = true; 
                
            case 'Q8'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                
            case 'Q9'
                bc(1,1:2) = true;
                bc(5,2) = true;
                bc(2,2) = true; 
                
            case 'Q12'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                bc(4,2) = true;
                
            case 'Q16'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                bc(4,2) = true;
        end
    
    case 'PatchTest.XY'
        switch Ele_Type
            case 'Q4'
                bc(1,1:2) = true;
                bc(2,2) = true; 
                
            case 'Q8'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                
            case 'Q9'
                bc(1,1:2) = true;
                bc(5,2) = true;
                bc(2,2) = true;
                
            case 'Q12'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                bc(4,2) = true;

            case 'Q16'
                bc(1,1:2) = true;
                bc(2,2) = true;
                bc(3,2) = true;
                bc(4,2) = true;                
        end    
end

bc = reshape(bc',[],1);

