% f=@(u) (1-u(1))^2+100*(u(2)-u(1)^2)^2+(1-u(3))^2;
% f=@(x)  x(2)*x(1)^2+x(2)^2;
f=@(x) x(1)^2+x(2)^2+25*(sin(x(1))^2+sin(x(2))^2)
%  f=@(x)  x^2
z=GD(f,2,[0.3,0.3]);
% z=matlabFunction(z(1))
z

% bat_algorithm(f)