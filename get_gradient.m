function [z,str,f]=get_gradient(id)
if id==5
    f=@(x) -(x(2)+47) * sin(sqrt(abs(x(2)+x(1)/2+47)))-x(1) * sin(sqrt(abs(x(1)-(x(2)+47))));
    [z,str]=dif(f,2);
end
if id==2

 f=@(x) 0.26 * (x(1)^2 + x(2)^2)-0.48*x(1)*x(2);
 [z,str]=dif(f,2);
end
if id==4
%  x1 = u(1);
%     x2 = u(2);
%     
%     
%     frac1 = 1 + cos(12*sqrt(x1^2+x2^2));
%     frac2 = 0.5*(x1^2+x2^2) + 2;
%     
%     z = -frac1/frac2;
 f=@(x) -1*(1 + cos(12*sqrt(x(1)^2+x(2)^2)))/(0.5*(x(1)^2+x(2)^2) + 2);
 [z,str]=dif(f,2);
end
if id==3
    
% fact1 = sin(x1)*sin(x2);
%     fact2 = exp(abs(100 - sqrt(x1^2+x2^2)/pi));
%     
%     z = -0.0001 * (abs(fact1*fact2)+1)^0.1;
 f=@(x)  -0.0001 *(abs(sin(x(1))*sin(x(2))*exp(abs(100 - sqrt(x(1)^2+x(2)^2)/pi))))^0.1;
 [z,str]=dif(f,2);
end
end
function [z,str]=dif(f,d)
    syms u1 u2 u3 u4 u5 u6                               
    str=[u1,u2,u3,u4,u5,u6];
    y = f(str(1:d));
    syms z1 
    z=[z1];
    for i=1:d
        z(i)=diff(y,str(i));
        
    end
end