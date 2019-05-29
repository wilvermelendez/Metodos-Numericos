clear all
clc
syms x
disp('MÉTODO DE LA SECANTE')
fprintf('---------------------------\n');
f=input('Función f(x): ');
p0=input('Valor de po=');
p1=input('Valor de p1=');
errorPrecision=input('Precisión: 10^-');
errorPrecision=10^(errorPrecision*-1);
f0=subs(f,p0);
f1=subs(f,p1);
p2=p1-(f1*(p1-p0)/(f1-f0));
error=abs(p2-p1);
n=1;
fprintf('TABLA DE ITERACIONES\n  n=%3.0f  p0=%9.15f  p1=%9.15f  p2=%9.15f  error=%e\n',double(n),double(p0),double(p1),double(p2),double(error));
while error>errorPrecision
    n=n+1;
    p0=p1;
    p1=p2;
    f0=subs(f,p0);
    f1=subs(f,p1);
    p2=p1-(f1*(p1-p0)/(f1-f0));
    error=abs(p2-p1);
    fprintf('  n=%3.0f  p0=%9.15f  p1=%9.15f  p2=%9.15f  error=%e\n',double(n),double(p0),double(p1),double(p2),double(error));
end
fprintf('\n\t\tEl valor aproximado de p es: %9.15f\n',double(p2));