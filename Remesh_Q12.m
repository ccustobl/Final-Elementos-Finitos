clear 
close all
clc
format short


%% Starting Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Starting Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')


%% User Parameters Selection

Case = 'Final';  %% 'Final' ; 'Plate' ; 'PatchTest'
Simetric = 'No';  %% 'Yes' ; 'No' 
TXT_Number = '405';  %Mesh Number%
Ref_R = 'Yes';  %% 'Yes' ; 'No'
Ref_R_Number = '2'; 


%% TXT Loading

switch Case
    case 'Final'
        switch Simetric
            case 'Yes'
                switch Ref_R
                    case 'Yes'
                        Nodes_Q4 = load(strcat(['TXT/Half/Nodes_Q4_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4); 
                        Elements_Q4 = load(strcat(['TXT/Half/Elements_Q4_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                    case 'No'
                        Nodes_Q4 = load(strcat(['TXT/Half/Nodes_Q4_Q16_',num2str(TXT_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4);
                        Elements_Q4 = load(strcat(['TXT/Half/Elements_Q4_Q16_',num2str(TXT_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                end
            case 'No'
                switch Ref_R
                    case 'Yes'
                        Nodes_Q4 = load(strcat(['TXT/Full/Nodes_Full_Q4_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4); 
                        Elements_Q4 = load(strcat(['TXT/Full/Elements_Full_Q4_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                    case 'No'
                        Nodes_Q4 = load(strcat(['TXT/Full/Nodes_Full_Q4_Q16_',num2str(TXT_Number),'.txt']));
                        Nodes_Q4 = Nodes_Q4(:,3:4);
                        Elements_Q4 = load(strcat(['TXT/Full/Elements_Full_Q4_Q16_',num2str(TXT_Number),'.txt']));
                        Elements_Q4 = Elements_Q4(:,2:5);
                end
        end
        
    case 'PatchTest'
        Nodes_Q4 = load(strcat('TXT/PatchTest/Nodes_Q4_Q12_PatchTest.txt'));
        Nodes_Q4 = Nodes_Q4(:,3:4); 
        Elements_Q4 = load(strcat('TXT/PatchTest/Elements_Q4_Q12_PatchTest.txt'));
        Elements_Q4 = Elements_Q4(:,2:5);
        
    case 'Plate'
                
end


%% Mesh Graph

% if ((strcmp(Case,'Final')==1 && str2double(TXT_Number)<7) || strcmp(Case,'Plate')==1 || strcmp(Case,'PatchTest')==1)
%     figure('Name','Mesh','NumberTitle','off')
%     for iNod = 1:length(Nodes_Q4)
%         text(Nodes_Q4(iNod,1)+0.05,Nodes_Q4(iNod,2)+0.05,num2str(iNod));
%     end
%     graph_meshplot(Elements_Q4,Nodes_Q4,'b')
%     title('Mesh','fontsize',13)
% end


%% Node Naming

% switch Case
%     case 'Final'
%         switch Simetric
%             case 'Yes'
%                 % Node_A: (0,0)
%                 Node_A = find(abs(Nodes_Q4(:,1)-0)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_B: (20,0)
%                 Node_B = find(abs(Nodes_Q4(:,1)-20)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_C: (50,0)
%                 Node_C = find(abs(Nodes_Q4(:,1)-50)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_D: (0,15)
%                 Node_D = find(abs(Nodes_Q4(:,1)-0)<1e-9 & abs(Nodes_Q4(:,2)-15)<1e-9);
% 
%                 % Node_E: (3.535533905933 , 16.464466094067)
%                 Node_E = find(abs(Nodes_Q4(:,1)-3.535533905933)<1e-7 & abs(Nodes_Q4(:,2)-16.464466094067)<1e-7);
% 
%                 % Node_F: (5,20)
%                 Node_F = find(abs(Nodes_Q4(:,1)-5)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_G: (20,20)
%                 Node_G = find(abs(Nodes_Q4(:,1)-20)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_H: (50,20)
%                 Node_H = find(abs(Nodes_Q4(:,1)-50)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_I: (5,30)
%                 Node_I = find(abs(Nodes_Q4(:,1)-5)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_J: (20,30)
%                 Node_J = find(abs(Nodes_Q4(:,1)-20)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_K: (50,30)
%                 Node_K = find(abs(Nodes_Q4(:,1)-50)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%             case 'No'
%                 % Node_AA: (0,0)
%                 Node_AA = find(abs(Nodes_Q4(:,1)-0)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_AB: (30,0)
%                 Node_AB = find(abs(Nodes_Q4(:,1)-30)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_AC: (50,0)
%                 Node_AC = find(abs(Nodes_Q4(:,1)-50)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_AD: (70,0)
%                 Node_AD = find(abs(Nodes_Q4(:,1)-70)<1e-9 & abs(Nodes_Q4(:,2)-0)<1e-9);
% 
%                 % Node_AE: (100,0)
%                 Node_AE = find(abs(Nodes_Q4(:,1)-100)<1e-7 & abs(Nodes_Q4(:,2)-0)<1e-7);
% 
%                 % Node_BA: ( 46.464466094067 , 16.464466094067 )
%                 Node_BA = find(abs(Nodes_Q4(:,1)-46.464466094067)<1e-9 & abs(Nodes_Q4(:,2)-16.464466094067)<1e-9);
%                 
%                 % Node_BB: (50,15)
%                 Node_BB = find(abs(Nodes_Q4(:,1)-50)<1e-9 & abs(Nodes_Q4(:,2)-15)<1e-9);
%                 
%                 % Node_BC: ( 53.535533905933 , 16.464466094067 )
%                 Node_BC = find(abs(Nodes_Q4(:,1)-53.535533905933)<1e-9 & abs(Nodes_Q4(:,2)-16.464466094067)<1e-9);
% 
%                 % Node_CA: (0,20)
%                 Node_CA = find(abs(Nodes_Q4(:,1)-0)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_CB: (30,20)
%                 Node_CB = find(abs(Nodes_Q4(:,1)-30)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_CC: (45,20)
%                 Node_CC = find(abs(Nodes_Q4(:,1)-45)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_CD: (55,20)
%                 Node_CD = find(abs(Nodes_Q4(:,1)-55)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_CE: (70,20)
%                 Node_CE = find(abs(Nodes_Q4(:,1)-70)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_CF: (100,20)
%                 Node_CF = find(abs(Nodes_Q4(:,1)-100)<1e-9 & abs(Nodes_Q4(:,2)-20)<1e-9);
% 
%                 % Node_DA: (0,30)
%                 Node_DA = find(abs(Nodes_Q4(:,1)-0)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_DB: (30,30)
%                 Node_DB = find(abs(Nodes_Q4(:,1)-30)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_DC: (45,30)
%                 Node_DC = find(abs(Nodes_Q4(:,1)-45)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_DD: (55,30)
%                 Node_DD = find(abs(Nodes_Q4(:,1)-55)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_DE: (70,30)
%                 Node_DE = find(abs(Nodes_Q4(:,1)-70)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
% 
%                 % Node_DF: (100,30)
%                 Node_DF = find(abs(Nodes_Q4(:,1)-100)<1e-9 & abs(Nodes_Q4(:,2)-30)<1e-9);
%         end
% 
%     case 'PatchTest'
%         
%     case 'Plate'
%         
% end

%% Triangle Detection

% if sum(Elements_Q4(:,4)==0) == 0
%     disp('No Triangles present in the Mesh.')
% else
%     error('Triangles present in the Mesh.')       
% end


%% Incorrect Number of Nodes Detection

% NumNod = 0;
% switch Case
%     case 'Final'
%         switch Simetric
%             case 'Yes'
%                 NumNod = zeros(15,1);
%                 Line = [ Node_F Node_E ; Node_E Node_D ; Node_B Node_A ; Node_C Node_B ; Node_D Node_A ; Node_E Node_B ; Node_G Node_B ; Node_H Node_C ; Node_F Node_G ; Node_H Node_G ; Node_I Node_F ; Node_J Node_G ; Node_K Node_H ; Node_J Node_I ; Node_K Node_J ]; 
%                 for iLoop = 1:15
%                     if (Line(iLoop,1)-Line(iLoop,2))/3 == floor((Line(iLoop,1)-Line(iLoop,2))/3)
%                     else
%                         NumNod(iLoop,1) = 1;
%                     end
%                 end
% 
%             case 'No'
%                 NumNod = zeros(29,1);
%                 Line = [ Node_AA Node_AB ; Node_CA Node_CB ; Node_DA Node_DB ; Node_AD Node_AE ; Node_CE Node_CF ; Node_DE Node_DF ; Node_AB Node_AC ; Node_BA Node_BB ; Node_AC Node_AD ; Node_BB Node_BC ; Node_AA Node_CA ; Node_AB Node_CB ; Node_BA Node_CC ; Node_BC Node_CD ; Node_AD Node_CE ; Node_AE Node_CF ; Node_CA Node_BA ; Node_CB Node_DB ; Node_CC Node_DC ; Node_CD Node_DD ; Node_CE Node_DE ; Node_CF Node_DF ; Node_DB Node_DC ; Node_CB Node_CC ; Node_AB Node_BA ; Node_AC Node_BB ; Node_BC Node_AD ; Node_CD Node_CE ; Node_DD Node_DE ]; 
%                 for iLoop = 1:29
%                     if (Line(iLoop,1)-Line(iLoop,2))/3 == floor((Line(iLoop,1)-Line(iLoop,2))/3)                       
%                     elseif (iLoop==7 || iLoop==17 || iLoop==18 || iLoop==24 || iLoop==25 || iLoop==10) && (Line(iLoop,1)-Line(iLoop,2)-2)/3 == floor((Line(iLoop,1)-Line(iLoop,2))/3)
%                     elseif (iLoop==27 || iLoop==28 || iLoop==29) && (Line(iLoop,1)-Line(iLoop,2)-1)/3 == floor((Line(iLoop,1)-Line(iLoop,2))/3)
%                     else
%                         NumNod(iLoop,1) = 1;
%                     end
%                 end
%         end
%         
%     case 'PatchTest'
%         
%     case 'Plate'
%         
% end
% 
% if sum(NumNod)==0
%     disp('Correct Number of Nodes in the mesh.')
% else
%     error('Incorrect Number of Nodes in the mesh.')
% end


%% Remesh

% Elements
Ind = ones(size(Elements_Q4,1),1);
Elements = zeros(size(Elements_Q4,1)/9,12);
for iLoop = 1:size(Elements_Q4,1)/9
    if iLoop == 1
        I = 1;
    else
        I = find(Ind==1,1);
    end
    Elements(iLoop,[1 5 12]) = Elements_Q4(I,[1 2 4]);
    Elements(iLoop,9) = Elements_Q4(I+1,2);
    Elements(iLoop,[2 6]) = Elements_Q4(I+2,2:3);
    Ind([I I+1 I+2],:) = 0;
    
    J = find(Elements_Q4(:,1)==Elements(iLoop,12) & Ind==1,1);
    Elements(iLoop,8) = Elements_Q4(J,4);
    Elements(iLoop,10) = Elements_Q4(J+2,3);
    Ind([J J+1 J+2],:) = 0;
    
    K = find(Elements_Q4(:,1)==Elements(iLoop,8) & Ind==1,1);
    Elements(iLoop,[11 4]) = Elements_Q4(K,3:4);
    Elements(iLoop,7) = Elements_Q4(K+1,3);
    Elements(iLoop,3) = Elements_Q4(K+2,3);
    Ind([K K+1 K+2],:) = 0;
end
disp('Elements COMPLETED')

% Nodes
Nodes = Nodes_Q4;
Elements_1 = Elements;
nEle = size(Elements,1);
nNod = size(Nodes_Q4,1);
counter = 0;
for iNod = 1:nNod
    [I,J] = find(Elements_1 == iNod);
    nShare = length(I);
    if nShare == 0
        Nodes(iNod-counter,:) = [];
        [I,J] = find(Elements >= iNod-counter);
        for iLoop = 1:length(I)
            Elements(I(iLoop),J(iLoop)) = Elements(I(iLoop),J(iLoop))-1;
        end
        counter = counter+1;
    end

end
disp('Nodes COMPLETED')


%% Meshplot

% if ((strcmp(Case,'Final')==1 && str2double(TXT_Number)< 7) || strcmp(Case,'Plate')==1 || strcmp(Case,'PatchTest')==1)
%     figure('Name','Mesh','NumberTitle','off')
%     for iNod = 1:length(Nodes)
%         text(Nodes(iNod,1)+0.05,Nodes(iNod,2)+0.05,num2str(iNod));
%     end
%     graph_meshplot(Elements,Nodes,'b')
%     title('Mesh','fontsize',13)
% end


%% Save

switch Case
    case 'Final'
        switch Simetric
            case 'Yes'
                switch Ref_R
                    case 'Yes'
                        save(strcat(['TXT/Half/Elements_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Elements')
                        save(strcat(['TXT/Half/Nodes_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Nodes')
                        disp('Elements and Nodes SAVED')
                    case 'No'
                        save(strcat(['TXT/Half/Elements_Q12_',num2str(TXT_Number),'.mat']),'Elements')
                        save(strcat(['TXT/Half/Nodes_Q12_',num2str(TXT_Number),'.mat']),'Nodes')
                        disp('Elements and Nodes SAVED')
                end

            case 'No'
                switch Ref_R
                    case 'Yes'
                        save(strcat(['TXT/Full/Elements_Full_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Elements')
                        save(strcat(['TXT/Full/Nodes_Full_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']),'Nodes')
                        disp('Elements and Nodes SAVED')
                    case 'No'
                        save(strcat(['TXT/Full/Elements_Full_Q12_',num2str(TXT_Number),'.mat']),'Elements')
                        save(strcat(['TXT/Full/Nodes_Full_Q12_',num2str(TXT_Number),'.mat']),'Nodes')
                        disp('Elements and Nodes SAVED')
                end
        end
        
    case 'PatchTest'
        save(strcat('TXT/PatchTest/Elements_Q12_PatchTest.mat'),'Elements')
        save(strcat('TXT/PatchTest/Nodes_Q12_PatchTest.mat'),'Nodes')
        
    case 'Plate'
        save(strcat('TXT/Plate/Elements_Plate_Q12.mat'),'Elements')
        save(strcat('TXT/Plate/Nodes_Plate_Q12.mat'),'Nodes')
end


%% Finishing Time
disp('----------------------------------------')
[hours,minutes,seconds] = calc_time();
disp(strcat(['Finishing Time: ',hours,':',minutes,':',seconds]))
disp('----------------------------------------')

