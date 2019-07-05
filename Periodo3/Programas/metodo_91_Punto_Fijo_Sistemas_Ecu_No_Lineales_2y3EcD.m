%Soluciones numericas de sistemas de Ecua no lineales 
%x^(k)=G(x^(k-1)), k>=1
%|x^(k)-x^(k-1)|<€
%Despejar x1,x2
%Ver evaluacion en cada formula
%Si el sistema solo es de 2 ecuaciones nada mas asignar cero en:
%Introduzca la función fx3: 0
%Introduzca el valor de x3: 0
clear all;
clc
fprintf('SOLUCION NUMERICA DE SISTEMAS NO LINEALES METODO DE PUNTO FIJO\n');
opc=input('Ingrese el número de ecuaciones dadas: ');
p=0;
w=0;
syms x1 x2
switch opc
    case 2
        fprintf('DOS ECUACIONES\n');
        fx1=input('Introduzca la función gx1: ');
        fx2=input('Introduzca la función gx2: ');

        x(1,1)=input('Introduzca el valor de x1: ');
        x(1,2)=input('Introduzca el valor de x2: ');

        k=0;
        errorPrecision=input('Precisión: 10^-');
        errorPrecision=10^(errorPrecision*-1);
        for i=1:2
            p(i)=x(1,i);
        end
        x(2,1)=subs(fx1,{x1,x2},{x(1,1),x(1,2)});
        x(2,2)=subs(fx2,{x1,x2},{x(1,1),x(1,2)});
        for i=1:2
            w(i)=x(2,i);
        end
        tol=norm(p-w,inf);
        fprintf('K  x1(k)        x2(k)           error\n')
        fprintf('\n%d  %9.15f  %9.15f  %9.15f\n',k,x(1,1),x(1,2));
        fprintf('%d  %9.15f  %9.15f  %e\n',k,x(2,1),x(2,2),tol);
        k=k+1;
        j=3;
        while tol>errorPrecision
            x(j,1)=subs(fx1,{x1,x2},{x(j-1,1),x(j-1,2)});
            x(j,2)=subs(fx2,{x1,x2},{x(j-1,1),x(j-1,2)});
            p=w;
            for i=1:2
                w(i)=x(j,i);
            end
            tol=norm(p-w,inf);
            fprintf('%d  %9.15f  %9.15f  %e\n',k,x(j,1),x(j,2),tol)
            k=k+1;
            j=j+1;
        end
    case 3
        fprintf('TRES ECUACIONES\n');
        syms x3
        fx1=input('Introduzca la función gx1: ');
        fx2=input('Introduzca la función gx2: ');
        fx3=input('Introduzca la función gx3: ');
        x(1,1)=input('Introduzca el valor de x1: ');
        x(1,2)=input('Introduzca el valor de x2: ');
        x(1,3)=input('Introduzca el valor de x3: ');
        k=0;
        errorPrecision=input('Precisión: 10^-');
        errorPrecision=10^(errorPrecision*-1);
        for i=1:3
            p(i)=x(1,i);
        end
        x(2,1)=subs(fx1,{x1,x2,x3},{x(1,1),x(1,2),x(1,3)});
        x(2,2)=subs(fx2,{x1,x2,x3},{x(1,1),x(1,2),x(1,3)});
        x(2,3)=subs(fx3,{x1,x2,x3},{x(1,1),x(1,2),x(1,3)});
        for i=1:3
            w(i)=x(2,i);
        end
        tol=norm(p-w,inf);
        fprintf('K   x1(k)               x2(k)               x3(k)                error\n')
        fprintf('%d  %9.15f  %9.15f  %9.15f\n',k,x(1,1),x(1,2),x(1,3));
        fprintf('%d  %9.15f  %9.15f  %9.15f  %e\n',k+1,x(2,1),x(2,2),x(2,3),tol);
        k=k+2;
        j=3;
        while tol>errorPrecision
            x(j,1)=subs(fx1,{x1,x2,x3},{x(j-1,1),x(j-1,2),x(j-1,3)});
            x(j,2)=subs(fx2,{x1,x2,x3},{x(j-1,1),x(j-1,2),x(j-1,3)});
            x(j,3)=subs(fx3,{x1,x2,x3},{x(j-1,1),x(j-1,2),x(j-1,3)});
            p=w;
            for i=1:3
                w(i)=x(j,i);
            end
            tol=norm(p-w,inf);
            fprintf('%d  %9.15f  %9.15f  %9.15f  %e\n',k,x(j,1),x(j,2),x(j,3),tol)
            k=k+1;
            j=j+1;
        end
end