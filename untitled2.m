function [ output_args ] = compute_intersect( XA, YA, XB, YB, XC, YC, XD, YD,conic_coeff )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Compute an intersection of best fit line and conic 

a=conic_coeff(1);b=conic_coeff(2);c=conic_coeff(3);d=conic_coeff(4);e=conic_coeff(5);f=conic_coeff(6);
%are they double??
F(x,y) = a*x^2+b*x*y+c*y^2+d*x+e*y+f;

%p - best fit line
x=[XA,XB,XC,XD];
y=[YA,YB,YC,YD];
p = polyfit(x,y,1);
% centroid
x1 = (XA+XB+XC+XD)/4; y1 = (YA+YB+YC+YD)/4;

%n - direction vector (perpendicular) 
n = [-p(1),1];
n = [n(1)/norm(n),n(2)/norm(n)];

end

