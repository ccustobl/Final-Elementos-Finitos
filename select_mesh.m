function [Nodes,Elements] = select_mesh(Ele_Type,Case,Simetric,TXT_Number,Ref_R,Ref_R_Number,Borders)

switch Ele_Type
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    case 'Q4'
        switch Case    
            case 'Final'
                switch Simetric
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:5);
                            case 'No'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q4_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q4_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:5);                
                        end
                    case 'No'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:5);
                            case 'No'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q4_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q4_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:5);                
                        end
                end
                        
            case 'PatchTest.X'
                Nodes = [ 0.0  0.0
                          1.0  0.0
                          2.0  0.0
                          0.0  1.0
                          1.25 0.75
                          2.0  1.0
                          0.0  2.0
                          1.0  2.0
                          2.0  2.0 ];
                Elements = [ 1  2  5  4
                            2  3  6  5
                            5  6  9  8
                            4  5  8  7 ];
            case 'PatchTest.Y'
                Nodes = [ 0.0  0.0
                          1.0  0.0
                          2.0  0.0
                          0.0  1.0
                          1.25 0.75
                          2.0  1.0
                          0.0  2.0
                          1.0  2.0
                          2.0  2.0 ];
                Elements = [ 1  2  5  4
                            2  3  6  5 
                            4  5  8  7
                            5  6  9  8];
            case 'PatchTest.XY'
                Nodes = [ 0.0  0.0
                          1.0  0.0
                          2.0  0.0
                          0.0  1.0
                          1.25 0.75
                          2.0  1.0
                          0.0  2.0
                          1.0  2.0
                          2.0  2.0 ];
                Elements = [ 1  2  5  4
                            2  3  6  5 
                            4  5  8  7
                            5  6  9  8];
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    case 'Q8'        
        switch Case
            case 'Final'
                switch Simetric
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q8_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q8_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:9);
                            case 'No'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q8_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q8_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:9);                
                        end

                    case 'No'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q8_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q8_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:9);
                            case 'No'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q8_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q8_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:9);                
                        end
                end
                
            case 'Plate'                
                Nodes = load(strcat(['TXT/Plate/Nodes_Plate_Q8_',num2str(TXT_Number),'.txt']));
                Nodes = Nodes(:,3:4);                
                Elements = load(strcat(['TXT/Plate/Elements_Plate_Q8_',num2str(TXT_Number),'.txt']));
                Elements = Elements(:,2:9);
                                
            case 'PatchTest.X'
                if strcmp(Borders,'Straight')==1
        %             Nodes = load('TXT/PatchTest/Nodes_Q8_PatchTest.txt');
        %             Nodes = Nodes(:,3:4);
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.125 0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 0.875
                              1.25  0.75
                              1.625 0.875
                              2.0   1.0
                              0.0   1.5
                              1.125 1.375
                              2.0   1.5                  
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                elseif strcmp(Borders,'Curved')==1
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.0   0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 1.0
                              1.25  0.75
                              1.625 0.75
                              2.0   1.0
                              0.0   1.5
                              1.0   1.375
                              2.0   1.5
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                end  
        %         Elements = load('TXT/PatchTest/Elements_Q8_PatchTest.txt');
        %         Elements = Elements(:,2:9);
                Elements = [ 1   3  11   9   2   7  10   6 
                             3   5  13  11   4   8  12   7
                            11  13  21  19  12  16  20  15
                             9  11  19  17  10  15  18  14 ];

            case 'PatchTest.Y'
                if strcmp(Borders,'Straight')==1
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.125 0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 0.875
                              1.25  0.75
                              1.625 0.875
                              2.0   1.0
                              0.0   1.5
                              1.125 1.375
                              2.0   1.5                  
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                elseif strcmp(Borders,'Curved')==1
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.0   0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 1.0
                              1.25  0.75
                              1.625 0.75
                              2.0   1.0
                              0.0   1.5
                              1.0   1.375
                              2.0   1.5
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                end 
                Elements = [ 1   3  11   9   2   7  10   6 
                             3   5  13  11   4   8  12   7
                            11  13  21  19  12  16  20  15
                             9  11  19  17  10  15  18  14 ];

            case 'PatchTest.XY'
                if strcmp(Borders,'Straight')==1
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.125 0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 0.875
                              1.25  0.75
                              1.625 0.875
                              2.0   1.0
                              0.0   1.5
                              1.125 1.375
                              2.0   1.5                  
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                elseif strcmp(Borders,'Curved')==1
                    Nodes = [ 0.0   0.0
                              0.5   0.0
                              1.0   0.0
                              1.5   0.0
                              2.0   0.0
                              0.0   0.5
                              1.0   0.375
                              2.0   0.5
                              0.0   1.0
                              0.625 1.0
                              1.25  0.75
                              1.625 0.75
                              2.0   1.0
                              0.0   1.5
                              1.0   1.375
                              2.0   1.5
                              0.0   2.0
                              0.5   2.0
                              1.0   2.0
                              1.5   2.0
                              2.0   2.0 ];
                end 
                Elements = [ 1   3  11   9   2   7  10   6 
                             3   5  13  11   4   8  12   7
                            11  13  21  19  12  16  20  15
                             9  11  19  17  10  15  18  14 ];
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Q9'
        switch Case
           case 'Final'
                switch Simetric 
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q9_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q9_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:10);
                            case 'No'
                                Nodes = load(strcat(['TXT/Half/Nodes_Q9_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Half/Elements_Q9_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:10);                
                        end
                    case 'No'
                        switch Ref_R
                            case 'Yes'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q9_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q9_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.txt']));
                                Elements = Elements(:,2:10);
                            case 'No'
                                Nodes = load(strcat(['TXT/Full/Nodes_Full_Q9_',num2str(TXT_Number),'.txt']));
                                Nodes = Nodes(:,3:4);                
                                Elements = load(strcat(['TXT/Full/Elements_Full_Q9_',num2str(TXT_Number),'.txt']));
                                Elements = Elements(:,2:10);                
                        end
                end
                
                    case 'Plate'                
                        Nodes = load(strcat(['TXT/Plate/Nodes_Plate_Q9_',num2str(TXT_Number),'.txt']));
                        Nodes = Nodes(:,3:4);                
                        Elements = load(strcat(['TXT/Plate/Elements_Plate_Q9_',num2str(TXT_Number),'.txt']));
                        Elements = Elements(:,2:9);

                    case 'PatchTest.X'
                        if strcmp(Borders,'Straight')==1
                            Nodes = load('TXT/PatchTest/Nodes_Q9_PatchTest.txt');
                            Nodes = Nodes(:,3:4);
                        elseif strcmp(Borders,'Curved')==1

                        end  
                        Elements = load('TXT/PatchTest/Elements_Q9_PatchTest.txt');
                        Elements = Elements(:,2:10);

                    case 'PatchTest.Y'
                        if strcmp(Borders,'Straight')==1
                            Nodes = load('TXT/PatchTest/Nodes_Q9_PatchTest.txt');
                            Nodes = Nodes(:,3:4);            
                        elseif strcmp(Borders,'Curved')==1

                        end 
                        Elements = load('TXT/PatchTest/Elements_Q9_PatchTest.txt');
                        Elements = Elements(:,2:10);

                    case 'PatchTest.XY'
                        if strcmp(Borders,'Straight')==1
                            Nodes = load('TXT/PatchTest/Nodes_Q9_PatchTest.txt');
                            Nodes = Nodes(:,3:4);            
                        elseif strcmp(Borders,'Curved')==1

                        end 
                        Elements = load('TXT/PatchTest/Elements_Q9_PatchTest.txt');
                        Elements = Elements(:,2:10);
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    case 'Q12'
        switch Case
            case 'Final'
                switch Simetric 
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                Nodes = matfile(strcat(['TXT/Half/Nodes_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Half/Elements_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Elements = Elements.Elements;
                            case 'No'
                                Nodes = matfile(strcat(['TXT/Half/Nodes_Q12_',num2str(TXT_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Half/Elements_Q12_',num2str(TXT_Number),'.mat']));
                                Elements = Elements.Elements;
                        end
                    case 'No'
                       switch Ref_R
                            case 'Yes'
                                Nodes = matfile(strcat(['TXT/Full/Nodes_Full_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Full/Elements_Full_Q12_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Elements = Elements.Elements;
                            case 'No'
                                Nodes = matfile(strcat(['TXT/Full/Nodes_Full_Q12_',num2str(TXT_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Full/Elements_Full_Q12_',num2str(TXT_Number),'.mat']));
                                Elements = Elements.Elements;
                        end 
                end
                
            case 'PatchTest.X'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end  
                Elements = matfile('TXT/PatchTest/Elements_Q12_PatchTest.mat');
                Elements = Elements.Elements;

            case 'PatchTest.Y'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = load('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end 
                Elements = matfile('TXT/PatchTest/Elements_Q12_PatchTest.mat');
                Elements = Elements.Elements;

            case 'PatchTest.XY'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q12_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end 
                Elements = matfile('TXT/PatchTest/Elements_Q12_PatchTest.mat');
                Elements = Elements.Elements;
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Q16 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    case 'Q16'
        switch Case    
            case 'Final'
                switch Simetric
                    case 'Yes'
                        switch Ref_R
                            case 'Yes'
                                Nodes = matfile(strcat(['TXT/Half/Nodes_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Half/Elements_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Elements = Elements.Elements;
                            case 'No'
                                Nodes = matfile(strcat(['TXT/Half/Nodes_Q16_',num2str(TXT_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Half/Elements_Q16_',num2str(TXT_Number),'.mat']));
                                Elements = Elements.Elements;
                        end
                    case 'No'
                        switch Ref_R
                            case 'Yes'
                                Nodes = matfile(strcat(['TXT/Full/Nodes_Full_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Full/Elements_Full_Q16_',num2str(TXT_Number),'_r',num2str(Ref_R_Number),'.mat']));
                                Elements = Elements.Elements;
                            case 'No'
                                Nodes = matfile(strcat(['TXT/Full/Nodes_Full_Q16_',num2str(TXT_Number),'.mat']));
                                Nodes = Nodes.Nodes;
                                Elements = matfile(strcat(['TXT/Full/Elements_Full_Q16_',num2str(TXT_Number),'.mat']));
                                Elements = Elements.Elements;
                        end
                end

            case 'PatchTest.X'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end  
                Elements = matfile('TXT/PatchTest/Elements_Q16_PatchTest.mat');
                Elements = Elements.Elements;

            case 'PatchTest.Y'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = load('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end 
                Elements = matfile('TXT/PatchTest/Elements_Q16_PatchTest.mat');
                Elements = Elements.Elements;

            case 'PatchTest.XY'
                if strcmp(Borders,'Straight')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                elseif strcmp(Borders,'Curved')==1
                    Nodes = matfile('TXT/PatchTest/Nodes_Q16_PatchTest.mat');
                    Nodes = Nodes.Nodes;
                end 
                Elements = matfile('TXT/PatchTest/Elements_Q16_PatchTest.mat');
                Elements = Elements.Elements;
        end

end

