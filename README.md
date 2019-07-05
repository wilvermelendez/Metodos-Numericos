Métodos numéricos /Análisis numérico
==================
Este es un repositorio pensado para almacenar todos los programas ordenados por unidad y tema de la materia métodos númericos., utilizando matlab en su versión 2015 b

Estos programas fuerón utilizados exitosamente para cursar la materia de Métodos numéericos de la Universidad Don Bosco de El Salvador

Nota: Algunos de estos programas fuerón creados por otros estudiantes, pero yo los modifiqué acorde a mi necesidades y requerimientos del docente por lo que agregué varios procesos para mejoralos.

## Lista de programas ##
*   Periodo 1
    * Método de bisección
    * Método de punto fijo
    * Método de Newton
    * Método de la Secante
    * Método de posición falsa
    * Método de Steffensen
    * Método de Muller
    * Método de Horner
    * Método de Lagrange
    * Método de Neville
    * Método de diferencias divididas
    * Método de Hermite Lagrange
    * Método de Hermite diferencias divididas
    * Método de trazadores cúbicos
*   Periodo 2 [Para el este periodo todos los procesos son manuales por lo que no hay programas]
    * Método de Richardson
    * Método de Romberg
*   Periodo 3
    * Método de Euleer
    * Método de Taylor de orden superior
    * Método de Runge Kutta punto medio
    * Método de Runge Kutta Heun
    * Método de Runge Kutta orden 4
    * Método de Runge Kutta Felbergh orden 4
    * Método de Runge Kutta Felbergh orden 5
    * Método de Runge Kutta Adam Bashforth 2 pasos
    * Método de Runge Kutta Adam Bashforth 3 pasos
    * Método de Runge Kutta Adam Bashforth 4 pasos
    * Método de Runge Kutta Adam Bashforth 5 pasos
    * Método de Runge Kutta Adam Moulton 2 pasos
    * Método de Runge Kutta Adam Moulton 3 pasos
    * Método de Runge Kutta Adam Moulton 5 pasos
    * Método de Extrapolación
    * Método de Runge Kutta orden 4 para sistemas de ecuación y orden superior
    * Método de punto fijo para sistemas de 2 y3 ecuaciones no lineales
    * Método de Newton para sistemas de 2 y3 ecuaciones no lineales
    * Método de Broyden para sistemas de 2 y3 ecuaciones no lineales

      
## Instrucciones de uso de algunos programas ##


### Método de Runge Kutta orden 4 para sistemas de ecuación y orden superior ###

Teniendo las ecuaciones desjadas en Dx y Dx de la siguiente forma

`>> Dx=(378*exp(-t) - 554*exp(-2*t) - 88*cos(t) + 101*sin(t)-101*x)/(-88);`

`>> Dy=(567*exp(-t) - 554*exp(-2*t)+101*y)/(88);`

Exacta utilizando el comando dsolve

#### Exacta ####
`>> syms t y x`

`>> T=[0:1/200:1/40];`

`>> [X Y]=dsolve('Dx=(378*exp(-t) - 554*exp(-2*t) - 88*cos(t) + 101*sin(t)-101*x)/(-88)','Dy=(567*exp(-t) - 554*exp(-2*t)+101*y)/(88)','x(0)=0','y(0)=-1');`

`>> format long`

`>> exacta=[double(subs(X,T))' double(subs(Y,T))']`

`exacta =`

 `                  0  -1.000000000000000`
                   
 `  0.014925270053721  -1.004937770079711`
   
 `  0.029702154218992  -1.009752154633994`
   
 `  0.044332249615437  -1.014444751712172`
   
 `  0.058817135002197  -1.019017141615620`
   
 `  0.073158370969950  -1.023470887083570`
   
#### Aproximada ####
Aproximada utilizando el programa de matlab

`>> syms U1 U2 t`

`>> dU1=(378*exp(-t) - 554*exp(-2*t) - 88*cos(t) + 101*sin(t)-101*U1)/(-88);`

`>> dU2=(567*exp(-t) - 554*exp(-2*t)+101*U2)/(88);`

`>> metodo_90_Ecuaciones_OrdenSuper_Sistemas([dU1, dU2],[0 1/40], 1/200,[0 -1])`

Resultados de las últimas Y o W acorde al tipo de variable utilizada en la fórmula.

`ans =`

   `0.073158370973584`
   
  `-1.023470887086914`

