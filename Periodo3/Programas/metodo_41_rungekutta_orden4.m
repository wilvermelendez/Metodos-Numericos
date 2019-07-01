%MÉTODO DE RUNGE-KUTTA DE ORDEN CUATRO
%EN TERMINOS DE T Y
% - Introduzca la ecuación diferencial        : 'Dy=y-(t^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(t^2)+1
% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
clear all;
clc;
disp('Método de RUNGE-KUTTA de orden 4');
syms x y;
d=input('Ingrese la ecuación diferencial (ej ''Dy=cos(2*x)+sin(3*x)''): ');
n=input('Ingrese la condición ''y(a)=b'': ');
f1=input('Ingrese la función de trabajo: ');
ya=input('Ingrese el valor de la condicion: ');
a=input('Ingrese el valor de a: ');
b=input('Ingrese el valor de b: ');
h=input('Ingrese el valor h: ');
fprintf('La solución de la ecuación diferencial es : \n');
m = dsolve(d,n,'x');
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
   %Exacta
   M(:,4)=subs(m,p);
end
fprintf('FÓRMULAS DE CADA ITERACIÓN\n');
fprintf('Yi+1 = Yi + h[a1K1+a2K2+a3K3+a4K4]\n');
fprintf('Y0 = %9.15f \n',ya);
for i=1:n
   fprintf('Iteración: %1.0f\n',i);  
   k1=subs(f1,{x,y},{M(i,2),M(i,3)});
   fprintf('K1 = %9.15f\n',double(k1)) 
   k2=subs(f1,{x,y},{M(i,2)+h/2,M(i,3)+k1*h/2});
   fprintf('K2 = %9.15f\n',double(k2))
   k3=subs(f1,{x,y},{M(i,2)+h/2,M(i,3)+k2*h/2});
   fprintf('K3 = %9.15f\n',double(k3))
   k4=subs(f1,{x,y},{M(i,2)+h,M(i,3)+k3*h});
   fprintf('K4 = %9.15f\n',double(k4))
   M(i+1,3)=M(i,3)+(h/6)*(k1+2*k2+2*k3+k4);
   fprintf('Y%1.0f = %9.15f\n',i,double(M(i+1,3)))
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M
