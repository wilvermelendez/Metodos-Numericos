clear all
clc
syms x
disp('M�TODO DE PUNTO FIJO')
fprintf('---------------------------\n');
Gx=input('Funci�n g(x): ');
p0=input('Valor de Po=');
errorPrecision=input('Precisi�n: 10^-');
errorPrecision=10^(errorPrecision*-1);
p1=subs(Gx,p0);
n=1;
error=abs(p1-p0);
fprintf('TABLA DE ITERACIONES\n  n=%3.0f  Po=%9.15f  P=%9.15f  error=%e\n',double(n),double(p0),double(p1),double(error));
while error>errorPrecision
    n=n+1;
    p0=p1;
    p1=subs(Gx,p0);
    error=abs(p1-p0);
    fprintf('  n=%3.0f  Po=%9.15f  P=%9.15f  tol=%e\n',double(n),double(p0),double(p1),double(error));
end
fprintf('\n\t\tEl valor aproximado de x es: %9.15f\n',double(p1))
