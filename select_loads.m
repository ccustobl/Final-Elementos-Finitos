function R = select_loads(Simetric,Ele_Type,Case,Loads,Nodes,Elements,nNod,nDofNod,t)

R = zeros(nNod,nDofNod);
Lmax = max(Nodes(:,1));
hmax = max(Nodes(:,2));

switch Ele_Type
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q4'
        
        switch Case    
            case 'Final'
                switch Simetric
                    case 'Yes'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,~] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/2;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/2;
                        end
                    case 'No'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,~] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/2;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/2;
                        end
                        % Left Side
                        NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,~] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/2;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/2;
                        end
                end
                
            case 'Plate'
                switch Loads
                    case 'Normal'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,~] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/2;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/2;
                        end
                        % Left Side
                        NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,~] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/2;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/2;
                        end
                end
                        
                    case 'Beam'
                        q = -1;      %N/mm2        
                        % Right Side
                        NodTopLoad = find(abs(Nodes(:,2) - hmax) <1e-9);
                        EleTopLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodTopLoad)
                            EleTopLoad = EleTopLoad + (sum(~(Elements - NodTopLoad(iLoad))'))';
                        end
                        EleLoad = find(EleTopLoad);
                        NodLoad = zeros(length(EleLoad),3);
                        NodLoad(:,3) = 1;
                        for iLoad = 1:length(NodTopLoad)
                           [I,~] = find(Elements==NodTopLoad(iLoad));
                           for jLoad = 1:length(I)
                              NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodTopLoad(iLoad);
                              NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                           end
                        end
                        disp('Peron')
                        NodLoad(:,3) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),2) = R(NodLoad(iEle,1),2) + q*LongLoad*t/2;
                            R(NodLoad(iEle,2),2) = R(NodLoad(iEle,2),2) + q*LongLoad*t/2;
                        end

            case 'PatchTest.X'
                q = 1;      %N/mm2        
                % Right Side
                NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),3);
                NodLoad(:,3) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,~] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                      NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                      NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                   end
                end
                NodLoad(:,3) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad/2;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad/2;
                end    
                % Left Side
                NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),3);
                NodLoad(:,3) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,~] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                      NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),3)) = NodRigLoad(iLoad);
                      NodLoad(EleLoad==I(jLoad),3) = NodLoad(EleLoad==I(jLoad),3) + 1;
                   end
                end
                NodLoad(:,3) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad/2;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad/2;
                end

%                L2 = max(Nodes(:,2));
%                R(1,1) = -q*L2/4;
%                R(4,1) = -q*L2/2;
%                R(7,1) = -q*L2/4;
%                R(3,1) = q*L2/4;
%                R(6,1) = q*L2/2;
%                R(9,1) = q*L2/4;

            case 'PatchTest.Y'
                q = 1;      %N/mm2 
                L1 = max(Nodes(:,1));
                R(1,2) = -q*L1/4;
                R(2,2) = -q*L1/2;
                R(3,2) = -q*L1/4;
                R(7,2) = q*L1/4;
                R(8,2) = q*L1/2;
                R(9,2) = q*L1/4;

            case 'PatchTest.XY'
                q = 1;      %N/mm2 
                L1 = max(Nodes(:,1));
                L2 = max(Nodes(:,2));
                R(1,1) = -q*L2/4;
                R(2,1) = -q*L2/2;
                R(3,1) = -q*L2/4;
                R(7,1) = q*L2/4;
                R(8,1) = q*L2/2;
                R(9,1) = q*L2/4;
                R(1,2) = -q*L1/4;
                R(4,2) = -q*L1/2;
                R(7,2) = -q*L1/4;
                R(3,2) = q*L1/4;
                R(6,2) = q*L1/2;
                R(9,2) = q*L1/4;
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 'Q8'
        
        switch Case
            case 'Final'
                switch Simetric
                    case 'Yes'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                        end
                    case 'No'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                        end
                        % Left Side
                        NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -2*q*LongLoad*t/3;
                        end
                        
                end
                
            case 'Plate'
                switch Loads
                    case 'Normal'
                    q = 1;      %N/mm2        
                    % Right Side
                    NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                    EleRigLoad = zeros(size(Elements,1),1);
                    for iLoad = 1:length(NodRigLoad)
                        EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                    end
                    EleLoad = find(EleRigLoad);
                    NodLoad = zeros(length(EleLoad),4);
                    NodLoad(:,4) = 1;
                    for iLoad = 1:length(NodRigLoad)
                       [I,J] = find(Elements==NodRigLoad(iLoad));
                       for jLoad = 1:length(I)
                           if J <= 4
                               NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                               NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                           else
                               NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                           end
                       end
                    end
                    NodLoad(:,4) = [];
                    for iEle = 1:length(EleLoad)
                        LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                        R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                        R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                        R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                    end
                    % Left Side
                    NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                    EleRigLoad = zeros(size(Elements,1),1);
                    for iLoad = 1:length(NodRigLoad)
                        EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                    end
                    EleLoad = find(EleRigLoad);
                    NodLoad = zeros(length(EleLoad),4);
                    NodLoad(:,4) = 1;
                    for iLoad = 1:length(NodRigLoad)
                       [I,J] = find(Elements==NodRigLoad(iLoad));
                       for jLoad = 1:length(I)
                           if J <= 4
                               NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                               NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                           else
                               NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                           end
                       end
                    end
                    NodLoad(:,4) = [];
                    for iEle = 1:length(EleLoad)
                        LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                        R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/6;
                        R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/6;
                        R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -2*q*LongLoad*t/3;
                    end
                    
                    case 'Beam'
                    q = 1;      %N/mm2        
                    % Top Side
                    NodTopLoad = find(abs(Nodes(:,2) - hmax) <1e-9);
                    EleTopLoad = zeros(size(Elements,1),1);
                    for iLoad = 1:length(NodTopLoad)
                        EleTopLoad = EleTopLoad + (sum(~(Elements - NodTopLoad(iLoad))'))';
                    end
                    EleLoad = find(EleTopLoad);
                    NodLoad = zeros(length(EleLoad),4);
                    NodLoad(:,4) = 1;
                    for iLoad = 1:length(NodTopLoad)
                       [I,J] = find(Elements==NodTopLoad(iLoad));
                       for jLoad = 1:length(I)
                           if J <= 4
                               NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodTopLoad(iLoad);
                               NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                           else
                               NodLoad(EleLoad==I(jLoad),3) = NodTopLoad(iLoad);
                           end
                       end
                    end
                    NodLoad(:,4) = [];
                    for iEle = 1:length(EleLoad)
                        LongLoad = abs(Nodes(NodLoad(iEle,1),1) - Nodes(NodLoad(iEle,2),1));
                        R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                        R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                        R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                    end
                end
                
            case 'PatchTest.X'
                q = 1;      %N/mm2         
                % Right Side
                NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad/6;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad/6;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad/3;
                end
                % Left Side
                NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad/6;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad/6;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -2*q*LongLoad/3;
                end

%                 q = 1;
%                 L2 = max(Nodes(:,2));
%                 R(1,1) = -q*L2/12;
%                 R(6,1) = -2*q*L2/6;
%                 R(9,1) = -q*L2/6;
%                 R(14,1) = -2*q*L2/6;
%                 R(17,1) = -q*L2/12;
%                 R(5,1) = q*L2/12;
%                 R(8,1) = 2*q*L2/6;
%                 R(13,1) = q*L2/6;
%                 R(16,1) = 2*q*L2/6;
%                 R(21,1) = q*L2/12;

            case 'PatchTest.Y'
                q = 1;      %N/mm2 
                L1 = max(Nodes(:,1));
                R(1,2) = -q*L1/12;
                R(2,2) = -2*q*L1/6;
                R(3,2) = -q*L1/6;
                R(4,2) = -2*q*L1/6;
                R(5,2) = -q*L1/12;
                R(17,2) = q*L1/12;
                R(18,2) = 2*q*L1/6;
                R(19,2) = q*L1/6;
                R(20,2) = 2*q*L1/6;
                R(21,2) = q*L1/12;

            case 'PatchTest.XY'
                q = 1;      %N/mm2 
                L1 = max(Nodes(:,1));
                L2 = max(Nodes(:,2));
                R(1,2) = -q*L2/12;
                R(6,2) = -2*q*L2/6;
                R(9,2) = -q*L2/6;
                R(14,2) = -2*q*L2/6;
                R(17,2) = -q*L2/12;
                R(5,2) = q*L2/12;
                R(8,2) = 2*q*L2/6;
                R(13,2) = q*L2/6;
                R(16,2) = 2*q*L2/6;
                R(21,2) = q*L2/12;
                R(1,1) = -q*L1/12;
                R(2,1) = -2*q*L1/6;
                R(3,1) = -q*L1/6;
                R(4,1) = -2*q*L1/6;
                R(5,1) = -q*L1/12;
                R(17,1) = q*L1/12;
                R(18,1) = 2*q*L1/6;
                R(19,1) = q*L1/6;
                R(20,1) = 2*q*L1/6;
                R(21,1) = q*L1/12;
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q9'
        switch Case    
            case 'Final'
                switch Simetric
                    case 'Yes'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                        end
                        
                    case 'No'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad*t/3;
                        end
                        % Left Side
                        NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),4);
                        NodLoad(:,4) = 1;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                               end
                           end
                        end
                        NodLoad(:,4) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/6;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/6;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -2*q*LongLoad*t/3;
                        end  
                end

            case 'PatchTest.X'
                q = 1;      %N/mm2         
                % Right Side
                NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad/6;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad/6;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 2*q*LongLoad/3;
                end
                % Left Side
                NodRigLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodRigLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad/6;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad/6;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -2*q*LongLoad/3;
                end        

            case 'PatchTest.Y'
%                 q = 1;      %N/mm2 
%                 L1 = max(Nodes(:,1));
%                 R(1,2) = -q*L1/12;
%                 R(5,2) = -2*q*L1/6;
%                 R(2,2) = -q*L1/6;
%                 R(12,2) = -2*q*L1/6;
%                 R(10,2) = -q*L1/12;
%                 R(16,2) = q*L1/12;
%                 R(18,2) = 2*q*L1/6;
%                 R(17,2) = q*L1/6;
%                 R(23,2) = 2*q*L1/6;
%                 R(22,2) = q*L1/12;

                q = 1;      %N/mm2        
                % Top Side
                NodTopLoad = find(abs(Nodes(:,2) - hmax) <1e-9);
                EleTopLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodTopLoad)
                    EleTopLoad = EleTopLoad + (sum(~(Elements - NodTopLoad(iLoad))'))';
                end
                EleLoad = find(EleTopLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodTopLoad)
                   [I,J] = find(Elements==NodTopLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodTopLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodTopLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),1) - Nodes(NodLoad(iEle,2),1));
                    R(NodLoad(iEle,1),2) = R(NodLoad(iEle,1),2) + q*LongLoad*t/6;
                    R(NodLoad(iEle,2),2) = R(NodLoad(iEle,2),2) + q*LongLoad*t/6;
                    R(NodLoad(iEle,3),2) = R(NodLoad(iEle,3),2) + 2*q*LongLoad*t/3;
                end
                
                % Bottom Side
                NodTopLoad = find(abs(Nodes(:,2) - 0) <1e-9);
                EleTopLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodTopLoad)
                    EleTopLoad = EleTopLoad + (sum(~(Elements - NodTopLoad(iLoad))'))';
                end
                EleLoad = find(EleTopLoad);
                NodLoad = zeros(length(EleLoad),4);
                NodLoad(:,4) = 1;
                for iLoad = 1:length(NodTopLoad)
                   [I,J] = find(Elements==NodTopLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),4)) = NodTopLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),4) = NodLoad(EleLoad==I(jLoad),4) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),3) = NodTopLoad(iLoad);
                       end
                   end
                end
                NodLoad(:,4) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),1) - Nodes(NodLoad(iEle,2),1));
                    R(NodLoad(iEle,1),2) = R(NodLoad(iEle,1),2) + -q*LongLoad*t/6;
                    R(NodLoad(iEle,2),2) = R(NodLoad(iEle,2),2) + -q*LongLoad*t/6;
                    R(NodLoad(iEle,3),2) = R(NodLoad(iEle,3),2) + -2*q*LongLoad*t/3;
                end
                
                
            case 'PatchTest.XY'
                q = 1;      %N/mm2 
                L1 = max(Nodes(:,1));
                L2 = max(Nodes(:,2));
                R(1,2) = -q*L2/12;
                R(7,2) = -2*q*L2/6;
                R(3,2) = -q*L2/6;
                R(19,2) = -2*q*L2/6;
                R(16,2) = -q*L2/12;
                R(10,2) = q*L2/12;
                R(14,2) = 2*q*L2/6;
                R(11,2) = q*L2/6;
                R(24,2) = 2*q*L2/6;
                R(22,2) = q*L2/12;
                R(1,1) = -q*L1/12;
                R(5,1) = -2*q*L1/6;
                R(2,1) = -q*L1/6;
                R(12,1) = -2*q*L1/6;
                R(10,1) = -q*L1/12;
                R(16,1) = q*L1/12;
                R(18,1) = 2*q*L1/6;
                R(17,1) = q*L1/6;
                R(23,1) = 2*q*L1/6;
                R(22,1) = q*L1/12;

        end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    case 'Q12'
        
        switch Case    
            case 'Final'
                switch Simetric
                    case 'Yes'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),6);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad*t/8;
                        end 
                    case 'No'
                                                q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),6);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad*t/8;
                        end
                        % Left Side
                        NodLefLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleLefLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodLefLoad)
                            EleLefLoad = EleLefLoad + (sum(~(Elements - NodLefLoad(iLoad))'))';
                        end
                        EleLoad = find(EleLefLoad);
                        NodLoad = zeros(length(EleLoad),5);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodLefLoad)
                           [I,J] = find(Elements==NodLefLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodLefLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodLefLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + -3*q*LongLoad*t/8;
                        end 
                end

            case 'PatchTest.X'
                q = 1;      %N/mm2
                % Right Side
                NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),6);
                NodLoad(:,5) = 1;
                NodLoad(:,6) = 3;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                       end
                   end
                end
                NodLoad(:,5:6) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad/8;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad/8;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad/8;
                    R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad/8;
                end
                % Left Side
                NodLefLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                EleLefLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodLefLoad)
                    EleLefLoad = EleLefLoad + (sum(~(Elements - NodLefLoad(iLoad))'))';
                end
                EleLoad = find(EleLefLoad);
                NodLoad = zeros(length(EleLoad),5);
                NodLoad(:,5) = 1;
                NodLoad(:,6) = 3;
                for iLoad = 1:length(NodLefLoad)
                   [I,J] = find(Elements==NodLefLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodLefLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodLefLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                       end
                   end
                end
                NodLoad(:,5:6) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad/8;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad/8;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -3*q*LongLoad/8;
                    R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + -3*q*LongLoad/8;
                end 


            case 'PatchTest.Y'
                q = 1;      %N/mm2
                L1 = max(Nodes(:,1));
                R(1,2) = -q*L1/16;
                R(2,2) = -3*q*L1/16;
                R(3,2) = -3*q*L1/16;
                R(4,2) = -2*q*L1/16;
                R(13,2) = -3*q*L1/16;
                R(14,2) = -3*q*L1/16;
                R(15,2) = -q*L1/16;
                R(25,2) = q*L1/16;
                R(26,2) = 3*q*L1/16;
                R(27,2) = 3*q*L1/16;
                R(28,2) = 2*q*L1/16;
                R(31,2) = 3*q*L1/16;
                R(32,2) = 3*q*L1/16;
                R(33,2) = q*L1/16;


            case 'PatchTest.XY'
                q = 1;      %N/mm2
                L1 = max(Nodes(:,1));
                L2 = max(Nodes(:,2));
                R(1,1) = -q*L1/16;
                R(2,1) = -3*q*L1/16;
                R(3,1) = -3*q*L1/16;
                R(4,1) = -2*q*L1/16;
                R(13,1) = -3*q*L1/16;
                R(14,1) = -3*q*L1/16;
                R(15,1) = -q*L1/16;
                R(25,1) = q*L1/16;
                R(26,1) = 3*q*L1/16;
                R(27,1) = 3*q*L1/16;
                R(28,1) = 2*q*L1/16;
                R(31,1) = 3*q*L1/16;
                R(32,1) = 3*q*L1/16;
                R(33,1) = q*L1/16;
                R(1,2) = -q*L2/16;
                R(5,2) = -3*q*L2/16;
                R(7,2) = -3*q*L2/16;
                R(9,2) = -2*q*L2/16;
                R(21,2) = -3*q*L2/16;
                R(23,2) = -3*q*L2/16;
                R(25,2) = -q*L2/16;
                R(15,2) = q*L2/16;
                R(16,2) = 3*q*L2/16;
                R(17,2) = 3*q*L2/16;
                R(20,2) = 2*q*L2/16;
                R(29,2) = 3*q*L2/16;
                R(30,2) = 3*q*L2/16;
                R(33,2) = q*L2/16;
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    case 'Q16'
        
        switch Case
            case 'Final'
                switch Simetric
                    case 'Yes'
                        q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),5);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad*t/8;
                        end
                    case 'No'
                                                q = 1;      %N/mm2        
                        % Right Side
                        NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                        EleRigLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodRigLoad)
                            EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                        end
                        EleLoad = find(EleRigLoad);
                        NodLoad = zeros(length(EleLoad),5);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodRigLoad)
                           [I,J] = find(Elements==NodRigLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad*t/8;
                        end
                        % Left Side
                        NodLefLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                        EleLefLoad = zeros(size(Elements,1),1);
                        for iLoad = 1:length(NodLefLoad)
                            EleLefLoad = EleLefLoad + (sum(~(Elements - NodLefLoad(iLoad))'))';
                        end
                        EleLoad = find(EleLefLoad);
                        NodLoad = zeros(length(EleLoad),5);
                        NodLoad(:,5) = 1;
                        NodLoad(:,6) = 3;
                        for iLoad = 1:length(NodLefLoad)
                           [I,J] = find(Elements==NodLefLoad(iLoad));
                           for jLoad = 1:length(I)
                               if J <= 4
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodLefLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                               else
                                   NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodLefLoad(iLoad);
                                   NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                               end
                           end
                        end
                        NodLoad(:,5:6) = [];
                        for iEle = 1:length(EleLoad)
                            LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                            R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad*t/8;
                            R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad*t/8;
                            R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -3*q*LongLoad*t/8;
                            R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + -3*q*LongLoad*t/8;
                        end 
                end

            case 'PatchTest.X'
                q = 1;      %N/mm2
                % Right Side
                NodRigLoad = find(abs(Nodes(:,1) - Lmax) <1e-9);
                EleRigLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodRigLoad)
                    EleRigLoad = EleRigLoad + (sum(~(Elements - NodRigLoad(iLoad))'))';
                end
                EleLoad = find(EleRigLoad);
                NodLoad = zeros(length(EleLoad),6);
                NodLoad(:,5) = 1;
                NodLoad(:,6) = 3;
                for iLoad = 1:length(NodRigLoad)
                   [I,J] = find(Elements==NodRigLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodRigLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                       end
                   end
                end
                NodLoad(:,5:6) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + q*LongLoad/8;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + q*LongLoad/8;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + 3*q*LongLoad/8;
                    R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + 3*q*LongLoad/8;
                end
                % Left Side
                NodLefLoad = find(abs(Nodes(:,1) - 0) <1e-9);
                EleLefLoad = zeros(size(Elements,1),1);
                for iLoad = 1:length(NodLefLoad)
                    EleLefLoad = EleLefLoad + (sum(~(Elements - NodLefLoad(iLoad))'))';
                end
                EleLoad = find(EleLefLoad);
                NodLoad = zeros(length(EleLoad),5);
                NodLoad(:,5) = 1;
                NodLoad(:,6) = 3;
                for iLoad = 1:length(NodLefLoad)
                   [I,J] = find(Elements==NodLefLoad(iLoad));
                   for jLoad = 1:length(I)
                       if J <= 4
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),5)) = NodLefLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),5) = NodLoad(EleLoad==I(jLoad),5) + 1;
                       else
                           NodLoad(EleLoad==I(jLoad),NodLoad(EleLoad==I(jLoad),6)) = NodLefLoad(iLoad);
                           NodLoad(EleLoad==I(jLoad),6) = NodLoad(EleLoad==I(jLoad),6) + 1;
                       end
                   end
                end
                NodLoad(:,5:6) = [];
                for iEle = 1:length(EleLoad)
                    LongLoad = abs(Nodes(NodLoad(iEle,1),2) - Nodes(NodLoad(iEle,2),2));
                    R(NodLoad(iEle,1),1) = R(NodLoad(iEle,1),1) + -q*LongLoad/8;
                    R(NodLoad(iEle,2),1) = R(NodLoad(iEle,2),1) + -q*LongLoad/8;
                    R(NodLoad(iEle,3),1) = R(NodLoad(iEle,3),1) + -3*q*LongLoad/8;
                    R(NodLoad(iEle,4),1) = R(NodLoad(iEle,4),1) + -3*q*LongLoad/8;
                end 

            case 'PatchTest.Y'
                q = 1;      %N/mm2
                L1 = max(Nodes(:,1));
                R(1,2) = -q*L1/16;
                R(2,2) = -3*q*L1/16;
                R(3,2) = -3*q*L1/16;
                R(4,2) = -2*q*L1/16;
                R(17,2) = -3*q*L1/16;
                R(18,2) = -3*q*L1/16;
                R(19,2) = -q*L1/16;
                R(37,2) = q*L1/16;
                R(38,2) = 3*q*L1/16;
                R(39,2) = 3*q*L1/16;
                R(40,2) = 2*q*L1/16;
                R(47,2) = 3*q*L1/16;
                R(48,2) = 3*q*L1/16;
                R(49,2) = q*L1/16;

            case 'PatchTest.XY'
                q = 1;      %N/mm2
                L1 = max(Nodes(:,1));
                L2 = max(Nodes(:,2));
                R(1,1) = -q*L1/16;
                R(2,1) = -3*q*L1/16;
                R(3,1) = -3*q*L1/16;
                R(4,1) = -2*q*L1/16;
                R(17,1) = -3*q*L1/16;
                R(18,1) = -3*q*L1/16;
                R(19,1) = -q*L1/16;
                R(37,1) = q*L1/16;
                R(38,1) = 3*q*L1/16;
                R(39,1) = 3*q*L1/16;
                R(40,1) = 2*q*L1/16;
                R(47,1) = 3*q*L1/16;
                R(48,1) = 3*q*L1/16;
                R(49,1) = q*L1/16;
                R(1,2) = -q*L2/16;
                R(5,2) = -3*q*L2/16;
                R(9,2) = -3*q*L2/16;
                R(13,2) = -2*q*L2/16;
                R(29,2) = -3*q*L2/16;
                R(33,2) = -3*q*L2/16;
                R(37,2) = -q*L2/16;
                R(19,2) = q*L2/16;
                R(22,2) = 3*q*L2/16;
                R(25,2) = 3*q*L2/16;
                R(28,2) = 2*q*L2/16;
                R(43,2) = 3*q*L2/16;
                R(46,2) = 3*q*L2/16;
                R(49,2) = q*L2/16;
        end
        
end


R = reshape(R',[],1);

