%Interpolacion mediante Trazadores Cubicos
%El polinomio de trazadores cubicos tendra la siguiente forma:
%Sj(x)=Aj+bj(x-xj)+Cj(x-xj)^2+dj(x-xj)^3
%Aj=f(xj)
%    (Cj+1 - Cj)       (Aj+1 - Aj)    hj(2Cj + Cj+1)
%dj= -----------   bj= ----------- - ---------------
%        3hj                hj             3
%hj-1*Cj-1 + 2(hj-1 +hj)Cj + hjCj+1 = 3(Aj+1 - Aj)/hj - 3(Aj - Aj-1)/hj-1
%                                     


clear all
clc
syms x
fprintf('                            ----------------------------------\n')
fprintf('                                    TRAZADORES CUBICOS (x)\n')
fprintf('                            ----------------------------------\n')
fprintf('\n');

res=input('La ecuacion le fue dada (si=1/no=0) :');
 if res==1
   r=input('- Introduzca la Funcion F(x)             : ');
end
X=input('- Introduzca los valores de x [x0 x1...]: ');
n=length(X);

if res==1
    for i=0:n-1
    Y(i+1)=subs(r,X(i+1));
    end
else
Y=input('- Introduzca los valores de y [y1 y2 ...] : ');
end
z=input('- Introduzca el valor a aproximar   : ');

for i=0:n-1
   A(i+1)=Y(i+1);
   
end

for i=0:n-2
   H(i+1)=X(i+2)-X(i+1);
end
fprintf('\n');
fprintf('\n');

fprintf (' Los valores H: \n');
for i=0:n-2
   fprintf (' H(%1.0f) = %2.3f',double(i),double(H(i+1)));
   fprintf ('\n');
end
fprintf('\n');

fprintf(' El valor de n es: %1.0f\n',double(n-1));

fprintf('\n');


for i=1:n-2
   b(i)=2*(H(i)+H(i+1));
   end
   
   for i=1:n-2
      d(i)=3*(A(i+2)-A(i+1))/H(i+1)-3*(A(i+1)-A(i))/H(i);
   end
   
   
   fprintf ('Las ecuaciones son: \n');
   for i=1:n-2
      fprintf('%9.15f *C(%1.0f) +(%9.15f)*C(%1.0f) + (%9.15f)*C(%1.0f) = %9.15f\n',double(H(i)),double(i-1),double(b(i)),double(i),double(H(i+1)),double(i+1),double(d(i)));
   end
   
   D=zeros(n,n);
   B=zeros(1,n);
   
   for i=2:n-1
      B(i)=b(i-1);
   end
   D=diag(B);
   
   V=zeros(1,n-1);
   for i=1:n-2
      V(i)=H(i);
   end
   for i=1:n-1
      D(i+1,i)=V(i);
   end
   S=zeros(1,n-1);
   for i=2:n-1
      S(i)=H(i);
   end
   for i=1:n-1
      D(i,i+1)=S(i);
   end
   D(1,1)=1;
   D(n,n)=1;
   
   T=zeros(1,n);
   for i=2:n-1
      T(i)=d(i-1);
   end
   
   R=T';
   C=D\R;
   
   fprintf('\n');
   
   fprintf('Los valores de las constantes de C son:\n');
   for i=1:n
   fprintf('C(%1.0f) = %3.9f\n',double(i-1),double(C(i)));
   end
   fprintf('\n');
   cont=0;
   for i=1:n
   if z > X(i)
      cont=cont+1;
   end
   end
   
   o=(C(cont+1)-C(cont))/(3*H(cont));
   
   fprintf('El valor de la constante d(%1.0f) es : %9.15f\n',double(cont-1),double(o));
   fprintf('\n');
   
   f=(A(cont+1)-A(cont))/(H(cont))-((H(cont)*(2*C(cont)+C(cont+1)))/3);
   
   fprintf('El valor de la constante b(%1.0f) es : %9.15f\n',double(cont-1),double(f));
   fprintf('\n');

M=A(cont)+f*(z-X(cont))+C(cont)*(z-X(cont))^2+o*(z-X(cont))^3;

fprintf('El polinomio es: S(x) %9.15f + (%9.15f)*(x- %9.15f)+ (%9.15f)*(x- %9.15f)^2 + (%9.15f)*(x- %9.15f)^3\n',double(A(cont)),double(f),double(X(cont)),double(C(cont)),double(X(cont)),double(o),double(X(cont)));

fprintf('El resultado final es : %9.15f',double(M));
      
fprintf('\n');


     
%para armar la ecuacion, se pone S(el intervalo donde se encuentra el valor aprox), acordate por ejemplo S(4) para 
%intervalo 4
%S4(x)=A4+b4(x-x4)+C4(x-x4)^2+d4(x-x4)^3

   

