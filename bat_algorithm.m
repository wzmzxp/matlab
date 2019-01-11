function [best,fmin,N_iter]=bat_algorithm(para)

% Default parameters
if nargin<1, para=[10 0.25 0.5]; end
n=para(1);      % Population size, typically 10 to 25
A=para(2);      % Loudness (constant or decreasing)
r=para(3);      % Pulse rate (constant or decreasing)
% This frequency range determines the scalings
Qmin=0;     % Frequency minimum
Qmax=2;     % Frequency maximum
% Iteration parameters
tol=10^(-4);        % Stop tolerance
N_iter=0;           % Total number of function evaluations
% Dimension of the search variables
d=2;
typ=1;
% Initial arrays
Q=zeros(n,1);       % Frequency
v=zeros(n,d);       % Velocities
% Initialize the population/solutions
for i=1:n
    Sol(i,:)=randn(1,d);
    Fitness(i)=Fun(Sol(i,:),typ);
end
% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
%记录是否进入局部最优解
tag=0;
%flag>=3结束程序；表明多次收敛到的局部最优为全局最优
flag=0;
distance=0;
% Start the iterations -- Bat Algorithm
while (1)
    % Loop over all bats/solutions
%     if flag>3
%         break;
%     end
    lastFmin=fmin;
    lastbestIndex=I;
    
    for i=1:n
        Q(i)=Qmin+(Qmin-Qmax)*rand;
        v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
        S(i,:)=Sol(i,:)+v(i,:);
        % Pulse rate
        if rand>r
            S(i,:)=best+0.01*randn(1,d);
        end
        % Evaluate new solutions
        Fnew=Fun(S(i,:),typ);
        % If the solution improves or not too loudness
        if (Fnew<=Fitness(i)) & (rand<A)
            Sol(i,:)=S(i,:);
            Fitness(i)=Fnew;
        end
        % Update the current best
        if Fnew<=fmin
            best=S(i,:);
            fmin=Fnew;
            I=i;
            best
        end
    end
    N_iter=N_iter+n;
    
    if abs(lastFmin-fmin)<0.001
        tag=tag+1;
        if tag>200
%             flag=flag+1;
            tag=0;
            Sol(1,:)=Sol(I,:);
            for i=2:n
                Sol(i,:)=randn(1,d);
            end
            continue;
        end
    end
    %循环截止条件
    
     if (lastbestIndex~=I)
         distance=sum((Sol(lastbestIndex,:)-Sol(I,:)).^2).^0.5;
         if distance<tol
             break;
         end
          
    end
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);
disp(['distance = ',num2str(distance)]);
% Objective function -- Rosenbrock's 3D function

%梯度下降
% z=GD(Fun,2,best)