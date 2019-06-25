disp('M�TODO DE NEVILLE')
val=input('Valor a interpolar x: ');
dato=M(1:end,2);
p=M(1:end,3);
t=length(dato);
Q=zeros(t);
for i=1:t
    Q(i,1)=p(i);
    fprintf('\nQ%1.0f0 = %9.15f',double(i-1),double(p(i)));
end
for i=2:t
    for j=2:i
        Q(i,j)=(((val-dato(i-j+1))*Q(i,j-1))-((val-dato(i))*Q(i-1,j-1)))/(dato(i)-dato(i-j+1));
        fprintf('\n\t   (X-X%1.0f)Q%1.0f%1.0f -(X-X%1.0f)Q%1.0f%1.0f     (x-(%3.2f))*(%3.15f) - (x-(%3.2f))*(%3.15f) ',double(i-j),double(i-1),double(j-2),double(i-1),double(i-2),double(j-2),double(dato(i-j+1)),double(Q(i,j-1)),double(dato(i)),double(Q(i-1,j-1)))
        fprintf('\nQ(%1.0f,%1.0f)= --------------------  =  --------------------------------------------------------------- = %9.15f', double(i-1),double(j-1),double(Q(i,j)));
        fprintf('\n\t\t\t  (X%1.0f-X%1.0f)\t\t\t\t\t\t\t\t     (%3.3f)-(%3.3f)\n',double(i-1),double(i-j),double(dato(i)),double(dato(i-j+1)));
    end
end
Q
fprintf('\n\nValor Aproximado: %9.15f\n',double(Q(t,t)));
fprintf('\nError: %e\n\n',double(abs(Q(t-1,t-1)-Q(t,t))));