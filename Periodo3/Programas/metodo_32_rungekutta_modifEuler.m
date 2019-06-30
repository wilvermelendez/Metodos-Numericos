% - Introduzca la ecuaci�n diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condici�n y(a)=b            : 'y(0)=0.5'
% - Introduzca la funci�n de trabajo          : y-(x^2)+1
% - Introduzca la condici�n inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tama�o de paso h            : 0.1 
clear all
clc
disp('M�todo modificado de euler\n');
syms x y
d=input('Ingrese la ecuaci�n diferencial(ej ''Dy=cos(2*x)+sin(3*x)''): ');
n=input('Ingrese la condici�n y(a)=b: ');
f1=input('Ingrese la funci�n de trabajo: ');
ya=input('Ingrese la condicion inicial: ');
a=input('Ingrese el valor de a: ');
b=input('Ingrese el valor de b: ');
h=input('Ingrese el valor del paso h: ');

fprintf('La soluci�n de la ecuaci�n diferencial es :');
m = dsolve(d,n,'x');
pretty(m);
%Condiciones para el funcionamiento de los lazos FOR
i=0;
M(1,2)=a;
M(1,3)=ya;
M(1,4)=a;
d=0;
%Este for obtiene y guarda todos los valores de t
%Tambi�n se utiliza para evaluar la ecuaci�n diferencial
for p=a:h:b
   M(d+1,1)=d;
   d=1+d;
   M(d,2)=p;
   M(d,4)=subs(m,p);
end
%Este for obtiene los valores aproximados de soluci�n
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