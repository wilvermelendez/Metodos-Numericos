clc
disp('Metodo de Müller')
syms x;
disp('Recuerde que la funcion debe de ser un polinomio')
Fx=input('Función f(x): ');
x0=input('Ingrese x0: ');
x1=input('Ingrese x1: ');
x2=input('Ingrese x2: ');
errorPrecision=input('Ingrese el margen de error 10^-');
if errorPrecision>0
    errorPrecision=-errorPrecision;
end
errorPrecision=10^errorPrecision;
%Primero debemos evaluar la funcion en los puntos iniciales
Fx0=subs(Fx,x0);
Fx1=subs(Fx,x1);
Fx2=subs(Fx,x2);
%Luego debemos inicializar las constantes A, B y C
a=((x1-x2)*(Fx0-Fx2)-(x0-x2)*(Fx1-Fx2))/((x0-x2)*(x1-x2)*(x0-x1));
b=((x0-x2)^2*(Fx1-Fx2)-(x1-x2)^2*(Fx0-Fx2))/((x0-x2)*(x1-x2)*(x0-x1));
c=Fx2;
%Al tener todos los datos obtenemos el valor de apox
%Es de resaltar que se utiliza la funcion signo.
x3=(x2-(2*c)/(b+sign(b)*sqrt(b^2-4*a*c)));
%Luego calculamos el error
error=abs(x3-x2);
n=1;
fprintf('n\t|x0 \t\t\t\t|x1 \t\t\t\t|x2 \t\t\t\t|x3 \t\t\t\t|a \t\t\t\t\t\t|b \t\t\t\t\t\t|c \t\t\t\t\t\t|error')
fprintf('\n%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.9e',double(n),double(x0),double(x1),double(x2),double(x3),double(a),double(b),double(c),double(error));
while error>errorPrecision
    %Acarreo de valores inciales
    x0=vpa(x1);
    x1=vpa(x2);
    x2=vpa(x3);
    %se hace el calculo otra vez
    Fx0=subs(Fx,x0);
    Fx1=subs(Fx,x1);
    Fx2=subs(Fx,x2);
    a=((x1-x2)*(Fx0-Fx2)-(x0-x2)*(Fx1-Fx2))/((x0-x2)*(x1-x2)*(x0-x1));
    b=((x0-x2)^2*(Fx1-Fx2)-(x1-x2)^2*(Fx0-Fx2))/((x0-x2)*(x1-x2)*(x0-x1));
    c=Fx2;
    x3=(x2-(2*c)/(b+sign(b)*sqrt(b^2-4*a*c)));
    error=abs(x3-x2);
    n=n+1;
    fprintf('\n%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.9e',double(n),double(x0),double(x1),double(x2),double(x3),double(a),double(b),double(c),double(error))
end
fprintf('\nEl valor aproximado de X es: %.15f\n', double(x3))












