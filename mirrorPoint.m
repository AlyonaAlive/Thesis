function [output, x,y ] = mirrorPoint( PX,PY,NX,NY,QX,QY  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
syms x y

if(NY==0)
    Y=PY+(PY-QY);
    X=QX;
elseif(NX==0)
    X=PX+(PX-QX);
    Y=QY;
else
    %line point P +vector N
    eq1=x*double(NY/NX)-double(PX*NY/NX)+PY==y;
    %perpendicular line through point Q
    eq2=x*(-NX/NY)+QY+QX*(NX/NY)==y;
    %find intersection:
    sol=solve([eq1,eq2],[x,y]);
    Xsol=sol.x; Ysol=sol.y;
    
    dx = Xsol-QX; dy = Ysol-QY;
    X=Xsol+dx; Y=Ysol+dy;
  
end
output=[double(X),double(Y)];
end

