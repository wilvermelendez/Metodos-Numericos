disp('MÉTODO DE LAS DIFERENCIAS DIVIDIDAS')
val=input('Valor a interpolar x: ');
dato=M(1:end,2);
p=M(1:end,3);
t=length(dato);
DD=zeros(t);
disp('Obteniendo las diferencias divididas:');
DD(:,1)=p';
for j=2:t
    fprintf('Columna %2.0f de diferencias divididas\n',j);
    for i=j:t
        DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(dato(i)-dato(i-j+1));
        fprintf('(%8.15f-(%8.15f))/(%3.3f-(%3.3f)) = %8.09f\n',double(DD(i,j-1)),double(DD(i-1,j-1)),double(dato(i)),double(dato(i-j+1)),double(DD(i,j)));
    end
end
DD
fprintf('\nPolinomio grado %1.0f\n',t-1);
pol=DD(1,1);
fprintf('P%1.0f(x)= A0 + ',t-1);
for i=2:t
    fprintf('A%1.0f',i-1);
    for j=1:i-1
        fprintf('(x-x%1.0f)',j-1);
    end
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('P%1.0f(x)= %8.09f + ',t-1,DD(1,1));
for i=2:t
    factor=DD(i,i);
    fprintf('(%8.09f)*',DD(i,i));
    for j=1:i-1
        fprintf('(x-(%3.3f))',dato(j));
        factor=factor*(val-dato(j));
    end
    pol=pol+factor;
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('P%1.0f(%3.3f)= %9.15f\n\n',double(t-1),double(val),double(pol));