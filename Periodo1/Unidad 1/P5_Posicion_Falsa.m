clear all
clc
format long
syms x
disp('Metodo de la Posicion falsa')
Fx = input('Función f(x): ');
p0 = input('Introduzca el valor inicial P0: ');
p1 = input('Introduzca el valor inicial P1: ');
errorPrecision=input('Precisión: 10^-');
errorPrecision=10^(errorPrecision*-1);
Fp0 = subs(Fx,p0);
Fp1 = subs(Fx,p1);

if(Fp1*Fp0<0)
    n = 1;
    p2 = p1 - Fp1*(p1-p0)/(Fp1 - Fp0);
    error = abs(p2 - p1);
    fprintf('n     \t\t     p0    \t\t      p1    \t\t      p2     \t\t     error \n')
    fprintf('%3.0f \t %9.15f \t %9.15f \t %9.15f \t %e\n',double(n),double(p0),double(p1),double(p2),double(error))
    while(error>errorPrecision)
        n = n+1;
        Fp2 = subs(Fx,p2);
        if(Fp1*Fp2 < 0)
            p0 = vpa(p1);
            p1 = vpa(p2);
        elseif(Fp0*Fp2 < 0)
            p1 = vpa(p2);
        else
            print('\nError Fp1*Fp2 > 0 y Fp0*Fp2 > 0')
        end
        Fp0 = subs(Fx,p0);
        Fp1 = subs(Fx,p1);
        p2 = p1 - Fp1*(p1-p0)/(Fp1 - Fp0);
        error = abs(p2 - p1);
        Fp2 = subs(Fx,p2);
        fprintf('%3.0f \t %2.15f \t %2.15f \t %2.15f \t %e\n',double(n),double(p0),double(p1),double(p2),double(error))
    end
    fprintf('El valor aproximado de x es: %2.15f\n', double(p2))
else
    fprintf('\n\t\tFuncion Incorrecta o P0 y P1 son de signo igual. \n')
    
    
    
    %x es: 32.905981806689198
    %F(x): (sqrt((50)^2+(100+x)^2))-142
   % x+100 distan
   %por pitagoras 

end