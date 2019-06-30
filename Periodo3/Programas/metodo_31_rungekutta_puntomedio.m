%MÉTODO DEL PUNTO MEDIO
% - Introduzca la ecuación diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(x^2)+1
% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
clear all
clc
fprintf('MÉTODO DEL PUNTO MEDIO\n')
syms x y
d=input('Introduzca la ecuación diferencial(ej ''Dy=cos(2*x)+sin(3*x)''): ');
n=input('Introduzca la condición y(a)=b: ');
f1=input('Introduzca la función de trabajo: ');
ya=input('Introduzca la condición inicial: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tamaño de paso h: ');
fprintf('La solución de la ecuación diferencial es : \n');
m = dsolve(d,n,'x');
pretty(m);
%Condiciones para el funcionamiento de los lazos FOR
f=f1;
i=0;
M(1,2)=a;
M(1,3)=ya;
M(1,4)=a;
d=0;
c=0;
g=0;
%Este for obtiene y guarda todos los valores de t
%También se utiliza para evaluar la ecuación diferencial
for p=a:h:b
   d=1+d;
   M(d,2)=p;
   M(d,4)=subs(m,p);
end
%Este for se usa para contabilizar las iteraciones
for s=c:1:(d-1)
   g=1+g;
   M(g,1)=(g-1);
end
k3=M(end,1);   
%Este for obtiene los valores aproximados de solución
fprintf('FÓRMULAS DE CADA ITERACIÓN\n');
fprintf('Yi+1=Yi + hf(ti+h/2, yi+(h/2)f(ti,yi))\n');
fprintf('---------------------\n');

fprintf('Y0 = %1.5f\n',ya);
for j=a:h:(b-h)
   i=1+i;
   M(i+1,3)=M(i,3)+(h*(subs(f,{x,y},{(M(i,2)+h/2),M(i,3)+((h/2)*(((subs(f,{x,y},{M(i,2),M(i,3)})))))})));   
   fprintf('Y%1.0f = Y%1.0f + h f(t%1.0f + h/2,w%1.0f + h/2 f(t%1.0f,w%1.0f))\n',i,i-1,i-1,i-1,i-1,i-1);
   fprintf('Y%1.0f = Y%1.0f + %1.5f f(%1.9f + %1.5f,w%1.0f + %1.5f f(%1.9f,w%1.0f))\n',i,i-1,h,M(i,2),(h/2),i-1,(h/2),M(i,2),i-1);
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M