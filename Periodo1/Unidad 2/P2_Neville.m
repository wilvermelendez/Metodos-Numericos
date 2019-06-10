clear all
clc
syms x
disp('MÉTODO DE NEVILLE')
fprintf('-------------------------------\n');
val=input('Valor a interpolar x: ');
dato=input('Datos [X0 X1 X2 ... Xn]: ');
t=length(dato);
fprintf('Valores de la función:\n\t1-Utilizar una función.\n\t2-Ingresar valores\n');
opc=input('Opción: ');
switch opc
    case 1
        f=input('Función f(x): ');
        fun=zeros(1,t);
        fprintf('Valores de F(x): ');
        for i=1:t
            fun(i)=subs(f,dato(i));
        end
    case 2
        fun=input('Valores Iniciales [F(X0) F(X1) ... F(Xn)]: ');
end
Q=zeros(t);
Q(:,1)=fun;
for i=2:t
    for j=2:i
        Q(i,j)=(((val-dato(i-j+1))*Q(i,j-1))-((val-dato(i))*Q(i-1,j-1)))/(dato(i)-dato(i-j+1));
        fprintf('\n\t   (X-X%1.0f)Q%1.0f%1.0f -(X-X%1.0f)Q%1.0f%1.0f     (x-(%3.2f))*(%9.9f) - (x-(%3.2f))*(%9.9f) ',double(i-j),double(i-1),double(j-2),double(i-1),double(i-2),double(j-2),double(dato(i-j+1)),double(Q(i,j-1)),double(dato(i)),double(Q(i-1,j-1)))
        fprintf('\nQ(%1.0f,%1.0f)= --------------------  =  --------------------------------------------------------------- = %9.9f', double(i-1),double(j-1),double(Q(i,j)));
        fprintf('\n\t\t\t  (X%1.0f-X%1.0f)\t\t\t\t\t\t\t\t     (%3.3f)-(%3.3f)\n',double(i-1),double(i-j),double(dato(i)),double(dato(i-j+1)));
    end
end
Q
fprintf('\n\nValor Aproximado: %9.9f\n',double(Q(t,t)));
if opc==1
    fprintf('\nValor Exacto de la Función: %9.9f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(Q(t,t)-subs(f,val))));
else
    fprintf('\nError: %e\n\n',double(abs(Q(t-1,t-1)-Q(t,t))));
end