%declare input points
X=[-2.5, -2, -1.5 -1, -0.5, 0, 0.5, 1, 1.5, 2, 2.5];
Y=[-0.2897, -0.1819, -0.1009, -0.0444, -0.011, 0,  -0.011, -0.0444, -0.1009, -0.1819, -0.2897 ];
%input vectors
NX=X.*(18/sqrt(42853));
NY=204/sqrt(42853)+Y.*(68/sqrt(42853));


data=[X;Y;NX;NY];
plot_all(data,1);
N=6;

for i=1:N
    Next_step=one_subdivision_step(X,Y, NX,NY);
    plot_all(Next_step,i+1);
    X=Next_step(1,:);
    Y=Next_step(2,:);
    NX=Next_step(3,:);
    NY=Next_step(4,:);
end