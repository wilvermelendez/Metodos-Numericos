clear all
clc
syms x
disp('NEVILLE')
valor=input('Valor a interpolar x: ');
datos=input('Datos [X0 X1 X2 ... Xn]: ');
longitud=length(datos);
% fun=input('Valores Iniciales [F(X0) F(X1) ... F(Xn)]: ');
f=input('Función f(x): ');
fun=zeros(1,longitud);
for i=1:longitud
    fun(i)=subs(f,datos(i));
end
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
