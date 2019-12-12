function [ output, px,py] = lin_comb( W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby, conic_coeffs )
% Summary of this function goes here
%   Detailed explanation goes here
%   1) take coeffs of already computed (singular conic) - a1..f1
%   2) compute circle fit - a2..f2
%   3) make linear comb of these two
%   4) find the best value for parameter t
%   5) compute resulting conic 
%   6) compute and return new point

a1=conic_coeffs(1);b1=conic_coeffs(2);c1=conic_coeffs(3);d1=conic_coeffs(4);e1=conic_coeffs(5);f1=conic_coeffs(6);

circle_coeffs= construct_circle(W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby);
a2=circle_coeffs(1);b2=0;c2=circle_coeffs(1);d2=circle_coeffs(2);e2=circle_coeffs(3);f2=circle_coeffs(4);

C_1 = [a1 b1/2 d1/2; b1/2 c1 e1/2; d1/2 e1/2 f1];
C_2 = [a2 b2/2 d2/2; b2/2 c2 e2/2; d2/2 e2/2 f2];
syms x y t s;
C = t*C_1+s*C_2;
a = C(1,1);b=2*C(1,2);c=C(2,2); d=2*C(1,3);e=2*C(2,3);f=C(3,3);
F(x,y) = a*x^2+b*x*y+c*y^2+d*x+e*y+f;
grad=gradient(F);

% fisrt summand with normal
t1 = feval(grad,XA, YA)-[nax;nay];
Q=(W4)*((t1(1))^2+(t1(2))^2);
 
% second summand with normal 
t2=feval(grad,XB, YB)-[nbx;nby];
U=(W5)*((t2(1))^2+(t2(2))^2);

% four points : 
Fa=feval(F,XA, YA);
Fb=feval(F,XB, YB);
Fc=feval(F,XC, YC);
Fd=feval(F,XD, YD);
 
J=(W0)*(Fa)^2;
K=(W1)*(Fb)^2;
J1=(W2)*(Fc)^2;
K1=(W3)*(Fd)^2;

G=J+K+Q+U+J1+K1;
difT=diff(G,t);

t_value=double(solve(difT==0,t));

%compute values of new coeff with value of param t

C=double(subs(C,t,t_value));
a = C(1,1);b=2*C(1,2);c=C(2,2); d=2*C(1,3);e=2*C(2,3);f=C(3,3);
F(x,y) = a*x^2+b*x*y+c*y^2+d*x+e*y+f;

%--------------- second: constract perpendicular to best fit line & find intersection ---------------
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
if(isreal(T(1)))% if we have solution for (quadratic) equation above
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
    else %if we dont have solution for (quadratic ) equation above
          disp('LIN COMB: NO REAL SOLUTIONS');
          px=(XA+XB)/2;
          py=(YA+YB)/2;
    end
output = [px py];
end

