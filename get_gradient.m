function [z,str,f]=get_gradient(id)
    f=@(x) -(x(2)+47) * sin(sqrt(abs(x(2)+x(1)/2+47)))-x(1) * sin(sqrt(abs(x(1)-(x(2)+47))));
    [z,str]=dif(f,2);
    
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