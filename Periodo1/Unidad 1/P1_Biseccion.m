clear all
clc
syms x
g=9.81;
t=4;
v=36;
m=80;
disp('MÉTODO DE BISECCIÓN')
fprintf('---------------------------\n');
Fx=input('Función f(x): ');
a=input('Valor de a=');
b=input('Valor de b=');
errorPrecision=input('Precisión: 10^-');
errorPrecision=10^(errorPrecision*-1);
fa=subs(Fx,a);
fb=subs(Fx,b);
if fa*fb<0
    c=(a+b)/2;
    fc=subs(Fx,c);
    n=1;
    error=abs(fc);
    fprintf('TABLA DE ITERACIONES\n  n=%3.0f  a=%9.15f  b=%9.15f  c=%9.15f  tol=%e\n',double(n),double(a),double(b),double(c),double(error));
    error=abs(c-a);
    while error>errorPrecision
        n=n+1;
        if fa*fc<0
            b=c;
            c=(a+b)/2;
            error=abs(c-b);
        else
            a=c;
            c=(a+b)/2;
            error=abs(c-a);
        end
        fc=subs(Fx,c);
        fprintf('  n=%3.0f  a=%9.15f  b=%9.15f  c=%9.15f  error=%e\n',double(n),double(a),double(b),double(c),double(error));
    end
end
fprintf('\n\t\tEl valor aproximado de x es: %9.15f\n',double(c))