function Draw_Barra(Element,Node,c)

nel = size(Element,1);
nnodel = size(Element,2);
xx = zeros(nnodel,1);
yy = zeros(nnodel,1);
for k=1:nel
    for i=1:nnodel
        xx(i) = Node(Element(k,i),1);
        yy(i) = Node(Element(k,i),2);
        
        text(xx(i),yy(i),num2str(Element(k,i)),'VerticalAlignment','bottom','Color',c,'FontSize',8);
    end
    plot(xx,yy,c)
    plot(xx,yy,'o','MarkerFaceColor',c,'MarkerEdgeColor',c,'MarkerSize',8)
    x = mean(Node(Element(k,:),1));
    y = mean(Node(Element(k,:),2));
    if c=='r'
    else
        text(x,y,num2str(k),'edgeColor','k','Color','k','FontSize',8)
    end
end
grid on
axis equal