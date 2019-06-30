%M�TODO DE TAYLOR DE ORDEN SUPERIOR
%OJO ESTA EN FUNCION DE Y y X
% - Indique el orden a utilizar               : 4
% - Introduzca la ecuaci�n diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condici�n y(a)=b            : 'y(0)=0.5'
% - Se pidi� aproximaci�n de valor 1=(Si)     : 1
% - Introduzca el valor a aproximar           : 0.75

% - Funci�n: 1
% - Introduzca la funci�n de trabajo          : y-(x^2)+1

% - Funci�n: 2
% - Introduzca la funci�n de trabajo          : y-(x^2)-(2*x)+1

% - Funci�n: 3
% - Introduzca la funci�n de trabajo          : y-(x^2)-(2*x)-1

% - Funci�n: 4
% - Introduzca la funci�n de trabajo          : y-(x^2)-(2*x)-1

% - Introduzca la condici�n inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tama�o de paso h            : 0.1
clear all
clc
fprintf('M�TODO DE TAYLOR DE ORDEN SUPERIOR\n')
syms x y
eb=0;
ix=0;
e=input('Indique el orden a utilizar: ');
d=input('Introduzca la ecuaci�n diferencial (ej: ''Dy=y-(x^2)+1''): ');
n=input('Introduzca la condici�n y(a)=b: ');
for ea=1:1:e
   fprintf('Funci�n: %1.0f ',ea);
   f1(ea)=input('Introduzca la funci�n de trabajo: ');
end
ya=input('Introduzca la condici�n inicial: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tama�o de paso h: ');
fprintf('La soluci�n de la ecuaci�n diferencial es : \n');

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
n=length(h:(b-h));
%Este for obtiene los valores aproximados de soluci�n
fprintf('FORMULAS: \n');
fprintf('Yi+1 = Yi+h*f(ti,yi)+(h^2/2!)*f1(ti,yi)+(h^3/3!)*f2(ti,yi)+(h^4/4!)*f3(ti,yi)+...+(h^n/n!)*fn-1(ti,yi)\n');
for sp=a:h:(b-h)
   af=sprintf(' Y%1.0f = Y%1.0f',i+1,i);
   ag=sprintf(' Y%1.0f = %1.15f',i+1,M(i+1,3));
   i=1+i;
   qc=0;
   sd=1;
   while sd <= e
      qc=qc+(((h^(sd))/(factorial(sd)))*(subs((f1(sd)),{x,y},{M(i,2),M(i,3)})));
      ad=sprintf(' + h^%1.0f/%1.0f f%1.0f (t%1.0f, y%1.0f)',sd,factorial(sd),sd-1,i-1,i-1);
      ah=sprintf(' + %10.8f^%1.0f/%1.0f f%1.0f (%10.8f, %10.8f)',h,sd,factorial(sd),sd-1,M(i,2),M(i,3));
      af=[af,ad];
      ag=[ag,ah];
      sd=sd+1;         
   end
   disp(af)
   M(i+1,3)=M(i,3)+qc; 
   disp(ag)
   af=' ';
   ag=' ';
end
M(:,5)=abs(M(:,4)-M(:,3));
fprintf('\n       i                ti                   Y(ti)                  F(ti)              Error\n');   
M
