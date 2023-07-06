clear 
close all
clc
format short


%% User Parameters Selection

Case = 'Rectangulo';  %% 'Final' ; 'Plate' ; 'PatchTest' ; 'Rectangulo'
Simetric = 'No';  %% 'Yes' ; 'No' 
TXT_Number = '1';  %Mesh Number%
Ref_R = 'No';  %% 'Yes' ; 'No'
Ref_R_Number = '1';


%% TXT Loading

switch Case
    case 'Final'
        switch Simetric
            case 'Yes'
                switch Ref_R
                    case 'Yes'
                        Nodes_Q4 = load(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4); 
                        Elements_Q4 = load(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                    case 'No'
                        Nodes_Q4 = load(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4);
                        Elements_Q4 = load(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                end
            case 'No'
                switch Ref_R
                    case 'Yes'
                        Nodes_Q4 = load(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4); 
                        Elements_Q4 = load(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                    case 'No'
                        Nodes_Q4 = load(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4);
                        Elements_Q4 = load(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                end
        end
        
    case 'PatchTest'
        
    case 'Plate'
        
    case 'Rectangulo'
        Nodes_Q4 = load(strcat(['TXT/Rectangulo/Nodes_Rect_Q4_',num2str(TXT_Number),'.txt']));
        Nodes_Q4 = Nodes_Q4(:,3:4);
        Elements_Q4 = load(strcat(['TXT/Rectangulo/Elements_Rect_Q4_',num2str(TXT_Number),'.txt']));
        Elements_Q4 = Elements_Q4(:,2:5);
                
        Nodes_Q4_Base = load(strcat('TXT/Rectangulo/Nodes_Rect_Q4_',num2str(TXT_Number),'.txt'));
        Nodes_Q4_Base = Nodes_Q4_Base(:,3:4);
        Elements_Q4_Base = load(strcat('TXT/Rectangulo/Elements_Rect_Q4_0.txt'));
        Elements_Q4_Base = Elements_Q4_Base(:,2:5);
end


%% Remesh Horizontal to the Right

% Vertical Start and Finish
Node_A_Loc = [0 0];
Node_A = find(abs(Nodes_Q4(:,1)-Node_A_Loc(1,1))<1e-9 & abs(Nodes_Q4(:,2)-Node_A_Loc(1,2))<1e-9);
Node_B_Loc = [0 9];
Node_B = find(abs(Nodes_Q4(:,1)-Node_B_Loc(1,1))<1e-9 & abs(Nodes_Q4(:,2)-Node_B_Loc(1,2))<1e-9);



%% Mesh Graph

% if ((strcmp(Case,'Final')==1 && str2double(TXT_Number)<7) || strcmp(Case,'Plate')==1 || strcmp(Case,'PatchTest')==1)
%     figure('Name','Mesh','NumberTitle','off')
%     for iNod = 1:length(Nodes_Q4)
%         text(Nodes_Q4(iNod,1)+0.05,Nodes_Q4(iNod,2)+0.05,num2str(iNod));
%     end
%     graph_meshplot(Elements_Q4,Nodes_Q4,'b')
%     title('Mesh','fontsize',13)
% end

%% Save

% switch Case
%     case 'Final'
%         switch Simetric
%             case 'Yes'
%                 switch Ref_R
%                     case 'Yes'
%                         save(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Elements')
%                         save(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Nodes')
%                         disp('Elements and Nodes SAVED')
%                     case 'No'
%                         save(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'.mat']),'Elements')
%                         save(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'.mat']),'Nodes')
%                         disp('Elements and Nodes SAVED')
%                 end
% 
%             case 'No'
%                 switch Ref_R
%                     case 'Yes'
%                         save(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Elements')
%                         save(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Nodes')
%                         disp('Elements and Nodes SAVED')
%                     case 'No'
%                         save(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'.mat']),'Elements')
%                         save(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'.mat']),'Nodes')
%                         disp('Elements and Nodes SAVED')
%                 end
%         end
%         
%     case 'PatchTest'
%         
%     case 'Plate'
%         
%     case 'Rectangulo'
%             save(strcat(['TXT/Rect/Elements_Full_Q4_',num2str(TXT_Number),'.mat']),'Elements')
%             save(strcat(['TXT/Rect/Nodes_Full_Q4_',num2str(TXT_Number),'.mat']),'Nodes')
%             disp('Elements and Nodes SAVED')        
% 
% end

