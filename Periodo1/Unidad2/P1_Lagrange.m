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
        fprintf('Valores de F(x): ');
        fun=double(subs(f,dato));
        fun %#ok<NOPTS>
    case 2
        fun=input('Valores F(x) [F(X0) F(X1) ... F(Xn)]: ');
end
fprintf('\nGrado del Polinomio: %2.0f',t-1);
fprintf('\nObteniendo las Funciones de Lagrange\n');
L=zeros(1,t);
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
fprintf('\nLx en termino de x\n');
for i=1:t
    num=1;
    fprintf('\t   ')
    for j=1:t        
        if j~=i
            fprintf('(x-(%3.3f))*',dato(j));
            num=num*(val-dato(j));
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
            den=den*(dato(i)-dato(j));
        end
    end
    fprintf('(%9.9f)',den);
   
end
fprintf('\nCon Valores numerador y denominador en termino de x\n');
for i=1:t
    num=1;
    numx=1;
    fprintf('\t   ')
    for j=1:t        
        if j~=i
            fprintf('(x-(%3.3f))',dato(j));
            num=num*(val-dato(j));
            numx=numx*(x-dato(j));
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
    Lx(i)=numx/den;
    fprintf('\nL%1.0f(%3.3f)=%9.9f\n\n',i-1,val,L(i));
end


fprintf('\nFormula\n');
fprintf('P%1.0f(x)=',t-1);
pol=0;
polx=0;
for i=1:t
    fprintf('F(X%1.0f)*L%1.0f(x)',i-1,i-1);
    pol=pol+(L(i)*fun(i));
    polx=polx+(Lx(i)*fun(i));
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end

fprintf('Formula en termino de x\n');
fprintf('P%1.0f(x)=\n\n',t-1);
pretty(simplify(polx))
fprintf('\nP%1.0f(%3.3f)=',double(t-1),double(val));
for i=1:t
    fprintf('(%9.9f)*(%9.9f)',fun(i),L(i));
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('P%1.0f(%3.3f)= %9.9f\n\n',double(t-1),double(val),double(pol));
if opc==1
    fprintf('Valor Exacto de la Funci�n: %9.9f',double(subs(f,val)));
    fprintf('\nError: %e\n\n',double(abs(pol-subs(f,val))));
end