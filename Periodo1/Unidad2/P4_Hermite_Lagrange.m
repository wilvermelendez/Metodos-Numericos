clear all;
clc;
syms x;
disp('INTERPOLACION DE HERMITE POR LAGRANGE')
fprintf('-----------------------------------------------\n');
val=input('Valor a interpolar x: ');
dato=input('Datos Ordenados[X0 X1 X2 ... Xn]: ');
t=length(dato);
fprintf('Valores de la función:\n\t1-Utilizar una función.\n\t2-Ingresar valores\n');
resp=input('Opción: ');
switch resp
    case 1
        f=input('Función f(x): ');
        fundif=zeros(1,t);
        fun=zeros(1,t);
        fprintf('Valores de F(x): ');
        for i=1:t
            fun(i)=subs(f,dato(i));
            fprintf('%f,', double(fun(i)));
        end
        fprintf('Valores de F´(x): ');
        for i=1:t
            fundif(i)=diff(f,dato(i));
            fprintf('%f,', double(fundif(i)));
        end
    case 2
        fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
        fundif=input('Valores F´(x) [F´(X0) F´(X1) ... F´(Xn)]: ');
end
fprintf('\nValores de los Polinomios de Lagrange y sus derivadas:\n');
L=zeros(1,t);
Lp=zeros(1,t);
for i=1:t
    num=x;
    for j=1:t        
        if j~=i
            num=num*(x-dato(j));
        end
    end
    num=num/x;
    den=1;
    for j=1:t 
        if j~=i
            den=den*(dato(i)-dato(j));
        end
    end
    fax=num/den;
    L(i)=subs(fax,val);
    Lp(i)=subs(diff(fax,x),val);
    fprintf('\nL%1.0f(%3.3f)=%9.15f',double(i-1),double(val),double(L(i)));
    fprintf('\nL´%1.0f(%3.3f)=%9.15f\n',double(i-1),double(val),double(Lp(i)));
end
he=zeros(1,t);
hen=zeros(1,t);
for i=1:t
    he(i)=(1-2*(val-dato(i))*Lp(i))*(L(i))^2;
    hen(i)=(val-dato(i))*(L(i))^2;
    fprintf('\nH%1.0f(%3.3f)=%9.15f',double(i-1),double(val),double(he(i)));
    fprintf('\n^H%1.0f(%3.3f)=%9.15f\n',double(i-1),double(val),double(hen(i)));
end
H=0;
fprintf('\nPolinomio de Hermite\n');
fprintf('\nH%1.0f(%3.3f)=',double(2*t-1),double(val));
for i=1:t
    H=fun(i)*he(i)+fundif(i)*hen(i);
    fprintf('((%5.8f)*(%5.8f) + (%5.8f)*(%5.8f))',double(fun(i)),double(he(i)),double(fundif(i)),double(hen(i)));
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('\nH%1.0f(%3.3f)=%8.8f\n',double(2*t-1),double(val),double(H));