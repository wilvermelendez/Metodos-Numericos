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

for i=1:longitud
    num=1;
    den=1;
    for j=1:longitud        
        if j~=i
            num=num*(valor-datos(j));
            den=den*(datos(i)-datos(j));
        end
    end
    L(i)=num/den;
    aproximado=aproximado+(L(i)*fun(i));
end
fun
L
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(longitud-1),double(valor),double(aproximado));
%fprintf('Valor Exacto de la Función: %9.9f',double(subs(f,val)));
%fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));