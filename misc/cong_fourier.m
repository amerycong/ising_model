function cong_fourier(n)

close all
n = round(n);
step = 1/100;
x = -5:step:5-step;

func = [-1-[-1:step:-step] 1-[0:step:1-step]];
func = repmat(func,1,5);

sin_series = zeros(1,length(x));
a0 = 1/2;
cos_series = zeros(1,length(x));
for i = 1:n
    for j = 1:length(x)
        sin_series(j) = sin_series(j) + 2/(pi*i)*sin(pi*i*x(j));
        cos_series(j) = cos_series(j) + (2*(1-(-1)^i))/(pi^2*i^2)*cos(pi*i*x(j));
    end
end
cos_series = a0 + cos_series;
figure(1)
hold all
plot(x,sin_series)
plot(x,func)
ylim([-1.5 1.5])
hold off
title(['Sine Series: ',num2str(n),'th partial sum'])
legend('Partial Sum','f(x)')

figure(2)
hold on
plot(x,cos_series)
plot(x,func)
ylim([-1.5 1.5])
title(['Cosine Series: ',num2str(n),'th partial sum'])
legend('Partial Sum','f(x)')

end

