clear all;
clc;
syms x
disp('INTERPOLACION DE HERMITE POR DIFERENCIAS DIVIDIDAS')
fprintf('----------------------------------------------------------\n');
val=input('Valor a interpolar x: ');
vars=input('Datos Ordenados[X0 X1 X2 ... Xn]: ');
t=2*length(vars);
dato=zeros(1,t);
for i=1:t/2
    dato(2*i-1)=vars(i);
    dato(2*i)=vars(i);
end
fprintf('Valores de la función:\n\t1-Utilizar una función.\n\t2-Ingresar valores\n');
opc=input('Opción: ');
switch opc
    case 1
        f=input('Función f(x): ');
        fundif=zeros(1,t/2);
        fun=zeros(1,t/2);
        fprintf('Valores de F(x): ');
        for i=1:t/2
            fun(i)=subs(f,vars(i));
            fprintf('%0.15f,',fun(i));
        end
        fprintf('\nValores de F´(x): ');
        for i=1:t/2
            fundif(i)=subs(diff(f,x),vars(i));
            fprintf('%f,', fundif(i));
        end
    case 2
        fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
        fundif=input('Valores F´(x) [F´(X0) F´(X1) ... F´(Xn)]: ');
end
DD=zeros(t);
fprintf('\nObteniendo las diferencias divididas:');
for i=1:t/2 
    DD(2*i-1,1)=fun(i);
    DD(2*i,1)=fun(i);
end
for j=2:t
    for i=j:t
        if dato(i)~=dato(i-j+1)
            DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(dato(i)-dato(i-j+1));    
        else
            DD(i,j)=fundif(i/2);
        end
    end
end
DD %#ok<NOPTS>
fprintf('\nPolinomio grado %1.0f\n',double(t-1));
h=DD(1,1);
fprintf('H%1.0f(x)= A0 + ',double(t-1));
for i=2:t
    fprintf('A%1.0f',(i-1));
    for j=1:i-1
        fprintf('(x-x%1.0f)',double(j-1));
    end
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(x)= %8.8f + ',double(t-1),double(DD(1,1)));
for i=2:t
    factor=DD(i,i);
    fprintf('%8.8f*',double(DD(i,i)));
    for j=1:i-1
        fprintf('(x-(%3.3f))',double(dato(j)));
        factor=factor*(val-dato(j));
    end
    h=h+factor;
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(%3.3f)= %9.15f\n\n',double(t-1),double(val),double(h));
if opc==1
    fprintf('Valor Exacto de la Función: %9.15f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(h-subs(f,val))));
end