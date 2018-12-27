function y=GD(f,d,para)
    [z,str]=fun(f,d)
    y=[];
    for i=1:d
         y(i)= double(subs(z(i),str(1:d),para(1:d)))
    end
end

function [z,str]=fun(f,d)
    syms u1 u2 u3 u4 u5 u6                               
    str=[u1,u2,u3,u4,u5,u6];
    y = f(str(1:d));
    syms z1 
    z=[z1]
    for i=1:d
        z(i)=diff(y,str(i))
        
    end
end