function [ output,new_pointsX,new_pointsY,new_normalsX ,new_normalsY] = one_subdivision_step( pointsX,pointsY, normalsX,normalsY )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 
k = size(pointsX); k=k(2);
 
%preallocation (for memory sawing) 
new_pointsX= zeros(1,2*k-1); new_pointsY= zeros(1,2*k-1);
new_normalsX = zeros(1,2*k-1); new_normalsY = zeros(1,2*k-1);
 
%-------------copy every other element of input sequense to new sequense-------------
for  l=1:k
new_pointsX(2*l-1) = pointsX(l);
new_pointsY(2*l-1) = pointsY(l);
new_normalsX(2*l-1) = normalsX(l);
new_normalsY(2*l-1) = normalsY(l);
end
 
%-------------computing coords of new point and new vector------------- 
for l=4:2:2*k-4
  
    XA = new_pointsX(l-1);YA = new_pointsY(l-1);
    XB = new_pointsX(l+1);YB = new_pointsY(l+1);
    XC = new_pointsX(l-3);YC = new_pointsY(l-3);
    XD = new_pointsX(l+3);YD = new_pointsY(l+3);
    nax = new_normalsX(l-1);nay = new_normalsY(l-1);
    nbx = new_normalsX(l+1);nby = new_normalsY(l+1);
    res = compute_new_point(XA, YA, XB, YB, XC, YC, XD, YD,nax, nay, nbx, nby);
    new_pointsX(l) = res(1); new_pointsY(l) = res(2);
    new_normalsX(l) = res(3); new_normalsY(l) = res(4);
end
 
%---------computing edge points-------------
 
%auxiliary points 
% M1 got by mirroring second point of initial sequence (which is third of a
% new one) regarding the first point and corresponding normal
% than we compute second point of a new sequence besed on: first, third, M1 and fifth
 
 
M1 = mirrorPoint(new_pointsX(1),new_pointsY(1),new_normalsX(1),new_normalsY(1),new_pointsX(3),new_pointsY(3));
res1 = compute_new_point(new_pointsX(1), new_pointsY(1), new_pointsX(3), new_pointsY(3), M1(1), M1(2), new_pointsX(5), new_pointsY(5),new_normalsX(1), new_normalsY(1), new_normalsX(3), new_normalsY(3));
new_pointsX(2) = res1(1); new_pointsY(2) = res1(2);
new_normalsX(2) = res1(3); new_normalsY(2) = res1(4);
 
 
%analogously mirror prelast point of initial sequense, which is last-2 in a
%new one, regarding the lat point and normal
%compute prelast point of a new sequense based on: last-2, last, last-4 and M2
last = size(new_pointsX);
last=last(2);
M2 = mirrorPoint(new_pointsX(last),new_pointsY(last),new_normalsX(last),new_normalsY(last),new_pointsX(last-2),new_pointsY(last-2));
res2 = compute_new_point(new_pointsX(last-2), new_pointsY(last-2), new_pointsX(last), new_pointsY(last), new_pointsX(last-4), new_pointsY(last-4),M2(1), M2(2), new_normalsX(last-2), new_normalsY(last-2), new_normalsX(last), new_normalsY(last));
new_pointsX(last-1) = res2(1); new_pointsY(last-1) = res2(2);
new_normalsX(last-1) = res2(3); new_normalsY(last-1) = res2(4);
 
 
output = [new_pointsX;new_pointsY;new_normalsX; new_normalsY];
end
 