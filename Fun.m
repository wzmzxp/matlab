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
end
