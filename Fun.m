function z=Fun(u,typ)
%z=(1-u(1))^2+100*(u(2)-u(1)^2)^2+(1-u(3))^2;%1,1,1
%   z=u(1)^2+u(2)^2+25*(sin(u(1))^2+sin(u(2))^2); %0 0 0
if nargin < 2
    typ=1;
end
%Holder Table Function
%  xi ¡Ê [-10, 10]
if typ==1
    % -19.2085 (8.0.5502,9.66459),(-8.0.5502,9.66459),(8.0.5502,-9.66459),(-8.0.5502,-9.66459)
    x1 = u(1);
    x2 = u(2);
    fact1 = sin(x1)*cos(x2);
    fact2 = exp(abs(1 - sqrt(x1^2+x2^2)/pi));
    z = -abs(fact1*fact2);
end
% Matyas Function
% xi ¡Ê [-10, 10] 
%0,(0,0)
if typ==2
    
    x1 = u(1);
    x2 = u(2);
    term1 = 0.26 * (x1^2 + x2^2);
    term2 = -0.48*x1*x2;

z = term1 + term2;

end
if typ==3
    %Cross-in-Tray Function
    %-2.06261 (1.3491,1.3491) (1.3491,-1.3491) (-1.3491,1.3491) (-1.3491,-1.3491)
    %(-10,10)
    x1 = u(1);
    x2 = u(2);
    
    fact1 = sin(x1)*sin(x2);
    fact2 = exp(abs(100 - sqrt(x1^2+x2^2)/pi));
    
    z = -0.0001 * (abs(fact1*fact2)+1)^0.1;
    
end
if typ==4
    %Drop-Wave Function -1 (0,0)
    %left=-5.12; right=5.12;

    x1 = u(1);
    x2 = u(2);
    
    
    frac1 = 1 + cos(12*sqrt(x1^2+x2^2));
    frac2 = 0.5*(x1^2+x2^2) + 2;
    
    z = -frac1/frac2;
end
%Eggholder Function
%xi ¡Ê [-512, 512]
%959.6407 (512,404.2319)
if typ==5
x1 = u(1);
x2 = u(2);

term1 = -(x2+47) * sin(sqrt(abs(x2+x1/2+47)));
term2 = -x1 * sin(sqrt(abs(x1-(x2+47))));

z = term1 + term2;

end

end



