clear all
clc
fprintf('MÉTODO DE EULER\n')
syms x y
d=input('Introduzca la ecuación diferencial (ej "Dy=cos(2*x)+sin(3*x):"' );
n=input('Introduzca la condición "(y(x)=k)": ');
f1=input('Introduzca la función de trabajo: ');
ya=input('Introduzca la condición inicial: ');
fprintf('Introduzca el intervalo de evaluacion.\n');
a=input('Desde: ');
b=input('Hasta: ');
h=input('Introduzca el tamaño de paso h: ');
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
fprintf('wi+1 = wi+h*f(ti,wi)\n');
fprintf('w0 = %10.15f\n',ya);
for j=a:h:(b-h)
   i=1+i;
   M(i+1,3)=M(i,3)+(h*(subs(f,{x,y},{M(i,2),M(i,3)})));   
   fprintf('w%1.0f = w%1.0f + h f(t%1.0f,w%1.0f)\n',i,i-1,i-1,i-1);
   fprintf('w%1.0f = w%1.0f + %1.5f f(%10.15f,%10.15f)\n',i,i-1,h,M(i,2),M(i,3));
end
fprintf('      i               ti                 wi+1                   y(t)\n');   
M

disp('INTERPOLACION DE HERMITE POR DIFERENCIAS DIVIDIDAS')
fprintf('----------------------------------------------------------\n');
val=input('Valor a interpolar x: ');
vars=M(1:end,2);
t=2*length(vars);
dato=zeros(1,t);
for i=1:t/2
    dato(2*i-1)=vars(i);
    dato(2*i)=vars(i);
end
fun=M(1:end,3);

f=input('Función f(x) prima: ');
fundif=zeros(1,t/2);
for i=1:t/2
    fundif(i)=subs(f,vars(i));
end

DD=zeros(t);
fprintf('\nObteniendo las diferencias divididas:');
for i=1:t/2 
    DD(2*i-1,1)=fun(i);
    DD(2*i,1)=fun(i);
end
for j=2:t
    for i=j:t
        if dato(i)~=dato(i-j+1)
            DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(dato(i)-dato(i-j+1));    
        else
            DD(i,j)=fundif(i/2);
        end
    end
end
DD %#ok<NOPTS>
fprintf('\nPolinomio grado %1.0f\n',double(t-1));
h=DD(1,1);
fprintf('H%1.0f(x)= A0 + ',double(t-1));
for i=2:t
    fprintf('A%1.0f',(i-1));
    for j=1:i-1
        fprintf('(x-x%1.0f)',double(j-1));
    end
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(x)= %8.8f + ',double(t-1),double(DD(1,1)));
for i=2:t
    factor=DD(i,i);
    fprintf('%8.8f*',double(DD(i,i)));
    for j=1:i-1
        fprintf('(x-(%3.3f))',double(dato(j)));
        factor=factor*(val-dato(j));
    end
    h=h+factor;
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(%3.3f)= %9.8f\n\n',double(t-1),double(val),double(h));