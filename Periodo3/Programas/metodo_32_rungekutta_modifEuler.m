% - Introduzca la ecuación diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(x^2)+1
% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1 
clear all
clc
disp('Método modificado de euler\n');
syms x y
d=input('Ingrese la ecuación diferencial(ej ''Dy=cos(2*x)+sin(3*x)''): ');
n=input('Ingrese la condición y(a)=b: ');
f1=input('Ingrese la función de trabajo: ');
ya=input('Ingrese la condicion inicial: ');
a=input('Ingrese el valor de a: ');
b=input('Ingrese el valor de b: ');
h=input('Ingrese el valor del paso h: ');

fprintf('La solución de la ecuación diferencial es :');
m = dsolve(d,n,'x');
pretty(m);
%Condiciones para el funcionamiento de los lazos FOR
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
%Este for obtiene los valores aproximados de solución
disp('Formulas de cada iteracion');
fprintf('Yi+1 = Yi + (h/2)f(ti,yi) + (h/2)f(ti+1, yi+hf(ti,yi))\n');
fprintf('Y0 = %1.5f\n',ya);
for j=a:h:(b-h)
    i=1+i;
    M(i+1,3)=M(i,3)+((h/2)*(subs(f1,{x,y},{M(i,2),M(i,3)})))+((h/2)*(subs(f1,{x,y},{(M(i,2)+h),(M(i,3)+(h*(subs(f1,{x,y},{M(i,2),M(i,3)}))))})));  
    fprintf('Y%1.0f = Y%1.0f + h/2 f(t%1.0f,y%1.0f) + h/2 f(t%1.0f + h,y%1.0f + h f(t%1.0f,y%1.0f))\n',i,i-1,i-1,i-1,i-1,i-1,i-1,i-1);
    fprintf('Y%1.0f = Y%1.0f + %1.5f f(%1.9f,y%1.0f) + %1.5f f(%1.9f + %1.5f,y%1.0f + %1.5f f(%1.9f,y%1.0f))\n',i,i-1,h/2,M(i,2),i-1,h/2,M(i,2),h,i-1,h,M(i,2),i-1);
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M