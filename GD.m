function z=GD(fun,d)
    syms u1 u2 u3 u4 u5 u6                                 % ͨ�����ű�������������ת��Ϊ���ź���
    str=[u1,u2,u3,u4,u5,u6];
    y = fun(str(1:d));
    syms z1 
    z=[z1]
    for i=1:d
%         z(i)= matlabFunction(diff(y,str(i)))
        z(i)=diff(y,str(i))
    end
%     if d==1
%         y = fun([u1])
%         z = matlabFunction(diff(y,u1))
%     end
%     if d==2
%         y = fun([u1,u2])
%         z(1) = matlabFunction(diff(y,u1))

    
    
end