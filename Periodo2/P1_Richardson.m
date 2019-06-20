clear all;
clc;
syms x;
format long;
fx=x*sec(x)^2+(x^2)*atan(exp(3/x));
h=1/80;
x0=0.75;
n=7;
N=zeros(n);
%calcular primera columna usando 3 puntos centradas
for i=1:n
    N(i,1)=(1/(2*h))*(subs(fx,x0+h)-subs(fx,x0-h));
    h=h/2;
end
%calculo de otros valores usuando forma de escalon invertido  el resultado
%es independiente del valor
for j=2:n
    for i=1:n-j+1
        N(i,j)=((4^(j-1))*N(i+1,j-1)-N(i,j-1))/(4^(j-1)-1);
    end
end
N
