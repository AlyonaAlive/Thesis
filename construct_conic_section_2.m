function [ coefficients ] = construct_conic_section_2( W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

syms  a b c d e f x y ;
% F  - conic section 
F(x,y) = a*x^2+b*x*y+c*y^2+d*x+e*y+f;
grad_f=gradient(F);

% fisrt summand with normal
t1 = feval(grad_f,XA, YA)-[nax;nay];
Q=(W4)*((t1(1))^2+(t1(2))^2);
 

% second summand with normal 
t2=feval(grad_f,XB, YB)-[nbx;nby];
U=(W5)*((t2(1))^2+(t2(2))^2);

% four points : 
fa=feval(F,XA, YA);
fb=feval(F,XB, YB);
fc=feval(F,XC, YC);
fd=feval(F,XD, YD);
 
J=(W0)*(fa)^2;
K=(W1)*(fb)^2;
J1=(W2)*(fc)^2;
K1=(W3)*(fd)^2;

% %additional condition  - middle point between A B 
% MPx = (XA+XB)/2;
% MPy = (YA+YB)/2;
% fmp = feval(F,MPx,MPy);
% J2 = (W0)*(fmp)^2;

%constracting objective function and solving equations: 
 G=J+K+Q+U+J1+K1 ;
 difA=diff(G,a);
 difB=diff(G,b);
 difC=diff(G,c);
 difD=diff(G,d);
 difE=diff(G,e);
 difF=diff(G,f);
 
 eq1 = difA==0;
 eq2 = difB==0;
 eq3 = difC==0;
 eq4 = difD==0;
 eq5 = difE==0;
 eq6 = difF==0;
 
 [A,B] = equationsToMatrix([eq1, eq2, eq3, eq4, eq5, eq6], [a, b, c, d, e, f]);
%  disp(double(eig(A)));
 coefficients = linsolve(A,B);
 

 %norm coeffs
 coefficients = double(coefficients/norm(coefficients));
 disp(coefficients);
end

 
