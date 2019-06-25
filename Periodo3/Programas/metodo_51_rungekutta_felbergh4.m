%M�TODO DE RUNGE-KUTTA-FEHLBERG
% - Introduzca la ecuaci�n diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condici�n y(a)=b            : 'y(0)=0.5'
% - Introduzca la funci�n de trabajo          : y-(x^2)+1
% - Introduzca la condici�n inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tama�o de paso h            : 0.1
clc
clear all
disp('M�todo de RUNGE-KUTTA-FEHLBERG de orden 4');
syms x y
d=input('Ingrese la ecuaci�n diferencial en (x,y): ');
n=input('Ingrese la condici�n y(a)=b: ');
f1=input('Ingrese la funci�n de trabajo: ');
ya=input('Ingrese el valor de la condicion: ');
a=input('Ingrese el valor de a: ');
b=input('Ingrese el valor de b: ');
h=input('Ingrese el valor de h: ');
fprintf('La soluci�n de la ecuaci�n diferencial es : \n');
m = dsolve(d,n,'x');
pretty(m);
i=0;
M(1,2)=a;
M(1,3)=ya;
M(1,4)=a;
d=0;
disp('Formulas por iteracion');
%Este for obtiene y guarda todos los valores de t
%Tambi�n se utiliza para evaluar la ecuaci�n diferencial
for p=a:h:b
    M(d+1,1)=d;
    d=1+d;
    M(d,2)=p;
    M(d,4)=subs(m,p);
end
fprintf('w0 = %1.9f\n',ya);
for j=a:h:(b-h)
    i=1+i;
    fprintf('Iteraci�n: %1.0f\n',i);
    k1=h*subs(f1,{x,y},{M(i,2),M(i,3)});
    fprintf('K1 = %9.15f\n',double(k1))
    k2=h*subs(f1,{x,y},{M(i,2)+h/4,M(i,3)+k1/4});
    fprintf('K2 = %9.15f\n',double(k2))
    k3=h*subs(f1,{x,y},{M(i,2)+(3.*h/8),M(i,3)+(3.*k1/32)+(9.*k2/32)});
    fprintf('K3 = %9.15f\n',double(k3))
    k4=h*subs(f1,{x,y},{M(i,2)+(12.*h/13),M(i,3)+(1932.*k1/2197)-(7200.*k2/2197)+(7296.*k3/2197)});
    fprintf('K4 = %9.15f\n',double(k4))
    k5=h*subs(f1,{x,y},{M(i,2)+h,M(i,3)+(439.*k1/216)-(8.*k2)+(3680.*k3/513)-(845.*k4/4104)});
    fprintf('K5 = %9.15f\n',double(k5))
    M(i+1,3)=M(i,3)+(25*k1/216)+(1408*k3/2565)+(2197*k4/4104)-(k5/5);
    fprintf('w%1.0f = %9.15f\n',i,double(M(i+1,3)))
end

n=(b-a)/h;
for i=1:n
    M(i,5)=abs(M(i,4)-M(i,3));
end
fprintf('              i             ti                wi+1                y(t)              Error');   
M