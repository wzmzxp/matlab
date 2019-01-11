function Y = objfunc (x,y)

% Y = 11*sin(6*x) + 7*cos(5*x);
 Y=x.^2+y.^2+25*(sin(x).^2+sin(y).^2)
 