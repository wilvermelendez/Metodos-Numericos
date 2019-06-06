clear all
clc
syms x
disp('INTERPOLACI�N Y POLINOMIO DE LAGRANGE')
fprintf('-------------------------------------\n');
val=input('Valor a interpolar x: ');
dato=input('Datos [X0 X1 X2 ... Xn]: ');
t=length(dato);
fprintf('Valores de la funci�n:\n\t1-Utilizar una funci�n.\n\t2-Ingresar valores\n');
opc=input('Opci�n: ');
switch opc
    case 1
        f=input('Funci�n f(x): ');
        fun=zeros(1,t);
        fprintf('Valores de F(x): ');
        for i=1:t
            fun(i)=subs(f,dato(i));
            fprintf('%f,', fun(i));
        end
    case 2
        fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
end
fprintf('\nGrado del Polinomio: %2.0f\n',t-1);
fprintf('\nObteniendo las Funciones de Lagrange\n');
L=zeros(1,t);
Lx=zeros(1,t);
for i=1:t
    num=1;
    fprintf('\t   ')
    for j=1:t        
        if j~=i
            fprintf('(x-x%1.0f)',j-1);
        end
    end
    fprintf('\nL%1.0f(x)=',i-1);
    for j=1:t
        fprintf('--------');
    end
    fprintf('\n\t   ');
    den=1;
    for j=1:t 
        if j~=i
            fprintf('(x%1.0f-x%1.0f)',i-1,j-1);
        end
    end
    fprintf('\n\n');
end
fprintf('\nCon Valores\n');
for i=1:t
    num=1;
    %numx=1;
    fprintf('\t   ')
    for j=1:t        
        if j~=i
            fprintf('(x-(%3.3f))',dato(j));
            num=num*(val-dato(j));
            %numx=numx*(x-dato(j));
        end
    end
    fprintf('\nL%1.0f(x)=',i-1);
    for j=1:t
        fprintf('------------');
    end
    fprintf('\n\t   ');
    den=1;
    for j=1:t 
        if j~=i
            fprintf('(%3.3f-(%3.3f))',dato(i),dato(j));
            den=den*(dato(i)-dato(j));
        end
    end
    L(i)=num/den;
    %Lx(i)=numx/den;
    fprintf('\nL%1.0f(%3.3f)=%9.15f\n\n',i-1,val,L(i));
end
%Lx
fprintf('Polinomio:\n');
fprintf('P%1.0f(x)=',t-1);
pol=0;
for i=1:t
    fprintf('L%1.0f(x)*F(X%1.0f)',i-1,i-1);
    pol=pol+(L(i)*fun(i));
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('P%1.0f(%3.3f)=',double(t-1),double(val));
for i=1:t
    fprintf('(%9.15f)*(%9.15f)',L(i),fun(i));
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('P%1.0f(%3.3f)= %9.15f\n\n',double(t-1),double(val),double(pol));
if opc==1
    fprintf('Valor Exacto de la Funci�n: %9.15f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));
end