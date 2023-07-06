function print_data_end(etaG,eta_el,StrAvgNod,Nodes,Disp)

disp('----------------------------------------')
disp(strcat(['Relative Error (Eta): ',num2str(etaG)]))
if etaG < 1e-5
    warning('RELATIVE ERROR ACHIEVED')
end
disp('----------------------------------------')
disp(strcat(['Element with Maximum Elemental Error: ',num2str(find(eta_el==max(eta_el),1))]))
disp(strcat(['Maximum Elemental Error: ',num2str(max(eta_el))]))
disp(strcat(['Node with Maximum Sigma_xx: ',num2str(find(StrAvgNod(:,1)==max(StrAvgNod(:,1)),1))]))
disp(strcat(['Maximum Sigma_xx: ',num2str(max(StrAvgNod(:,1)))]))
Node_UR = find(abs(Nodes(:,1) - 100) <1e-9 & abs(Nodes(:,2) - 30)<1e-9);
disp(strcat(['Node with Maximum X Displacement: ',num2str(Node_UR)]))
disp(strcat(['Maximum X Displacement: ',num2str(Disp(Node_UR,1))]))
disp('----------------------------------------')
disp('Analysis:')
toc


