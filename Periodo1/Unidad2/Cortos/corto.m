clear all
clc
syms x
disp('LAGRANGE')
valor=input('Valor a aproximar x: ');
datos=input('Datos [X0 X1 X2 ... Xn]: ');
longitud=length(datos);
% fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
f=input('Función f(x): ');
fun=double(subs(f,datos));
L=zeros(1,longitud);
aproximado=0;
polx=0;
for i=1:longitud
    num=1;
    numx=1;
    den=1;
    for j=1:longitud        
        if j~=i
            num=num*(valor-datos(j));
            numx=numx*(x-datos(j));
            den=den*(datos(i)-datos(j));
        end
    end
    L(i)=num/den;
    Lx(i)=numx/den;
    aproximado=aproximado+(L(i)*fun(i));
    polx=polx+(Lx(i)*fun(i));
end
fun
L
pretty(simplify(polx))
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(longitud-1),double(valor),double(aproximado));
%fprintf('Valor Exacto de la Función: %9.9f',double(subs(f,val)));
%fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));



valor=input('Valor a interpolar x: ');
datos=input('Datos [X0 X1 X2 ... Xn]: ');
longitud=length(datos);
% fun=input('Valores Iniciales [F(X0) F(X1) ... F(Xn)]: ');
f=input('Función f(x): ');
fun=double(subs(f,datos));
Q=zeros(longitud);
Q(:,1)=fun;
for i=2:longitud
    for j=2:i
        Q(i,j)=(((valor-datos(i-j+1))*Q(i,j-1))-((valor-datos(i))*Q(i-1,j-1)))/(datos(i)-datos(i-j+1));
    end
end
Q
fprintf('\n\nValor Aproximado: %9.9f\n',double(Q(longitud,longitud)));
%fprintf('\nValor Exacto de la Función: %9.9f',double(subs(f,valor)));
%fprintf('\nError: %e\n\n',double(abs(Q(longitud,longitud)-subs(f,valor))));
%fprintf('\nError: %e\n\n',double(abs(Q(longitud-1,longitud-1)-Q(longitud,longitud))));

valor=input('Valor a interpolar x: ');
datos=input('Datos Ordenados[X0 X1 X2 ... Xn]: ');
longitud=length(datos);
% fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
f=input('Función f(x): ');
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
polx=1;
for i=2:longitud
    factor=DD(i,i);
    factorx=1;
    for j=1:i-1
        factor=factor*(valor-datos(j));
        factorx=factorx*(x-datos(j));
    end
    aproximado=aproximado+factor;
    polx=polx+factorx;
end
pretty(simplify(polx))
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(longitud-1),double(valor),double(aproximado));
% fprintf('Valor Exacto de la Función: %9.9f',double(subs(f,val)));
% fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));
 