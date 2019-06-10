clear all
clc
syms x
disp('MÉTODO DE NEWTON RAPHSON')
fprintf('---------------------------\n');
Fx=input('Función f(x): ');
p0=input('Valor de Po=');
Fprima=diff(Fx,x);
if subs(Fprima,p0)~=0
    errorPrecision=input('Precisión: 10^-');
    errorPrecision=10^(errorPrecision*-1);
    p=p0-subs(Fx,p0)/subs(Fprima,p0);
    error=abs(p-p0);
    n=1;
    fprintf('TABLA DE ITERACIONES\n  n=%3.0f   Po=%9.15f   P=%9.15f   E=%e\n',double(n),double(p0),double(p),double(error));
    while error>errorPrecision
        n=n+1;
        p0=vpa(p);
        p=p0-(subs(Fx,p0)/subs(Fprima,p0));
        error=abs(p-p0);
        fprintf('  n=%3.0f   Po=%9.15f   P=%9.15f   E=%e\n',double(n),double(p0),double(p),double(error));
    end
fprintf('\n\t\tEl valor aproximado de x es: %9.15f\n',double(p));
else
    disp('Error f prima es igual a 0')
end