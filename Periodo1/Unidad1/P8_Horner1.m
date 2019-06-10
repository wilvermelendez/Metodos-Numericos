clear all
clc
syms x
format long
disp('Método de Horner')
fprintf('---------------------------\n');
xo=input('Valor de Xo=');
polinomio=input('Coeficientes Ordenados del Polinomio[]: ');
errorPrecision=input('Precisión: 10^-');
errorPrecision=10^(errorPrecision*-1);
longitudPolinomio = length(polinomio);
Division_Sintetica_1=zeros(3,longitudPolinomio);
Division_Sintetica_2=zeros(3,longitudPolinomio-1);
for i=1:longitudPolinomio
    Division_Sintetica_1(1,i)=polinomio(i);
end
Division_Sintetica_1(3,1)=polinomio(1);
continuar=1;
n=1;
while continuar==1
    fprintf('\n---------------------------------------------------------\n');
    fprintf('\nITERACION No %1.0f ',n);
    for i=2:longitudPolinomio %Primera División Sintetica
        Division_Sintetica_1(2,i)=xo*Division_Sintetica_1(3,i-1);
        Division_Sintetica_1(3,i)=Division_Sintetica_1(1,i)+Division_Sintetica_1(2,i);
        if i~=longitudPolinomio
            Division_Sintetica_2(1,i)=Division_Sintetica_1(3,i);
        end
    end
    Division_Sintetica_1 %#ok
    bo=Division_Sintetica_1(3,longitudPolinomio); %bop 1
    Division_Sintetica_2(3,1)=polinomio(1);
    for i=2:longitudPolinomio-1 %Segunda División Sintetica
        Division_Sintetica_2(2,i)=xo*Division_Sintetica_2(3,i-1);
        Division_Sintetica_2(3,i)=Division_Sintetica_2(1,i)+Division_Sintetica_2(2,i);
    end
    Division_Sintetica_2 %#ok
    Qo=Division_Sintetica_2(3,longitudPolinomio-1); %boq 2
    x1=xo-(bo/Qo); 
    error=abs(x1-xo);
    fprintf('\nXo=%9.15f  bo=%9.15f  Qo=%9.15f  X1=%9.15f  error=%e\n',double(xo),double(bo),double(Qo),double(x1),double(error));
    n=n+1;
    if error < errorPrecision
        continuar=0;
    else
        xo=x1;
    end
end
fprintf('\n---------------------------------------------------------\n');
fprintf('\n\t\tEl valor aproximado de x es: %9.15f\n\n',double(x1))