function z=Fun(u,typ)
%z=(1-u(1))^2+100*(u(2)-u(1)^2)^2+(1-u(3))^2;%1,1,1
%   z=u(1)^2+u(2)^2+25*(sin(u(1))^2+sin(u(2))^2); %0 0 0
if nargin < 2
    typ=1;
end
if typ==1
    % 0 (3,0.5)
    x1 = u(1);
    x2 = u(2);
    term1 = (1.5 - x1 + x1*x2)^2;
    term2 = (2.25 - x1 + x1*x2^2)^2;
    term3 = (2.625 - x1 + x1*x2^3)^2;
    z = term1 + term2 + term3;
end
if typ==2
    % 0(0,0)
    x1 = u(1);
    x2 = u(2);
    term1 = 2*x1^2;
    term2 = -1.05*x1^4;
    term3 = x1^6 / 6;
    term4 = x1*x2;
    term5 = x2^2;
    z = term1 + term2 + term3 + term4 + term5;

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
