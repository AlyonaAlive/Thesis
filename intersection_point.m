function [ output_args ] = intersection_point(W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby,conic_coeff )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Compute an intersection of best fit line and conic 

syms x y t;

a=conic_coeff(1);b=conic_coeff(2);c=conic_coeff(3);d=conic_coeff(4);e=conic_coeff(5);f=conic_coeff(6);
F(x,y) = a*x^2+b*x*y+c*y^2+d*x+e*y+f;

%p - best fit line
x=[XA,XB];
y=[YA,YB];
p = polyfit(x,y,1);
% centroid
x1 = (XA+XB)/2; y1 = (YA+YB)/2;

%n - direction vector (perpendicular) 
n = [-p(1),1];
n = [n(1)/norm(n),n(2)/norm(n)];

T = double(solve(F(x1+n(1)*t,y1+n(2)*t)==0,t));
% if we have solution for (quadratic) equation above call lin_comb
if (~isreal(T(1)))
    new_point = lin_comb(W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby, conic_coeff);
else
    sz=size(T);
    if (sz==1)
        px = x1+n(1)*T;
        py = y1+n(2)*T;
    else
        
        t1 = T(1); t2 = T(2);
        
        %--------------- third: pick the closest  ---------------
        
        P1x = x1+n(1)*t1;P1y = y1+n(2)*t1;
        P2x = x1+n(1)*t2;P2y = y1+n(2)*t2;
        
        D1 = [P1x,P1y;x1,y1];
        d1 = pdist(D1,'euclidean');
        
        D2 = [P2x,P2y;x1,y1];
        d2= pdist(D2,'euclidean');
        
        if(d1<=d2)
            px = P1x;
            py = P1y;
        elseif(d1>d2)
            px = P2x;
            py = P2y;
        end
    end
output_args = [px py];
end

