%% BA 蝙蝠算法
close
clear
clc

batnum = 30;
A0 = 0.5;
r0 = 0.25;
fmin = 0.1;
fmax = 1;
maxgen = 300;
alfa = 0.7; %音量衰减系数
gama = 0.5; %速率增强系数
d=2;%函数维度
iternum=0;%种群迭代次数
record=[];%记录每次迭代后的最优质
superX=0;
tag=0;
super=0;
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
 lb = -5.12;
ub = 5.12;
typ=4  

%Eggholder Function
%xi ∈ [-512, 512]
%-959.6407 (512,404.2319)
%  lb = -512;
% ub = 512;
% typ=5  
[z,str,f]=get_gradient(typ);
% 种群初始化
X = lb + (ub - lb)*rand(batnum,d);
Y=zeros(batnum,1);
% for i=1:batnum
%     X(i,:)=GD1(f,z,str,d,X(i,:));
% end
for i=1:batnum
    Y(i) = Fun(X(i,:),typ);
end


% plotx = linspace(-pi,pi,500);
% ploty = 11*sin(6*plotx) + 7*cos(5*plotx);
% plot(plotx,ploty)
% hold on
% h = plot(X,Y,'*');

[bestY,Ind] = min(Y);
super=bestY;

bestX = X(Ind,:);
recordIndex=bestX;
V = zeros(batnum,d);
A = ones(batnum,1)*A0;
r = ones(batnum,1)*r0*0.1;


for iter = 1 : maxgen
    lastbestX=bestX;
    for i = 1 : batnum
        fi = fmin + (fmax - fmin)*rand(1,d);
%         V(i,:) = V(i,:) + (X(i,:) - bestX).*fi+randn(1,d);
        V(i,:) = V(i,:) + (X(i,:) - bestX).*fi;
        nextX = X(i,:) + V(i,:);
        if rand > r(i)  % 最优解产生扰动
            meanA = sum(A)/batnum;
%             nextX = bestX + (2*rand(1,d) - 1)*meanA;
            nextX = bestX + (2*rand(1,d) - 1)*meanA;
        end
        
        index=find(nextX>ub);
        nextX(index)=ub;
         index=find(nextX<lb);
        nextX(index)=lb;
       
        nextY = Fun(nextX,typ);
        if nextY<super
                    super=nextY;
                    superX=nextX;
         end
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
    iternum=iternum+1;
    record(iternum)=bestY;
    if lastbestX==bestX
        tag=tag+1;
    else
        tag=0;
    end
     if tag>10
        disp(['抖动前 = ',num2str(bestY)]);
        %梯度下降
%         if (record(iter)-record(iter-1))>0.1
%             bestX=GD1(f,z,str,d,bestX);
%         end
%         ul1=bestX-0.3;
%         ub1=bestX+0.3;
if bestX<super
    super=bestY;
     superX=nextX;
end
%         t=rand(1,d);
        for j=1:batnum
            
%              X(j,:) = lb/t(1) + (ub/t(2) - lb/t(1)).*rand(1,d);
%                  X(j,1) = lb + (ub - lb).*rand(1,1);
              if iternum< maxgen/2
                     X(j,1) = lb + (ub - lb).*rand(1,1);
              else
                      X(j,2) = lb + (ub - lb).*rand(1,1);
              end
              
        end
%          for j=1:batnum
%             
% %              X(j,:) = lb/t(1) + (ub/t(2) - lb/t(1)).*rand(1,d);
%              X(j,1) = lb + (ub - lb).*rand(1,1);
%         end
        [bestY,Ind] = min(Y);
        bestX = X(Ind,:);
        if bestX<super
            super=bestY;
             superX=bestX;
        end
%           for j=1:batnum/2
%              X(j,:) = lb + (ul1 - lb).*rand(1,d);
%           end
%             for j=(batnum/2+1):batnum
%                 X(j,:) = ub1 + (ub - ub1).*rand(1,d);
%             end
%         
%         for j=1:batnum
%             X(j,:) = lb + (ub - lb).*rand(1,d);
%             X(j,:)= bestX + (2*rand(1,d) - 1)*meanA;
%         end
     end

end

figure
% axis([-inf,inf,0,0.2])
plot(1:iter,record,'*r');

% [bestY,in]=min(record);
% X
fprintf('最优位置：%f,%f\r',bestX(1),bestX(2))
fprintf('最优函数值：%f\r',bestY)
