disp('INTERPOLACION DE HERMITE POR DIFERENCIAS DIVIDIDAS')
fprintf('----------------------------------------------------------\n');
val=input('Valor a interpolar x: ');
vars=M(1:end,2);
t=2*length(vars);
dato=zeros(1,t);
for i=1:t/2
    dato(2*i-1)=vars(i);
    dato(2*i)=vars(i);
end
fun=M(1:end,3);

f=input('Función f(x) prima: ');
fundif=zeros(1,t/2);
for i=1:t/2
    fundif(i)=subs(f,vars(i));
end

DD=zeros(t);
fprintf('\nObteniendo las diferencias divididas:');
for i=1:t/2 
    DD(2*i-1,1)=fun(i);
    DD(2*i,1)=fun(i);
end
for j=2:t
    for i=j:t
        if dato(i)~=dato(i-j+1)
            DD(i,j)=(DD(i,j-1)-DD(i-1,j-1))/(dato(i)-dato(i-j+1));    
        else
            DD(i,j)=fundif(i/2);
        end
    end
end
DD %#ok<NOPTS>
fprintf('\nPolinomio grado %1.0f\n',double(t-1));
h=DD(1,1);
fprintf('H%1.0f(x)= A0 + ',double(t-1));
for i=2:t
    fprintf('A%1.0f',(i-1));
    for j=1:i-1
        fprintf('(x-x%1.0f)',double(j-1));
    end
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(x)= %8.8f + ',double(t-1),double(DD(1,1)));
for i=2:t
    factor=DD(i,i);
    fprintf('%8.8f*',double(DD(i,i)));
    for j=1:i-1
        fprintf('(x-(%3.3f))',double(dato(j)));
        factor=factor*(val-dato(j));
    end
    h=h+factor;
    if i==t
        fprintf('\n');
    else
        fprintf(' + ');
    end
end
fprintf('H%1.0f(%3.3f)= %9.8f\n\n',double(t-1),double(val),double(h));
