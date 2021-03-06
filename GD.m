function para=GD(f,d,para)
    y=GD1(f,d,para);
    grad=-1*y;
    alfa=0.1;
    precision=0.001;
    inif=f(para);
    next=inif-0.1;
    while inif-next>precision
        inif=f(para);
        for i=1:d
            para(i)=para(i)+alfa*grad(i)
        end
        next=f(para);
    end
end


function y=GD1(f,d,para)
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