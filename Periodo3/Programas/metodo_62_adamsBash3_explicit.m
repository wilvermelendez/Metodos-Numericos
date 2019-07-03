%M�TODO EXPL�CITO DE ADAMS-BASHFORTH DE TRES PASOS
% - Introduzca la ecuaci�n diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condici�n y(a)=b            : 'y(0)=0.5'
% - Introduzca la funci�n de trabajo          : y-(x^2)+1
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tama�o de paso h            : 0.1
% - Introduzca la condici�n inicial           : 0.5
clear all
clc
fprintf('M�TODO DE EXPL�CITO DE ADAMS BASHFORTH DE TRES PASOS\n')
syms x y
d=input('Introduzca la ecuaci�n diferencial(x,y): ');
n=input('Introduzca la condici�n y(a)=b: ');
f1=input('Introduzca la funci�n de trabajo: ');
ya=input('Introduzca la condici�n inicial: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tama�o de paso h: ');

m = dsolve(d,n,'x');
d=0;
%Este for obtiene y guarda todos los valores de t
%Tambi�n se utiliza para evaluar la ecuaci�n diferencial
for p=a:h:b
   M(d+1,1)=d;
   d=1+d;
   M(d,2)=p;
   M(d,4)=subs(m,p);
end
fprintf('La soluci�n de la ecuaci�n diferencial es :');
pretty(m);
i=2;
M(1,2)=a;
M(1,3)=ya;
M(2,3)=double(subs(m,M(2,2)));
M(3,3)=double(subs(m,M(3,2)));
M(1,4)=ya;
a=a+(3*h);
fprintf('F�RMULAS DE CADA ITERACI�N\n');
fprintf('Yi+1 = Yi + (h/12)*(23f(ti,yi)-16f(ti-1 , yi-1)+ 5f(ti-2,yi-2))\n');
for j=a:h:b
   i=1+i;
   M(i+1,3)=M(i,3)+((h/12)*((23*(subs(f1,{x,y},{M(i,2),M(i,3)})))-(16*(subs(f1,{x,y},{M(i-1,2),M(i-1,3)})))+(5*(subs(f1,{x,y},{M(i-2,2),M(i-2,3)})))));   
end
%Error
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('      i                ti                   Y(ti)                  F(ti)              Error\n');   
M