clear all;
clc;
syms y;
fx=42*(5-y)*2*sqrt(25-(y-5)^2);
n=5;
a=0;
b=5;
R=zeros(n,n);
fa=subs(fx,a);
fb=subs(fx,b);
for j=1:n
    h(j)=(b-a)/(2^(j-1));
end
h
R(1,1)=(h(1)/2)*(fa+fb);
for j=2:n
    Sum=0;
    for i=1:(2^(j-2))
        c=(a+((2*i-1)*h(j)));
        fc=subs(fx,c);
        Sum=Sum+fc;
    end
    R(j,1)=(1/2)*(R(j-1,1)+h(j-1)*Sum);
end
for j=2:n
    for i=j:n
        R(i,j)=R(i,j-1) + (R(i,j-1)-R(i-1,j-1))/((4^(j-1))-1);
    end
end

R