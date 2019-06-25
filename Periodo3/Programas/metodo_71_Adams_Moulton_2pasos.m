%Metodo Mutipasos
%Metodo implicito de Adams-Moulton de 2 pasos
%wo=? w1=?1 
%wi+1=wi+h/12*[5*f(ti+1,wi+1)+8*f(ti,wi)-5*f(ti-1,wi-1)]; i=0,1,...,N-1
clear all
clc
syms t y 
ED=input('Introduzca la E.D.= ');
f=input('Introduzca la funcion de trabajo= ');
cond=input('Introduzca la condicion inicial "y(a)=k"=: ');
w0=input('Introduzca condición inicial w0= ');
a=input('Introduzca el intervalo inicial a= ');
b=input('Introduzca el intervalo final b= ');
h=input('Introduzca el tamaño de paso h= ');

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
for i=1:2
    v=double(subs(Ecua_dif,M(i+1,2)));
    M(i+1,3)=v;
    M(i+1,4)=v;
end
%Escribir la formula para cada iteracion
for i=2:n
    f1=double(subs(f,{t,y},{M(i+1,2),M(i+1,3)}));
    f2=double(subs(f,{t,y},{M(i,2),M(i,3)}));
    f3=double(subs(f,{t,y},{M(i-1,2),M(i-1,3)}));
    M(i+1,3)=M(i,3)+h/12*(5*f1+8*f2-f3);
    M(i+1,4)=double(subs(Ecua_dif,M(i+1,2)));
end
fprintf('              i             ti                 wi                 y(t)             Error');
for i=1:n
    M(i,5)=abs(M(i,4)-M(i,3));
end
M