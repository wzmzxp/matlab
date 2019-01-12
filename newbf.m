function [best,fmin,N_iter]=bat_algorithm(para)
% Default parameters
clear all
if nargin<1, para=[10 0.25 0.5]; end
typ=4;
n=para(1);      % Population size, typically 10 to 25
A=para(2);      % Loudness (constant or decreasing)
r=para(3);      % Pulse rate (constant or decreasing)
%测试函数
left=-5.12;
right=5.12;
typ=4;
% -1 (0,0)
% This frequency range determines the scalings
Qmin=0;     % Frequency minimum
Qmax=2;     % Frequency maximum
% Iteration parameters
tol=10^(-5);        % Stop tolerance
N_iter=0;           % Total number of function evaluations
% Dimension of the search variables
d=2;
% Initial arrays
Q=zeros(n,1);       % Frequency
v=zeros(n,d);       % Velocities
% Initialize the population/solutions
for i=1:n
    Sol(i,:)=left+(right-left)*randn(1,d);
    Fitness(i)=Fun(Sol(i,:),typ);
end
% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
% Start the iterations -- Bat Algorithm
while (1)
    % Loop over all bats/solutions
    lastFmin=fmin;
    lastbestIndex=I;
    for i=1:n
        Q(i)=Qmin+(Qmin-Qmax)*rand;
        v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
        S(i,:)=Sol(i,:)+v(i,:);
        % Pulse rate
        if rand>r
            S(i,:)=best+0.01*randn(1,d);
            %如果抖动超出边界
%             for i=1:n
                bound=[left,right];
                index=find(S(i,:)>[left,right]);
                S(index)=bound(index);
%             end
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
        end
    end
     %判断当前函数值是否改变
     if abs(lastFmin-fmin)<0.001 
        tag=tag+1;
        %如果超过30次种群迭代累计次数函数值不改变
        if tag>30
            disp(['抖动 = ',num2str(fmin)]);
%             flag=flag+1;
            tag=0;
            Sol(1,:)=Sol(I,:);
            I=1;
            for i=2:n
                Sol(i,:)=left+(right-left)*randn(1,d);
            end
            
%             if (distance<tol)
%                 break;
%             end
            continue;
        
        end
     
    else
            tag=0;
            distance=sum((Sol(lastbestIndex,:)-Sol(I,:)).^2)^0.5;
            if (distance<tol) 
                break;
            end
    
     end
     
     N_iter=N_iter+n;
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);