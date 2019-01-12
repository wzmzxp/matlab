%% BA 蝙蝠算法
close
clear
clc

batnum = 30;
A0 = 0.5;
r0 = 0.25;
fmin = 0.1;
fmax = 1;
maxgen = 5000;
alfa = 0.7; %音量衰减系数
gama = 0.5; %速率增强系数
d=2;
% -19.2085 (8.0.5502,9.66459),(-8.0.5502,9.66459),(8.0.5502,-9.66459),(-8.0.5502,-9.66459)
% lb = -10;
% ub = 10;
% typ=1
% Matyas Function
% xi ∈ [-10, 10] 
%0,(0,0)
% lb = -10;
% ub = 10;
% typ=2

%Cross-in-Tray Function
    %-2.06261 (1.3491,1.3491) (1.3491,-1.3491) (-1.3491,1.3491) (-1.3491,-1.3491)
    %(-10,10)
% lb = -10;
% ub = 10;
% typ=3

 %Drop-Wave Function -1 (0,0)
    %left=-5.12; right=5.12; 效果不好
%  lb = -5.12;
% ub = 5.12;
% typ=4  

%Eggholder Function
%xi ∈ [-512, 512]
%959.6407 (512,404.2319)
 lb = -512;
ub = 512;
typ=5  
% 种群初始化
X = lb + (ub - lb)*rand(batnum,d);
Y=zeros(batnum,1);
for i=1:batnum
    Y(i) = Fun(X(i,:),typ);
end


% plotx = linspace(-pi,pi,500);
% ploty = 11*sin(6*plotx) + 7*cos(5*plotx);
% plot(plotx,ploty)
% hold on
% h = plot(X,Y,'*');

[bestY,Ind] = min(Y);
bestX = X(Ind,:);
V = zeros(batnum,d);
A = ones(batnum,1)*A0;
r = ones(batnum,1)*r0*0.1;
for iter = 1 : maxgen
    for i = 1 : batnum
        fi = fmin + (fmax - fmin)*rand(1,d);
        V(i,:) = V(i,:) + (X(i,:) - bestX).*fi;
        nextX = X(i,:) + V(i,:);
        if rand > r(i)  % 最优解产生扰动
            meanA = sum(A)/batnum
            nextX = bestX + (2*rand(1,d) - 1)*meanA;
        end
        
        index=find(nextX>ub);
        nextX(index)=ub
         index=find(nextX<lb);
        nextX(index)=lb
       
        nextY = Fun(nextX,typ);

        if nextY <= Y(i) && rand < A(i) 
            X(i,:) = nextX;
            Y(i) = nextY;
            r(i) = r0*(1 - exp(-gama*iter));
            A(i) = alfa * A(i);
            if nextY < bestY
                bestY = nextY;
                bestX = nextX;
            end
        end
    end
    h.XData = X;
    h.YData = Y;
%     pause(0.005)
end

fprintf('最优位置：%f,%f\r',bestX(1),bestX(2))
fprintf('最优函数值：%f\r',bestY)