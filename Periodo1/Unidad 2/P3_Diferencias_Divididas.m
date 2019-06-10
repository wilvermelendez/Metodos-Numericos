clear all
clc
syms x
disp('MÉTODO DE LAS DIFERENCIAS DIVIDIDAS')
fprintf('-------------------------------------\n');
val=input('Valor a interpolar x: ');
dato=input('Datos Ordenados[X0 X1 X2 ... Xn]: ');
t=length(dato);
fprintf('Valores de la función:\n\t1-Utilizar una función.\n\t2-Ingresar valores\n');
opc=input('Opción: ');
switch opc
    case 1
        f=input('Función f(x): ');
        fprintf('Valores de F(x): ');
        fun=double(subs(f,dato));
        fun %#ok<NOPTS>
    case 2
        fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
end
%Formula para las difernecias divididas no son automáticas. esta funcion
%para un polinomio de grado 4
fprintf('\nFormulas de diferencias divididas A^1:');
fprintf('\nF[x1,x0]=(F[x1]-F[x0])/(x1-x0)');
fprintf('\nF[x2,x1]=(F[x2]-F[x1])/(x2-x1)');
fprintf('\nF[x3,x2]=(F[x3]-F[x2])/(x3-x2)');
fprintf('\nF[x4,x3]=(F[x4]-F[x3])/(x4-x3)');
fprintf('\nFormulas de diferencias divididas A^2');
fprintf('\nF[x2,x1,x0]=(F[x2,x1]-F[x1,x0])/(x2-x0)');
fprintf('\nF[x3,x2,x1]=(F[x3,x2]-F[x2,x1])/(x3-x1)');
fprintf('\nF[x4,x3,x2]=(F[x4,x3]-F[x3,x2])/(x4-x2)');
fprintf('\nFormulas de diferencias divididas A^3');
fprintf('\nF[x3,x2,x1,x0]=(F[x3,x2,x1]-F[x2,x1,x0])/(x3-x0)');
fprintf('\nF[x4,x3,x2,x1]=(F[x4,x3,x2]-F[x3,x2,x1])/(x4-x1)');
fprintf('\nFormulas de diferencias divididas A^4:');
fprintf('\nF[x4,x3,x2,x1,x0]=(F[x4,x3,x2,x1]-F[x3,x2,x1,x0])/(x4-x0)\n');

DD=zeros(t);
%fprintf('\nObteniendo las diferencias divididas:');
DD(:,1)=fun';

%Calculando diferencias divididas
for j=2:t
    %fprintf('\n - Columna %2.0f de diferencias divididas\n',j);
    for i=j:t
        DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(dato(i)-dato(i-j+1));
        %imprimir formula de diferencias divididas en valores
        %fprintf('(%8.15f-(%8.15f))/(%3.3f-(%3.3f)) = %9.9f\n',double(DD(i,j-1)),double(DD(i-1,j-1)),double(dato(i)),double(dato(i-j+1)),double(DD(i,j)));
    end
end

DD %#ok<NOPTS>
fprintf('\nPolinomio grado %1.0f\n',t-1);
pol=DD(1,1);
fprintf('P%1.0f(x)= A0 + ',t-1);
%imprimiendo formular en terminos de Ai y de x y xi
for i=2:t
    fprintf('A%1.0f',i-1);
    for j=1:i-1
        fprintf('(x-x%1.0f)',j-1);
    end
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end

%imprimiendo formular SOLO en terminos x
fprintf('\nEsta función puede ser copiada y asiganda a una variable para hacer evaluaciones o aplicar simplify en caso de ser necesario\n');
fprintf('P%1.0f(x)= %9.9f + ',t-1,DD(1,1));
for i=2:t
    fprintf('%9.9f*',DD(i,i));
    for j=1:i-1
        if j~=i-1
            fprintf('(x-(%9.9f))*',dato(j));
        else
            fprintf('(x-(%9.9f))',dato(j));
        end
    end
    if i==t
        fprintf('\n\n');
    else
        fprintf(' + ');
    end
end


for i=2:t
    factor=DD(i,i);
    for j=1:i-1
        factor=factor*(val-dato(j));
    end
    pol=pol+factor;
end
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(t-1),double(val),double(pol));
if opc==1
    fprintf('Valor Exacto de la Función: %9.9f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));
end 