function [bestX,bestY,bestZ,H,temp]=BF(ps,objfunc)
    H=[];
    batnum = ps.('batnum');
    A0 = ps.('A0');
    r0 = ps.('r0');
    fmin = ps.('fmin');
    fmax = ps.('fmax');
    maxgen = ps.('maxgen');
    alfa = ps.('alfa'); %音量衰减系数
    gama = ps.('gama'); %速率增强系数
    lb = ps.('lb');
    ub = ps.('ub');
    % 种群初始化
%     rand('seed',1);
    X = lb(1) + (ub(1) - lb(1))*rand(batnum,1);
%     rand('seed',2);
    Y = lb(2) + (ub(2) - lb(2))*rand(batnum,1);
    Z= objfunc(X,Y);
    [bestZ,Ind] = min(Z);
    bestX = X(Ind(1));
    bestY=Y(Ind(1));
    V = zeros(batnum,1);
    A = ones(batnum,1)*A0;
    r = zeros(batnum,1)*r0;
    temp=0;;
    for iter = 1 : maxgen
        for i = 1 : batnum
            fi = fmin + (fmax - fmin)*rand;
            V(i) = V(i) + (X(i) - bestX)*fi;
            nextX = X(i) + V(i);
            nextY = Y(i) + V(i);
            if  1%rand > r(i)  % 最优解产生扰动
                temp=temp+1;
              meanA = sum(A)/batnum
              a=(2*rand - 1)*meanA;
%               a=0.01*randn(1,3);
              nextX = bestX + a;
              nextY = bestY + a;
%               nextX = exp(1)%*meanA;
%               nextY =exp(1)%*meanA;
            end
            if nextX < lb(1)
                nextX = lb(1);
            end
            if nextX > ub(1)
                nextX = ub(1);
            end
            if nextY < lb(2)
                nextX = lb(2);
            end
            if nextY > ub(2)
                nextY = ub(2);
            end
            nextZ = objfunc(nextX,nextY);
            if nextZ <= Z(i) && rand < A(i) 
                X(i) = nextX;
                Y(i) = nextY;
                Z(i) =nextZ;
                r(i) = r0*(1 - exp(-gama*iter));
                A(i) = alfa * A(i);
               if nextZ < bestZ
                  bestZ = nextZ;
                  bestX = nextX;
                  bestY = nextY;
               end
            end
        end
     H(iter)=bestZ;
    end
    
    
end





