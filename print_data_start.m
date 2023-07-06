function print_data_start(Case,Ref_R,Ref_R_Number,TXT_Number,Ele_Type,nNod,nEle,Borders,Material)
       
disp(strcat(['Case: ',Case]))
if strcmp(Case,'Final')==1
    if strcmp(Ref_R,'Yes')==1
        disp(strcat(['Mesh Number: ',num2str(TXT_Number),'_r',num2str(Ref_R_Number)]))
    else
        disp(strcat(['Mesh Number: ',num2str(TXT_Number)]))
    end
end
disp(strcat(['Element Type: ',Ele_Type]))
disp(strcat(['Number of Nodes: ',num2str(nNod)]))
disp(strcat(['Number of Elements: ',num2str(nEle)]))
if strcmp(Case(1:5),'Patch')==1
    disp(strcat(['Border Type: ',Borders]))
end
disp(strcat(['Material Type: ',Material]))
disp('----------------------------------------')

