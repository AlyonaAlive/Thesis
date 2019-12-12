function plot_all(data,iter)
% takes all dta a(for row matrix) from the iteration step 
% and iteration number and plots all the points and vectors 
    figure(iter)
    X=data(1,:);
    Y=data(2,:);
    NX=data(3,:);
    NY=data(4,:);
    plot(X,Y)
    xlim([-8.5 8])
    ylim([-6 1.5])
    hold on
    k = size(X); k=k(2);
    for i=1:k
        v0=[X(i) Y(i)];
        v1=[X(i)+NX(i) Y(i)+NY(i)];
        vectarrow(v0,v1);
        hold on
    end
    set(gca,'DataAspectRatio',[1 1 1])
    hold off;

