clear all
clc
syms x
disp('DIFERENCIAS DIVIDIDAS')
valor=input('Valor a interpolar x: ');
datos=input('Datos Ordenados[X0 X1 X2 ... Xn]: ');
longitud=length(datos);
% fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
f=input('Funci�n f(x): ');
fun=double(subs(f,datos));
DD=zeros(longitud);
DD(:,1)=fun';
for j=2:longitud
    for i=j:longitud
        DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(datos(i)-datos(i-j+1));
    end
end
DD

aproximado=DD(1,1);
polx=0;
for i=2:longitud
    factor=DD(i,i);
    factorx=factor;
    for j=1:i-1
        factor=factor*(valor-datos(j));
        factorx=factorx*(x-datos(j));
    end
    aproximado=aproximado+factor;
    polx=polx+factorx;
end
pretty(simplify(polx))
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(longitud-1),double(valor),double(aproximado));
% fprintf('Valor Exacto de la Funci�n: %9.9f',double(subs(f,val)));
% fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));
 