function value = cong_bessel(n,x)

m=10*n;
a=0;
b=0;
recur=[];
for i = m-1:-1:1
    a = x/(2*i-x*a);
    recur = [a recur];
    if mod(i,2)==0
        b=a*(b+2);
    else
        b=a*b;
    end
end
recur = [1/(1+b) recur];

for i = 2:length(recur)
    recur(i) = recur(i)*recur(i-1);
end

value = recur(n+1);
end