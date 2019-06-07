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
%Formula para las difernecias divididas no son automáticas. esta funcion
%para un polinomio de grado 4
fprintf('\nFormulas de diferencias divididas A^1:');
fprintf('\nF[z0]=F(x0) F[z1]=F(x0) F[z2]=F(x1) F[z3]=F(x1) F[z4]=F(x2) F[z5]=F(x2)  2*1 ');
fprintf('\nF[z1,z0]=Fprima(x0)');
fprintf('\nF[z2,z1]=(F[z2]-F[z1])/(z2-z1)');
fprintf('\nF[z3,z2]=Fprima(x1)');
fprintf('\nF[z4,z3]=(F[z4]-F[z3])/(z4-z3)');
fprintf('\nF[z5,z4]=Fprima(x2)');
fprintf('\nFormulas de diferencias divididas A^2');
fprintf('\nF[z2,z1,z0]=(F[z2,z1]-F[z1,z0])/(z2-z0)');
fprintf('\nF[z3,z2,z1]=(F[z3,z2]-F[z2,z1])/(z3-z1)');
fprintf('\nF[z4,z3,z2]=(F[z4,z3]-F[z3,z2])/(z4-z2)');
fprintf('\nFormulas de diferencias divididas A^3');
fprintf('\nF[z3,z2,z1,z0]=(F[z3,z2,z1]-F[z2,z1,z0])/(z3-z0)');
fprintf('\nF[z4,z3,z2,z1]=(F[z4,z3,z2]-F[z3,z2,z1])/(z4-z1)');
fprintf('\nFormulas de diferencias divididas A^4:');
fprintf('\nF[z4,z3,z2,z1,z0]=(F[z4,z3,z2,z1]-F[z3,z2,z1,z0])/(z4-z0)\n');

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
%imprimiendo formular SOLO en terminos x
fprintf('\Esta función puede ser copiada y asiganda a una variable para hacer evaluaciones o aplicar simplify en caso de ser necesario\n');
fprintf('H%1.0f(x)= %9.9f + ',double(t-1),double(DD(1,1)));
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
    h=h+factor;
end
fprintf('H%1.0f(%3.3f)= %9.9f\n\n',double(t-1),double(val),double(h));
if opc==1
    fprintf('Valor Exacto de la Función: %9.9f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(h-subs(f,val))));
end