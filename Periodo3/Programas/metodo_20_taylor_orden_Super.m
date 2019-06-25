%MÉTODO DE TAYLOR DE ORDEN SUPERIOR
%OJO ESTA EN FUNCION DE Y y X
% - Indique el orden a utilizar               : 4
% - Introduzca la ecuación diferencial        : 'Dy=y-(x^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Se pidió aproximación de valor 1=(Si)     : 1
% - Introduzca el valor a aproximar           : 0.75

% - Función: 1
% - Introduzca la función de trabajo          : y-(x^2)+1

% - Función: 2
% - Introduzca la función de trabajo          : y-(x^2)-(2*x)+1

% - Función: 3
% - Introduzca la función de trabajo          : y-(x^2)-(2*x)-1

% - Función: 4
% - Introduzca la función de trabajo          : y-(x^2)-(2*x)-1

% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
clear all
clc
fprintf('MÉTODO DE TAYLOR DE ORDEN SUPERIOR\n')
syms x y
eb=0;
ix=0;
e=input('Indique el orden a utilizar: ');
d=input('Introduzca la ecuación diferencial: ');
n=input('Introduzca la condición y(a)=b: ');
for ea=1:1:e
   fprintf('Función: %1.0f ',ea);
   f1(ea)=input('Introduzca la función de trabajo: ');
end
ya=input('Introduzca la condición inicial: ');
a=input('Introduzca el valor de a: ');
b=input('Introduzca el valor de b: ');
h=input('Introduzca el tamaño de paso h: ');
fprintf('La solución de la ecuación diferencial es : \n');

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
n=length(h:(b-h));
%Este for obtiene los valores aproximados de solución
for sp=a:h:(b-h)
   af=sprintf(' w%1.0f = w%1.0f\n',i+1,i);
   ag=sprintf(' w%1.0f = %1.15f\n',i+1,M(i+1,3));
   i=1+i;
   qc=0;
   sd=1;
   fprintf('FORMULAS: \n');
   fprintf('wi+1 = wi+h*f(ti,wi)+(h^2/2!)*f1(ti,wi)+(h^3/3!)*f2(ti,wi)+(h^4/4!)*f3(ti,wi)+...+(h^n/n!)*fn-1(ti,wi)\n');
   fprintf('\n');
   while sd <= e
      qc=qc+(((h^(sd))/(factorial(sd)))*(subs((f1(sd)),{x,y},{M(i,2),M(i,3)})));
      ad=sprintf(' + h^%1.0f/%1.0f f%1.0f (t%1.0f, w%1.0f)',sd,factorial(sd),sd-1,i-1,i-1);
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
fprintf('\n      i             ti                 wi                 y(t)               Error\n');  
for i=1:n
    M(i,5)=abs(M(i,4)-M(i,3));
end
M
