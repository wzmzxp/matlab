function z=GD(fun,d)
    syms u1 u2 u3 u4 u5 u6                               
    str=[u1,u2,u3,u4,u5,u6];
    y = fun(str(1:d));
    syms z1 
    z=[z1]
    for i=1:d
        z(i)=diff(y,str(i))
    end


    
    
end