%% BA 蝙蝠算法
close
clear all
clc
batnum = 20;
A0 = 0.5;
r0 = 0.25;
fmin = 0.1;
fmax = 2;
maxgen = 600;
alfa = 0.8; %音量衰减系数
gama = 0.5; %速率增强系数
lb = [-2*pi,-2*pi];
ub =[2*pi,2*pi];
% objfun=@(x,y) -(x.^2+y.^2+25*(sin(x).^2+sin(y).^2));
% objfun=@(x,y) (x.^2+y.^2+25*(sin(x).^2+sin(y).^2));
objfun=@(x) x(1)^2+x(2)^2+25*(sin(x(1))^2+sin(x(2))^2);
X=lb(1):0.1:ub(1);
Y=lb(2):0.1:ub(2);
[X,Y]=meshgrid(X,Y); 
Z=objfunc(X,Y);
% surf(Z);
plot3(X,Y,Z);
% rand('seed',1);
 X = lb(1) + (ub(1) - lb(1))*rand(batnum,1);

%  rand('seed',2);
 Y = lb(2) + (ub(2) - lb(2))*rand(batnum,1);
 a=[X,Y]
 for i=1:20
         para(i,:)=GD(objfun,2,a(i,:))
 end

 X=para(1:20,1);
 Y=para(1:20,2);
 Z=objfunc(X,Y);
hold on 
% plot3(X(1) ,Y(1), objfunc(X(1) ,Y(1)),'bo');
plot3(X,Y,Z,'k*');
%最大值3.0196  48.9666  2.4304e+03
ps=struct('batnum',batnum,'A0',A0,'r0',r0,'fmin',fmin,'fmax',fmax,'maxgen',maxgen,'alfa',alfa,'gama',gama,'lb',lb,'ub',ub);

[x,y,z,h,temp]=BF(ps,objfun)
plot3(x,y,z,'r*');
hold off
figure(2)
plot([1:maxgen],h)
% objfun1=@(x,y) -1*(x.^2+y.^2+25*(sin(x).^2+sin(y).^2));
% x=fminunc(objfun1,[-2*pi,-2*pi])%  