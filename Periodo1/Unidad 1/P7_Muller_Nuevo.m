%Metodo de Muller es exclusivo solo para polinomios. En este metodo se
%utilizan tres valores iniciales. F0=f(P1), F1=f(P2) y F2=f(P3). Entonces
%para encontrar a,b y c.
%a=((P2-P3)*(F0-F2)-(P1-P3)*(F1-F2))/((P1-P3)*(P2-P3)*(P1-P2)). error=Q-P3.
%si no se cumple entonces: P1=P2, P1=P2, P3=Q. 

    warning('off','MATLAB:dispatcher:InexactCaseMatch')
    clc
    clear all
    disp('Método de Muller')
    disp('METODO EXCLUSIVO SOLAMENTE PARA POLINOMIOS.');
    error=input('Introduzca el error: ');
    syms x
    f=input('Introduzca la función de la forma f(x)=ax^n + bx^n-1...: ');
    P=input('Introduzca los valores iniciales en forma de vector [x0 x1 x2]: ');
    cont=0;
    n=1;
    disp(' n            X0            X1            X2            Q            a            b            c            error   ');
    while cont==0
    F0=subs(f,P(1));
    F1=subs(f,P(2));
    F2=subs(f,P(3));
    
    a=((P(2)-P(3))*(F0-F2)-(P(1)-P(3))*(F1-F2))/((P(1)-P(3))*(P(2)-P(3))*(P(1)-P(2)));
    b=((P(1)-P(3))^2*(F1-F2)-(P(2)-P(3))^2*(F0-F2))/((P(1)-P(3))*(P(2)-P(3))*(P(1)-P(2)));
    c=F2;
    
    Q=P(3)-(2*c/(b+sign(b)*((b^2-4*a*c)^(1/2))));
    E=abs(Q-P(3));
   
    fprintf('%2.0f  %9.9f  %9.9f  %9.9f  %9.9f  %9.9f  %9.9f  %9.9f   %e\n',double(n),double(P(1)),double(P(2)),double(P(3)),double(Q),double(a),double(b),double(c),double(E))
    if E<error
        cont= cont+1;
    else
        P(1)=P(2);
        P(2)=P(3);
        P(3)=Q;
    end
    n=n+1;
    end
    fprintf('El valor aproximado es: %9.12f\n',double(Q))