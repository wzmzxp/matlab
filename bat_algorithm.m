

function [best,fmin,N_iter]=bat_algorithm(para)
clear all
% Default parameters
if nargin<1, para=[20 0.25 0.5]; end
n=para(1);      % Population size, typically 10 to 25
A=para(2);      % Loudness (constant or decreasing)
r=para(3);      % Pulse rate (constant or decreasing)
typ=4;
left=-5.12;
right=5.12;
% typ=5;
% left=-512;
% right=512;

% This frequency range determines the scalings
Qmin=0;     % Frequency minimum
Qmax=2;     % Frequency maximum
% Iteration parameters
tol=10^(-3);        % Stop tolerance
N_iter=0;           % Total number of function evaluations
% Dimension of the search variables
d=2;

% Initial arrays
Q=zeros(n,1);       % Frequency
v=zeros(n,d);       % Velocities
% Initialize the population/solutions
for i=1:n
%     Sol(i,:)=randn(1,d);
    Sol(i,:)=left+(right-left)*randn(1,d);
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
a=1;
haha=0;
% Start the iterations -- Bat Algorithm
while (1)
    % Loop over all bats/solutions
%     if flag>3
%         break;
%     end
    lastFmin=fmin;
    lastbestIndex=I;
    a=1;
    for i=1:n
        Q(i)=Qmin+(Qmin-Qmax)*rand;
        v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
        S(i,:)=Sol(i,:)+v(i,:);
        % Pulse rate
        if rand>r
            S(i,:)=best+0.001*randn(1,d);
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
        end
    end
    N_iter=N_iter+n;
    if abs(lastFmin-fmin)<0.001 
        tag=tag+1;
        if tag>300
            disp(['抖动 = ',num2str(fmin)]);
            flag=flag+1;
            tag=0;
            Sol(1,:)=Sol(I,:);
            I=1;
            for i=2:n
%               p=randn(1,d)
%               pp=(right-left)*p;
%               Sol(i,:)=left+pp;
                    Sol(i,:)=left+(right-left)*rand(1,d);
            end
            continue;
        end
    end
    %循环截止条件
    
     if (lastbestIndex==I)
         distance=sum((Sol(lastbestIndex,:)-Sol(I,:)).^2).^0.5;
         if distance==0
             haha=haha+1;
             
         end
          
     end
    if haha>5000
        break;
    end
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
% disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);
disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);
% printf('%.3f',float(fmin))
disp(['distance = ',num2str(distance)]);
% Objective function -- Rosenbrock's 3D function

%梯度下降
% z=GD(Fun,2,best)