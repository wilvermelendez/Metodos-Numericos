clear all
clc
syms x
disp('MÉTODO DE STEFFENSEN')
fprintf('---------------------------\n');
Gx=input('Función g(x): ');
p0=input('Valor de Po=');
errorPrecision=input('Precisión: 10^-');
errorPrecision=10^(errorPrecision*-1);
p1=subs(Gx,p0);
p2=subs(Gx,p1);
P=p0-((p1-p0)^2/(p2-2*p1+p0));
n=1;
error=abs(P-p0);
fprintf('TABLA DE ITERACIONES\n n=%2.0f  Po=%9.15f  P1=%9.15f  P2=%9.15f  P=%9.15f  error=%e\n',double(n),double(p0),double(p1),double(p2),double(P),double(error));
while error>errorPrecision
    n=n+1;
    p0=P;
    p1=subs(Gx,p0);
    p2=subs(Gx,p1);
    P=p0-((p1-p0)^2/(p2-2*p1+p0));
    error=abs(P-p0);
    fprintf(' n=%2.0f  Po=%9.15f  P1=%9.15f  P2=%9.15f  P=%9.15f  error=%e\n',double(n),double(p0),double(p1),double(p2),double(P),double(error));
end
fprintf('\n\t\tEl valor aproximado de x es: %9.15f\n',double(P))