clear all;
clc;
fprintf('MÉTODO DE EULER\n');
syms x y;
format long;
d=input('Introduzca la ecuación diferencial (ej ''Dy=cos(2*x)+sin(3*x)''): ' );
n=input('Introduzca la condición ''(y(x)=k)'': ');
f1=input('Introduzca la función de trabajo: ');
ya=input('Introduzca la condición inicial: ');
fprintf('Introduzca el intervalo de evaluacion.\n');
a=input('Desde: ');
b=input('Hasta: ');
h=input('Introduzca h: ');
fprintf('La solución de la ecuación diferencial es : \n\n');
m = dsolve(d,n,'x');
pretty(m)
%Condiciones para el funcionamiento de los lazos FOR
f=f1;
i=0;
M(1,2)=a;
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
%formulas y valores aproximados
fprintf('FÓRMULAS DE CADA ITERACIÓN\n');
fprintf('------------------------------------------------\n');
fprintf('Yi+1 = yi+h*f(xi,yi)\n');
fprintf('Y0 = %10.15f\n',ya);
for j=a:h:(b-h)
   i=1+i;
   M(i+1,3)=M(i,3)+(h*(subs(f,{x,y},{M(i,2),M(i,3)})));   
   fprintf('Y%1.0f = y%1.0f + h f(x%1.0f,y%1.0f)\n',i,i-1,i-1,i-1);
   fprintf('Y%1.0f = y%1.0f + %1.5f f(%10.15f,%10.15f)\n',i,i-1,h,M(i,2),M(i,3));
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M

