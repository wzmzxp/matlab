%f��Ŀ�꺯��
%z��Ŀ�꺯���ݶ�
%para�ǳ�ʼ�ݶ��½�λ��
function para=GD1(f,z,str,d,para)
    y=[];  
    for i=1:d
         y(i)= double(subs(z(i),str(1:d),para(1:d)));
    end
    grad=-1*y;
    alfa=0.1;
    precision=0.001;
    inif=f(para);
    next=inif-0.1;
    while inif-next>precision
%         inif=f(para);
        for i=1:d
            para(i)=para(i)+alfa*grad(i);
        end
        next=f(para);
    end
end