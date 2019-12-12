X=[-7, -5.5, -4, -2, 0, 2.5, 4.5, 6.5];
Y=[-5.68048, -2.57948, -1.22286, -0.285238, 0, -0.451044, -1.59272, -4.16675 ];
NX=X.*0.1394;
NY=0.9976+Y.*0.1394;

data=[X;Y;NX;NY];
plot_all(data,1);
N=15;

for i=1:N
    Next_step=one_subdivision_step(X,Y, NX,NY);
    plot_all(Next_step,i+1);
    X=Next_step(1,:);
    Y=Next_step(2,:);
    NX=Next_step(3,:);
    NY=Next_step(4,:);
end
    
