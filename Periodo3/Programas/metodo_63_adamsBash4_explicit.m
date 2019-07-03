%MÉTODO EXPLÍCITO DE ADAMS-BASHFORTH DE CUATRO PASOS
% - Introduzca la ecuación diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(x^2)+1
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
% - Introduzca la condición inicial           : 0.5
clear all
clc
fprintf('MÉTODO DE EXPLÍCITO DE ADAMS BASHFORTH DE CUATRO PASOS\n')
syms x y
d=input('Introduzca la ecuación diferencial: ');
n=input('Introduzca la condición y(a)=b: ');
f1=input('Introduzca la función de trabajo: ');
ya=input('Introduzca la condición inicial: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tamaño de paso h: ');

m = dsolve(d,n,'x');
d=0;
%Este for obtiene y guarda todos los valores de t
%También se utiliza para evaluar la ecuación diferencial
for p=a:h:b
   M(d+1,1)=d;
   d=1+d;
   M(d,2)=p;
   M(d,4)=subs(m,p);
end
fprintf('La solución de la ecuación diferencial es :');
fprintf('Yi+1 = Yi + (h/24)*(55f(ti,yi) - 59f(ti-1 , yi-1) + 37f(ti-2,yi-2) - 9f(ti-3,yi-3))\n');
pretty(m);
f=f1;
i=3;
M(1,2)=a;
M(1,3)=ya;
M(2,3)=double(subs(m,M(2,2)));
M(3,3)=double(subs(m,M(3,2)));
M(4,3)=double(subs(m,M(4,2)));
M(1,4)=ya;

a=a+(4*h);
fprintf('FÓRMULAS DE CADA ITERACIÓN\n');
for j=a:h:b
   i=1+i;
   M(i+1,3)=M(i,3)+((h/24)*((55*(subs(f,{x,y},{M(i,2),M(i,3)})))-(59*(subs(f,{x,y},{M(i-1,2),M(i-1,3)})))+(37*(subs(f,{x,y},{M(i-2,2),M(i-2,3)})))-(9*(subs(f,{x,y},{M(i-3,2),M(i-3,3)})))));
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M