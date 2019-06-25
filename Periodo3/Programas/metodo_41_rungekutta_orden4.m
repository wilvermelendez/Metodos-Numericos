%MÉTODO DE RUNGE-KUTTA DE ORDEN CUATRO
%EN TERMINOS DE T Y
% - Introduzca la ecuación diferencial        : 'Dy=y-(t^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(t^2)+1
% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
clc
clear all
disp('Método de RUNGE-KUTTA de orden 4');
syms t y 
d=input('Ingrese la ecuación diferencial en (x,y): ');
n=input('Ingrese la condición y(a)=b: ');
f1=input('Ingrese la función de trabajo: ');
ya=input('Ingrese el valor de la condicion: ');
a=input('Ingrese el valor de a: ');
b=input('Ingrese el valor de b: ');
h=input('Ingrese el valor h: ');
fprintf('La solución de la ecuación diferencial es : \n');
m = dsolve(d,n,'t');
pretty(m);
n=(b-a)/h;

M(1,3)=ya;
M(1,4)=a;
d=0;
%Este for obtiene y guarda todos los valores de t
%También se utiliza para evaluar la ecuación diferencial
for p=a:h:b
   M(d+1,1)=d;
   d=1+d;
   M(d,2)=p;
   M(d,4)=subs(m,p);
end
disp('Formulas de cada iteracion');
fprintf('w0 = %9.15f \n',ya);
i=1;
for j=0:(n)
   fprintf('Iteración: %1.0f\n',i);  
   k1=h*subs(f1,{t,y},{M(i,2),M(i,3)});
   fprintf('K1 = %9.15f\n',double(k1)) 
   k2=h*subs(f1,{t,y},{(M(i,2)+(h/2)),(M(i,3)+(k1/2))});
   fprintf('K2 = %9.15f\n',double(k2))
   k3=h*subs(f1,{t,y},{(M(i,2)+(h/2)),(M(i,3)+(k2/2))});
   fprintf('K3 = %9.15f\n',double(k3))
   k4=h*subs(f1,{t,y},{(M(i,2)+h),(M(i,3)+k3)});
   fprintf('K4 = %9.15f\n',double(k4))
   M(i+1,3)=M(i,3)+((1/6)*(k1+(2*k2)+(2*k3)+k4));
   fprintf('w%1.0f = %9.15f\n',i,double(M(i+1,3)))
   i=i+1;
end
fprintf('              i             ti                wi+1                y(t)                Error\n');
for i=1:n
    M(i,5)=abs(M(i,4)-M(i,3));
end
M