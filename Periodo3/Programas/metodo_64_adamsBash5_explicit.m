%MÉTODO EXPLÍCITO DE ADAMS-BASHFORTH DE CINCO PASOS
% - Introduzca la ecuación diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(x^2)+1
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
% - Introduzca la condición inicial           : 0.5
clear all
clc
fprintf('MÉTODO DE EXPLÍCITO DE ADAMS BASHFORTH DE CINCO PASOS\n')
syms x y
d=input('Introduzca la ecuación diferencial: ');
n=input('Introduzca la condición y(a)=b: ');
f1=input('Introduzca la función de trabajo: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tamaño de paso h: ');
ya=input('Introduzca la condición inicial: ');

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

fprintf(' - La solución de la ecuación diferencial es :');
pretty(m);
i=4;
M(1,2)=a;
M(1,3)=ya;
M(2,3)=double(subs(m,M(2,2)));
M(3,3)=double(subs(m,M(3,2)));
M(4,3)=double(subs(m,M(4,2)));
M(5,3)=double(subs(m,M(5,2)));
M(1,4)=ya;
a=a+(5*h);
fprintf('FÓRMULAS DE CADA ITERACIÓN\n');
fprintf('wi+1 = wi + (h/720)*(1901f(ti,wi) - 2774f(ti-1 , wi-1) + 2616f(ti-2,wi-2) - 1274f(ti-3,wi-3) + 251f(ti-4,wi))\n');
for j=a:h:b
   i=1+i;
   M(i+1,3)=M(i,3)+((h/720)*((1901*(subs(f1,{x,y},{M(i,2),M(i,3)})))-(2774*(subs(f1,{x,y},{M(i-1,2),M(i-1,3)})))+(2616*(subs(f1,{x,y},{M(i-2,2),M(i-2,3)})))-(1274*(subs(f1,{x,y},{M(i-3,2),M(i-3,3)})))+(251*(subs(f1,{x,y},{M(i-4,2),M(i-4,3)})))));
end
fprintf('              i             ti                 wi                 y(t)');   
M