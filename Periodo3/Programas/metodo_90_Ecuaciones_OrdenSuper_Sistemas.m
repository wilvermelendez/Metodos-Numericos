function w = metodo_90_Ecuaciones_OrdenSuper_Sistemas(funciones, intervalo, h, valores_iniciales)
%RUNGE_KUTTA_4_SISTEMAS Sol. de sist. de ec. diferenciales por Runge-Kutta4
%   w = Ecuaciones_OrdenSuper_Sistemas(funciones, intervalo, h, valores_iniciales)
%   resuelve el sistemas de ecuaciones diferenciales de orden superior por
%   medio del metodo de Runge-Kutta de orden 4 para sistemas.

%   Formato de entrada:
%   funciones: Debe ser un vector columna o fila conteniendo todas las
%   expresiones simbolicas de U1', U2', U3',... en funcion de U1, U2,
%   U3,... y de 't'.
%   intervalo: Un vector de la forma [a, b], definiendo el valor inicial y
%   final para el metodo.
%   h: tamaño de paso para los valores de t. El algoritmo hace tantas
%   iteraciones desde a hasta b segun el tamaño de paso.
%   valores_iniciales: Vector que contiene los valores iniciales para cada
%   expresion de U1(a), U2(a), U3(a),... Puede ser un vector fila o
%   columna.
%   ejemplo:
%       y''' + 2y'' - y' - 2y = t*e^t,    y(0) = 2, y'(0) = 1, y''(0) = -1
%       0 <= t <= 0.1,  h =0.05
%       Se considera:
%       U1 = y,     U2 = y',    U3 = y'',   U4 = y'''
%       U1' = U2,   U2' = U3,   U3' = U4 = y'''
%       Luego:
%       U3' = y''' = t*e^t + 2y + y' - 2y''
%       U3' = t*e^t + 2U1 + U2 - 2U3
%
%       Los comandos serian:
%       syms U1 U2 U3 t
%       dU1 = U2;
%       dU2 = U3;
%       dU3 = t*exp(t) + 2*U1 + U2 - 2*U3;

%       metodo_90_Ecuaciones_OrdenSuper_Sistemas([dU1, dU2, dU3], [a, b], h, [y, y', y''])
%       metodo_90_Ecuaciones_OrdenSuper_Sistemas([dU1, dU2, dU3], [0, 0.1], 0.05, [2, 1, -1])
%
%   NOTA: El programa trabaja unicamente con las variables simbolicas U1,
%   U2, U3,... y con t. Si se tiene un sistema que tiene variables 'x',
%   'y', 'z',... y 't', se deberan asignar correspondientemente las
%   variables dependientes a sus respectivas Un y pasar el sistema de esa
%   forma al programa.

%Se inicializan algunos valores:
m = length(funciones);  %Numero de ecuaciones
a = intervalo(1);       %Valor inicial
b = intervalo(2);       %Valor final
t = a:h:b;              %Conjunto de valores t

%Se inicializa arreglo de celdas con las cadenas que representan a U1, U2,
%U3, etc. De acuerdo al numero de ecuaciones disponibles. Estas cadenas
%facilitan la evaluacion por sustitucion de los 'm' valores.
for i = 1:m
    Us{i} = ['U' int2str(i)];
end
%Ahora se toman los valores iniciales para los primeros valores de w:
for i = 1:m
    w(i, 1) = valores_iniciales(i);
end
fprintf('--------------------------------------------------------------------------------\n');
%Luego se procede con el metodo:
for j = 1:length(t)-1
    %El bucle externo va iterando de acuerdo a los valores que va tomando
    %la variable independiente 't'.
    fprintf('t = %.8f\n\n', t(j+1));
    %Se calculan los K(1,i):
    for i=1:m
        %Toma una de las funciones:
        fi = funciones(i);
        %La evalua para t = tj
        fi = subs(fi, 't', t(j));
        for n = 1:m
            %Luego la evalua para cada valor de Un = w(n,j), segun el total
            %de ecuaciones que posea el sistema:
            fi = subs(fi, Us{n}, w(n, j));
        end
        %Por ultimo se encuentra el valor de K(1,i):
        K(1, i) = double(h*fi);
        fprintf('K1%d = h*f%d(t%d', i, i, j-1);
        fprintf(', y%d%d', [1:m; repmat(j-1, 1, m)]);
        fprintf(') = %.8f\n', double(K(1, i)));
    end
    %Se calculan los K(2,i):
    for i=1:m
        fi = funciones(i);
        fi = subs(fi, 't', t(j) + h/2);
        for n = 1:m
            fi = subs(fi, Us{n}, w(n, j) + 1/2*K(1, n));
        end
        K(2, i) = h*fi;
        fprintf('K2%d = h*f%d(t%d + h/2', i, i, j-1);
        fprintf(', y%d%d + 1/2*K%d%d', [1:m; repmat(j-1, 1, m); repmat(1, 1, m)
            ; 1:m]);
        fprintf(') = %.8f\n', K(2, i));
    end
    fprintf('\n');
    %Se calculan los K(3,i):
    for i=1:m
        fi = funciones(i);
        fi = subs(fi, 't', t(j) + h/2);
        for n = 1:m
            fi = subs(fi, Us{n}, w(n, j) + 1/2*K(2, n));
        end
        K(3, i) = h*fi;
        fprintf('K3%d = h*f%d(t%d + h/2', i, i, j-1);
        fprintf(', Y%d%d + 1/2*K%d%d', [1:m; repmat(j-1, 1, m); repmat(2, 1, m); 1:m]);
        fprintf(') = %.8f\n', K(3, i));
    end
    fprintf('\n');
    %Se calculan los K(4,i):
    for i=1:m
        fi = funciones(i);
        fi = subs(fi, 't', t(j) + h);
        for n = 1:m
            fi = subs(fi, Us{n}, w(n, j) + K(3, n));
        end
        K(4, i) = h*fi;
        fprintf('K4%d = h*f%d(t%d + h', i, i, j-1);
        fprintf(', Y%d%d + K%d%d', [1:m; repmat(j-1, 1, m); repmat(3, 1, m); 1:m]);
        fprintf(') = %.8f\n', K(4, i));
    end
    fprintf('\n');
    
    %Finalmente para cada iteracion se calculan los nuevos valores de
    %aproximacion w:
    for i = 1:m
        w(i, j+1) = w(i, j) + 1/6*(K(1, i) + 2*K(2, i) + 2*K(3, i) + K(4, i));
        fprintf('Y%d%d = Y%d%d + 1/6*(K1%d + 2*K2%d + 2*K3%d + K4%d) = %.8f\n', i, j, i, j-1, i, i, i, i, w(i, j+1));
    end
    
    fprintf('--------------------------------------------------------------------------------\n');
end
t'
K

%Deja solamente los ultimos resultados y los retorna:
w = w(:, end);