%Metodo de extrapolacion
%hi=h/qi ;  qo=2,q1=4,q2=6,q3=8,q4=12,q5=16,q6=24,q7=32
%w1=wo+hi*f(a,wo)
%w2=wo+2*hi*f(a+hi,w1)
%w3=w1+2*hi*f(a+2*hi,w2)
%w4=w2+2*hi*f(a+3*hi,w3)
%w5=w3+2*hi*f(a+4*hi,w4)
%w6=w4+2*hi*f(a+5*hi,w5)
%w7=w5+2*hi*f(a+6*hi,w6)
%w8=w6+2*hi*f(a+7*hi,w7)
%y11=1/2[w2+w1+hof(a+2ho,w2)]
%y21=1/2[w4+w3+h1f(a+4h1,w4)];  y22=y21+1/3(y21-y11)
%y31=1/2[w6+w5+h2f(a+6h2,w6)];  y32=y31+4/5(y31-y21);  y33=y32+1/8(y32-y22)
%y41=1/2[w8+w7+h3f(a+8h3,w8)];  y42=y41+9/7(y41-y31);  y43=y42+1/3(y42-y32)  y44=y43+1/15(y43-y33) 
% - Introduzca la ecuación diferencial        : 'Dy=y-(t^2)+1'
% - Introduzca la condición y(a)=b            : 'y(0)=0.5'
% - Introduzca la función de trabajo          : y-(t^2)+1
% - Introduzca la condición inicial           : 0.5
% - Introduzca el valor de a                  : 0
% - Introduzca el valor de b                  : 1
% - Introduzca el tamaño de paso h            : 0.1
% - Introduzca el porcentaje de error         : 1e-4
clear all
clc
fprintf('MÉTODO DE EXTRAPOLACION\n')
syms t y 
ED=input('Introduzca la E.D.= ');
f=input('Introduzca la funcion de trabajo= ');
cond=input('Introduzca la condicion inicial "y(a)=k"=: ');
w0=input('Introduzca condición inicial w0= ');
a=input('Introduzca el intervalo inicial a= ');
b=input('Introduzca el intervalo final b= ');
h=input('Introduzca el tamaño de paso h= ');
error=input('Introduzca el porcentaje de error : ');

qi=[2 4 6 8 12 16 24 32]; yi=0; hi=0;
wi(1)=w0;
Y(1,1)=w0;
ti=a:h:b;
Ecua_dif=dsolve(ED,cond,'t');
pretty(Ecua_dif)
hi(1)=h/qi(1);
t1=a+h;
i=1;
j=1;
while t1<=b
    fprintf('\nPara t%d=%3.2f  ho=%7.6f\n',i,t1,hi(1))
    yi=0;
    wi(j+1)=wi(j)+hi(j)*subs(f,{t,y},{a,wi(j)});
    wi(j+2)=wi(j)+2*hi(j)*subs(f,{t,y},{a+hi(j),wi(j+1)});
    Y(j+1)=subs(Ecua_dif,ti(i+1));
    yi(1,1)=1/2*(wi(j+2)+wi(j+1)+hi(j)*subs(f,{t,y},{a+2*hi(j),wi(j+2)}));
    Exacto=Y(j+1);
    tol=abs(yi(1,1)-Y(j+1));
    fprintf('\nw1=wo+hof(a,wo)=%10.9f',wi(2))
    fprintf('\nw2=wo+2hof(a+ho,w1)=%10.9f',wi(3))
    fprintf('\ny11=1/2[w2+w1+hof(a+2ho,w2)]=%10.9f',yi(1,1))
    fprintf('\nY(%7.6f)=%10.9f',t1,Exacto)
    fprintf('\n|Y(%7.6f)-y11|=%e\n',t1,tol)
    k=2; n=1;
    while tol>error
        hi(n+1)=(t1-a)/qi(k);
        wi(j+1)=wi(j)+hi(n+1)*subs(f,{t,y},{a,wi(j)}); l=j+1;
        for m=1:qi(k)-1
            wi(l+1)=wi(l-1)+2*hi(n+1)*subs(f,{t,y},{a+(l-1)*hi(n+1),wi(l)});
            l=l+1;
        end
        if qi(k)==4
            yi(2,1)=1/2*(wi(5)+wi(4)+hi(2)*subs(f,{t,y},{a+4*hi(n+1),wi(5)}));
            yi(2,2)=yi(2,1)+(yi(2,1)-yi(1,1))/3;
            tol=abs(yi(2,2)-Exacto);
            fprintf('\nCalculando y22')
            fprintf('ho=%7.6f\n',hi(n+1))
            fprintf('\nw1=wo+h1*f(a,wo)=%10.9f',wi(2))
            fprintf('\nw2=wo+2*h1*f(a+h1,w1)=%10.9f',wi(3))
            fprintf('\nw3=w1+2*h1*f(a+2h1,w2)=%10.9f',wi(4))
            fprintf('\nw4=w2+2*h1*f(a+3h1,w3)=%10.9f',wi(5))
            fprintf('\ny21=1/2[w4+w3+h1f(a+4h1,w4)]=%10.9f',yi(2,1))
            fprintf('\ny22=y21+1/3(y21-y11)=%10.9f',yi(2,2))
            fprintf('\n|Y(%7.6f)-y22|=%e\n',t1,tol)
        end
        if qi(k)==6
            yi(3,1)=1/2*(wi(7)+wi(6)+hi(n+1)*subs(f,{t,y},{a+6*hi(n+1),wi(7)}));
            yi(3,2)=yi(3,1)+4/5*(yi(3,1)-yi(2,1));
            yi(3,3)=yi(3,2)+(yi(3,2)-yi(2,2))/8;
            tol=abs(yi(3,3)-Exacto);
            fprintf('\nCalculando y33')
            fprintf('ho=%7.6f\n',hi(n+1))
            fprintf('\nw1=wo+h2f(a,wo)=%10.9f',wi(2))
            fprintf('\nw2=wo+2*h2*f(a+h2,w1)=%10.9f',wi(3))
            fprintf('\nw3=w1+2*h2*f(a+2h2,w2)=%10.9f',wi(4))
            fprintf('\nw4=w2+2*h2*f(a+3h2,w3)=%10.9f',wi(5))
            fprintf('\nw5=w3+2*h2*f(a+4h2,w4)=%10.9f',wi(6))
            fprintf('\nw6=w4+2*h2*f(a+5h2,w5)=%10.9f',wi(7))
            fprintf('\ny31=1/2[w6+w5+h2f(a+6h2,w6)]=%10.9f',yi(3,1))
            fprintf('\ny32=y31+4/5(y31-y21)=%10.9f',yi(3,2))
            fprintf('\ny33=y32+1/8(y32-y22)=%10.9f',yi(3,3))
            fprintf('\n|Y(%7.6f)-y33|=%e\n',t1,tol)
        end
        if qi(k)==8
            yi(4,1)=1/2*(wi(9)+wi(8)+hi(n+1)*subs(f,{t,y},{a+8*hi(n+1),wi(9)}));
            yi(4,2)=yi(4,1)+9/7*(yi(4,1)-yi(3,1));
            yi(4,3)=yi(4,2)+1/3*(yi(4,2)-yi(3,2));
            yi(4,4)=yi(4,3)+1/15*(yi(4,3)-yi(3,3));
            tol=abs(yi(4,4)-Exacto);
            fprintf('\nCalculando y44')
            fprintf('ho=%7.6f\n',hi(n+1))
            fprintf('\nw1=wo+h3f(a,wo)=%10.9f',wi(2))
            fprintf('\nw2=wo+2*h3*f(a+h3,w1)=%10.9f',wi(3))
            fprintf('\nw3=w1+2*h3*f(a+2h3,w2)=%10.9f',wi(4))
            fprintf('\nw4=w2+2*h3*f(a+3h3,w3)=%10.9f',wi(5))
            fprintf('\nw5=w3+2*h3*f(a+4h3,w4)=%10.9f',wi(6))
            fprintf('\nw6=w4+2*h3*f(a+5h3,w5)=%10.9f',wi(7))
            fprintf('\nw7=w5+2*h3*f(a+6h3,w6)=%10.9f',wi(8))
            fprintf('\nw8=w6+2*h3*f(a+7h3,w7)=%10.9f',wi(9))
            fprintf('\ny41=1/2[w8+w7+h3f(a+8h3,w8)]=%10.9f',yi(4,1))
            fprintf('\ny42=y41+9/7(y41-y31)=%10.9f',yi(4,2))
            fprintf('\ny43=y42+1/3(y42-y32)=%10.9f',yi(4,3))
            fprintf('\ny44=y43+1/15(y43-y33)=%10.9f',yi(4,4))
            fprintf('\n|Y(%7.6f)-y33|=%e\n',t1,tol)
        end
        n=n+1;
        k=k+1;
    end        
    t1=t1+h;
    j=1;
    hi(j)=(t1-a)/qi(j);
    i=i+1;
end