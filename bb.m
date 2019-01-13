function [best,fmin,N_iter]=bat_algorithm(para)
% Default parameters
clear all
if nargin<1, para=[10 0.25 0.5]; end
typ=4;
n=para(1);      % Population size, typically 10 to 25
A=para(2);      % Loudness (constant or decreasing)
r=para(3);      % Pulse rate (constant or decreasing)
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
    Sol(i,:)=randn(1,d);
    Fitness(i)=Fun(Sol(i,:),typ);
end
% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
% Start the iterations -- Bat Algorithm
while (fmin>tol)
    % Loop over all bats/solutions
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
        end
    end
    N_iter=N_iter+n;
end
% Output/display
disp(['Number of evaluations: ',num2str(N_iter)]);
disp(['Best = ',num2str(best),' fmin = ',num2str(fmin)]);