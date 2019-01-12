

function [best,fmin,N_iter]=bat_algorithm(para)
clear all
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

% -1 (0,0)
left=-5.12;
right=5.12;
typ=4;
flag=0;
% Initial arrays
Q=zeros(n,1);       % Frequency
v=zeros(n,d);       % Velocities
% Initialize the population/solutions
for i=1:n
     Sol(i,:)=left+(right-left)*rand(1,d);
    Fitness(i)=Fun(Sol(i,:),typ);
end
% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
%????????????????
tag=0;
%flag>=3????????????????????????????????????
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
    a=1;
    for i=1:n
        Q(i)=Qmin+(Qmin-Qmax)*rand;
        v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
        S(i,:)=Sol(i,:)+v(i,:);
        % Pulse rate
        if rand>r
            S(i,:)=best+0.01*rand(1,d);
            bound=[left,right];
                index=find(S(i,:)>[left,right]);
                S(i,index)=bound(index);
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
    
    %累计函数值不变的次数
    if abs(lastFmin-fmin)<0.01
        tag=tag+1;
    else
        tag=0;
    end
    
    if tag>300
        disp(['抖动前 = ',num2str(fmin)]);
        tag=0;
        Sol(1,:)=Sol(I,:);
        I=1;
        best=  Sol(1,:);
        for i=2:n
%             Sol(i,:)=left+(right-left)*randn(1,d);
%             Fitness(i)=Fun(Sol(i,:),typ);
            S(i,:)=best+0.01*rand(1,d);
            bound=[left,right];
                index=find(S(i,:)>[left,right]);
                S(i,index)=bound(index);
        end
        flag=flag+1;
    end
%     distance=sum((Sol(lastbestIndex,:)-Sol(I,:)).^2).^0.5;
%      if distance<tol
%            break;
%      end
best
%      if flag>4
%         break;
%      end
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);
disp(['distance = ',num2str(distance)]);
% Objective function -- Rosenbrock's 3D function

%??????
% z=GD(Fun,2,best)
