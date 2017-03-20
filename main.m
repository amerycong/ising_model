%2d ising model
clear all

%T = 2; % part a single temp run
T = [1.0:0.1:5.0];

m = 100;
N = m^2;
num_sweeps = 500; %num MC sweeps

%mu, B = 0
k = 1;
J = 1;
t = k.*T/J;


for i = 1:length(t)
    fprintf('t = %f\n',t(i));
    %generate random spins
    q = 2*((rand(m,m) > 0.5) - 0.5);

    [q,single_U,single_L] = ising(m,t(i),J,num_sweeps,q);
    
    %uncomment to plot at every step
%     figure(4)
%     plot(1:num_sweeps,single_L)
%     xlabel('Monte Carlo Sweep Number')
%     ylabel('Order Parameter (L(T))')
%     title('Order Parameter')
%     figure(5)
%     plot(1:num_sweeps,single_U)
%     xlabel('Monte Carlo Sweep Number')
%     ylabel('Energy (U(T)/NJ)')
%     title('Energy of System')
    
    %energy
    U(i) = find_energy(q,J);
    np = sum(sum((q>0)));
    nd = sum(sum((q<0)));
    %order
    L(i) = abs(np - nd) / (np + nd);
end
U=U/2;

t_anal =k.*[1.0:0.1:5.0]/J;

% analytical solution
UTNJ_anal = -coth(2./t_anal) .* (1 + (2./pi) .* (2 .* (tanh(2./t_anal)).^2 - 1).* ellipticK(4.*(sinh(2./t_anal).^2) ./ cosh(2./t_anal).^4));
tc = 2 ./ asinh(1);
L_anal = ((1 - 1./(sinh(2./t_anal).^4)).^(1/8)).* heaviside(tc-t_anal);

figure(2);
plot(t_anal,UTNJ_anal)
hold on
plot(t,U)
xlabel('Normalized Temperature (t=kT/J)')
ylabel('Energy (U(T)/NJ)')
title('Energy of System')
legend('Analytical','Simulated')
hold off

figure(3)
plot(t_anal,L_anal)
hold on
plot(t,L);
xlabel('Normalized Temperature (kT/J)');
ylabel('Order Parameter (L(T))')
title('Order Parameter')
legend('Analytical','Simulated')
hold off
