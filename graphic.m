function graphic(Simetric,Material,TXT_Number,Case,Elements,Nodes,DCG,StrAvg,eta_el,U2_el,e2_el)

Dots = 'No';

if strcmp(Dots,'Yes')==1
    switch Material
        case 'Orthotropic'        
            HE_Points_X = [ 33.44 68.59 45 55 45 55 37.5 62.5 50.53 ];
            HE_Points_Y = [ 0 0 30 30 22.03 23.44 30 30 5.103 ];

        case 'Isotropic'
            HE_Points_X = [ 34.3 65.7 45 55 45 55 37.5 62.5 50 ];
            HE_Points_Y = [ 0 0 30 30 22.03 22.03 30 30 5.103 ];
    end 
end


if str2double(TXT_Number)<=7 || strcmp(Case(1:5),'Patch')==1
    
    tic

    % Initial & Displaced Structure
    figure('Name','Initial & Displaced Structure','NumberTitle','off')
    hold on
    graph_meshplot(Elements,Nodes,'b')
    graph_meshplot(Elements,DCG,'r')
    hold off
    
    switch Case
        case 'Final'
            
        case 'Plate'
            
        case 'PatchTest.X'
            axis([ -0.25 2.5 -0.25 2.25 ])
        case 'PatchTest.Y'
            axis([ -0.25 2.25 -0.25 2.5 ])
        case 'PatchTest.XY'
            axis([ -0.25 2.5  -0.25 2.25 ])
    end
    title('Initial & Displaced Structure')
    
    % Mesh
    figure('Name','Mesh','NumberTitle','off')
    for iNod = 1:length(Nodes)
        text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod));
    end    
    graph_meshplot(Elements,Nodes,'b')
    title('Mesh','fontsize',13)
    
    % Stress
    switch Case
        case 'Final' 
          
            % Avg Stress_XX in the SC
            figure('Name','\sigma_X_X Mejorado [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,1),[],'none',13,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar('fontsize',13)
            title('\sigma_X_X Mejorado [MPa]','fontsize',13)
            
            % Avg Stress_YY in the SC
            figure('Name','\sigma_Y_Y Mejorado [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,2),[],'none',13,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar('fontsize',13)
            title('\sigma_Y_Y Mejorado [MPa]','fontsize',13)
            
            % Avg Stress_XY in the SC
            figure('Name','\tau_X_Y Mejorado [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,3),[],'none',20,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar('fontsize',13)
            title('\tau_X_Y Mejorado [MPa]','fontsize',13)
            
            % Von Mises
            figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'none',20,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar('fontsize',13)
            title('Isótropo : \sigma_V_M [MPa]','fontsize',13)
            
            % Elemental Error
            figure('Name','Elemental Error','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Elemental Error','fontsize',13)
            
            % Deformation Energy
            figure('Name','Deformation Energy','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,U2_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Deformation Energy','fontsize',13)
            
            % Error Energy
            figure('Name','Error Energy','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,e2_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Error Energy','fontsize',13)
            
            
            
        case 'Plate'
            % Avg Stress_XX in the SC
            figure('Name','Avg \sigma_X_X in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,1),[],'k',13,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Avg \sigma_X_X in the SC [MPa]','fontsize',13)
            
            % Avg Stress_YY in the SC
            figure('Name','Avg \sigma_Y_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,2),[],'k',13,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Avg \sigma_Y_Y in the SC [MPa]','fontsize',13)
            
            % Avg Stress_XY in the SC
            figure('Name','Avg \tau_X_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,3),[],'k',20,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Avg \tau_X_Y in the SC [MPa]','fontsize',13)
            
            % Von Mises
            figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'k',20,'interp')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('\sigma_V_M [MPa]','fontsize',13)
            
            % Elemental Error
            figure('Name','Elemental Error','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Elemental Error','fontsize',13)
            
            % Deformation Energy
            figure('Name','Deformation Energy','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,U2_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Deformation Energy','fontsize',13)
            
            % Error Energy
            figure('Name','Error Energy','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,e2_el,[],'k',[],'flat')
            switch Simetric
                case'Yes'
                    axis([ 0 50 0 30 ])
                case 'No'
                    axis([ 0 100 0 30 ])
            end
            colorbar
            title('Error Energy','fontsize',13)
            
        case 'PatchTest.X'
            % Avg Stress_XX in the SC
            figure('Name','Avg \sigma_X_X in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,1),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_X_X in the SC [MPa]','fontsize',13)
            
            % Avg Stress_YY in the SC
            figure('Name','Avg \sigma_Y_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,2),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_Y_Y in the SC [MPa]','fontsize',13)
            
            % Avg Stress_XY in the SC
            figure('Name','Avg \tau_X_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,3),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \tau_X_Y in the SC [MPa]','fontsize',13)
            
            % Von Mises
            figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('\sigma_V_M [MPa]','fontsize',13)
            
            % Elemental Error
            figure('Name','Elemental Error','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
            colorbar
            title('Elemental Error','fontsize',13)
            
            % \sigma_X_X [MPa]
            figure('Name','\sigma_X_X [MPa]','NumberTitle','off')
            hold on
            graph_scalarbandplot(Elements,DCG,StrAvg(:,1),[],'r',3,'interp')
            for iNod = 1:length(Nodes)
                text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod),'FontSize',14);
            end    
            graph_meshplot(Elements,Nodes,'b')            
            hold off
            colorbar('fontsize',11)
            axis([ -0.25 2.75 -0.25 2.25 ])
            title('\sigma_X_X','fontsize',16)
            
            
        case 'PatchTest.Y'
            % Avg Stress_XX in the SC
            figure('Name','Avg \sigma_X_X in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,1),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_X_X in the SC [MPa]','fontsize',13)
            
            % Avg Stress_YY in the SC
            figure('Name','Avg \sigma_Y_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,2),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_Y_Y in the SC [MPa]','fontsize',13)
            
            % Avg Stress_XY in the SC
            figure('Name','Avg \tau_X_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,3),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \tau_X_Y in the SC [MPa]','fontsize',13)
            
            % Von Mises
            figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('\sigma_V_M [MPa]','fontsize',13)
            
            
            % Elemental Error
            figure('Name','Elemental Error','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
            colorbar
            title('Elemental Error','fontsize',13)
            
            % \sigma_Y_Y [MPa]
            figure('Name','\sigma_Y_Y [MPa]','NumberTitle','off')
            hold on
            graph_scalarbandplot(Elements,DCG,StrAvg(:,2),[],'r',3,'interp')
            for iNod = 1:length(Nodes)
                text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod),'FontSize',14);
            end    
            graph_meshplot(Elements,Nodes,'b')            
            hold off
            colorbar('fontsize',11)
            axis([ -0.25 2.25 -0.25 2.75 ])
            title('\sigma_Y_Y','fontsize',16)
            
            
        case 'PatchTest.XY'
            % Avg Stress_XX in the SC
            figure('Name','Avg \sigma_X_X in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,1),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_X_X in the SC [MPa]','fontsize',13)
            
            % Avg Stress_YY in the SC
            figure('Name','Avg \sigma_Y_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,2),[],'k',20,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \sigma_Y_Y in the SC [MPa]','fontsize',13)
            
            % Avg Stress_XY in the SC
            figure('Name','Avg \tau_X_Y in the SC [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,3),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('Avg \tau_X_Y in the SC [MPa]','fontsize',13)
            
            % Von Mises
            figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'k',3,'interp')
            axis([ 0 2 0 2 ])
            colorbar
            title('\sigma_V_M [MPa]','fontsize',13)            
            
            % Elemental Error
            figure('Name','Elemental Error','NumberTitle','off')
            graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat')
            colorbar
            title('Elemental Error','fontsize',13)
            
            % \tau_X_Y
            figure('Name','\tau_X_Y','NumberTitle','off')
            hold on
            graph_scalarbandplot(Elements,DCG,StrAvg(:,3),[],'r',3,'interp')
            for iNod = 1:length(Nodes)
                text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod),'FontSize',14);
            end    
            graph_meshplot(Elements,Nodes,'b')            
            hold off
            colorbar('fontsize',11)
            axis([ -0.25 3.5  -0.25 2.25 ])
            title('\tau_X_Y','fontsize',16)
                        
    end
    
    disp('Graphs:')
    toc
    
    
else
    tic
    
    % Von Mises
    figure('Name','\sigma_V_M [MPa]','NumberTitle','off')
    hold on
    graph_scalarbandplot(Elements,Nodes,StrAvg(:,4),[],'none',20,'interp')
    switch Simetric
        case'Yes'
            axis([ 0 50 0 30 ])
        case 'No'
            axis([ 0 100 0 30 ])
    end
    if strcmp(Dots,'Yes')==1
        scatter(HE_Points_X,HE_Points_Y,'Marker','o','MarkerEdgeColor','r','MarkerFaceColor','r')
    end
    hold off
    colorbar
    title('\sigma_V_M [MPa]','fontsize',13)
    
    % Elemental Error
    figure('Name','Elemental Error','NumberTitle','off')
    graph_scalarbandplot(Elements,Nodes,eta_el,[],'k',[],'flat');
    switch Simetric
        case'Yes'
            axis([ 0 50 0 30 ])
        case 'No'
            axis([ 0 100 0 30 ])
    end
    colorbar
    title('Elemental Error','fontsize',13)
    
    % Deformation Energy
    figure('Name','Deformation Energy','NumberTitle','off')
    graph_scalarbandplot(Elements,Nodes,U2_el,[],'k',[],'flat')
    switch Simetric
        case'Yes'
            axis([ 0 50 0 30 ])
        case 'No'
            axis([ 0 100 0 30 ])
    end
    colorbar
    title('Deformation Energy','fontsize',13)

    % Error Energy
    figure('Name','Error Energy','NumberTitle','off')
    graph_scalarbandplot(Elements,Nodes,e2_el,[],'k',[],'flat')
    switch Simetric
        case'Yes'
            axis([ 0 50 0 30 ])
        case 'No'
            axis([ 0 100 0 30 ])
    end
    colorbar
    title('Error Energy','fontsize',13)
    
    disp('Graphs:')
    toc

end