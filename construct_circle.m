function [ coefficients ] = construct_circle( W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

syms  a b c d e f x y ;
% F  - circle
F(x,y) = a*x^2+a*y^2+b*x+c*y+d;
grad_f=gradient(F);

% fisrt summand with normal
% t1_1 = feval(grad_f,XA, YA);
t1 = feval(grad_f,XA, YA)-[nax;nay];
Q=(W4)*((t1(1))^2+(t1(2))^2);
 

% second summand with normal 
% t2_2=feval(grad_f,XB, YB);
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
  
 eq1 = difA==0;
 eq2 = difB==0;
 eq3 = difC==0;
 eq4 = difD==0;
 
 [A,B] = equationsToMatrix([eq1, eq2, eq3, eq4], [a, b, c, d]);
%  disp(double(eig(A)));
 coefficients = linsolve(A,B);
 
%  disp(double(coefficients));
 %norm coeffs
 coefficients = double(coefficients/norm(coefficients));
 disp(coefficients);
end

 
