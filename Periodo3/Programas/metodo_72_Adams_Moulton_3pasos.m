%Metodo Mutipasos
%Metodo implicito de Adams-Moulton de 3 pasos
%wo=? w1=?1 w2=?2 
%wi+1=wi+h/24*[9*f(ti+1,wi+1)+19*f(ti,wi)-5*f(ti-1,wi-1)+f(ti-2,wi-2)]; i=0,1,...,N-1
clear all
clc
syms t y 
disp('Método Implicito de Adams-Moulton de Tres Pasos');
ED=input('Introducir la ecuación diferencial de la forma "Dy=f(t,y)": ');
f=input('Introduzca la funcion de trabajo= ');
cond=input('Introduzca la condicion inicial "y(a)=k"=: ');
w0=input('Introducir la condición inicial w0: ');
a=input('Introducir intervalo a: ');
b=input('Introducir intervalo b: ');
h=input('Introducir tamaño de paso h: ');

ti=a:h:b;
lti=length(ti);
M(1:lti,1)=1:1:lti;
M(1:lti,2)=ti;
M(1,3)=w0;
M(1,4)=w0;
n=(b-a)/h;
Ecua_dif=dsolve(ED,cond,'t');
fprintf('La solución de la ecuación diferencial es :');
pretty(Ecua_dif)
for j=1:3
    v=double(subs(Ecua_dif,M(j+1,2)));
    M(j+1,3)=v;
    M(j+1,4)=v;
end
%Escribir la formula para cada iteracion
for j=3:n
    f1=subs(f,{t,y},{M(j+1,2),M(j+1,3)});
    f2=subs(f,{t,y},{M(j,2),M(j,3)});
    f3=subs(f,{t,y},{M(j-1,2),M(j-1,3)});
    f4=subs(f,{t,y},{M(j-2,2),M(j-2,3)});
    M(j+1,3)=M(j,3)+h/24*(9*f1+19*f2-5*f3+f4);
    M(j+1,4)=subs(Ecua_dif,M(j+1,2));
end
fprintf('              i             ti                 wi                 y(t)             Error');
for i=1:n
    M(i,5)=abs(M(i,4)-M(i,3));
end
M