function [output, px,py,nx,ny ] = circl_comp_new_point( XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%--------------- first: constract a conic section ---------------

syms W0 W1 W2 W3 W4 W5 x y t T t1 t2  ;
W0=1^3; W1 = 1^3; W2 = 1^3; W3 = 1^3; W4 = 1^5; W5 = 1^5;

circle_coeff= construct_circle(W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby);
a=circle_coeff(1);b=circle_coeff(2);c=circle_coeff(3);d=circle_coeff(4);
conic_coeff = [a 0 a b c d];

new_point = intersection_point(W0, W1, W2, W3, W4, W5, XA, YA, XB, YB, XC, YC, XD, YD, nax, nay, nbx, nby, conic_coeff);
px = new_point(1);
py = new_point(2);

%new normal as gradient at the point
a=circle_coeff(1);b=circle_coeff(2);c=circle_coeff(3);d=circle_coeff(4);
%are they double??
F(x,y) = a*x^2+a*y^2+b*x+c*y+d;
grad_f=gradient(F);
new_normal = feval(grad_f,px,py);
nx = double(new_normal(1));
ny = double(new_normal(2));
output = [px py nx ny];
end