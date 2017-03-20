function monte()
n_grid = 20;
Ms = [];
Js = [];
Ns = [];
Es = [];

J = linspace(0,1,1000);
kappa = 2.*sinh(2*J)./(cosh(2*J)).^2;
kappam = 2*(tanh(2*J)).^2-1;
z = exp(-2*J);
E = -J.*(coth(2*J)).*(1+(2/pi)*kappam.*ellipke(kappam));
M1 = ((1+z.^2).^(1/4).*(1-6*z.^2+z.^4).^(1/8))./(1-z.^2).^(1/2);
M2 = -((1+z.^2).^(1/4).*(1-6*z.^2+z.^4).^(1/8))./(1-z.^2).^(1/2);

for i = 1:12000
    J = rand()+1e-10;
    
    [N,E] = ising(n_grid,J);
    
    Es = [Es E/(n_grid^2)];
    Ns = [Ns N];
    Js = [Js J];
    i=i+1;
end

function [num,E]=ising(N,J)
    B=0;
    E=[];
    randTol = 0.1;
    spin = (-1).^(round(rand(N));
    
    for j=1:1000
        neighbors = circshift(spin,[0 1]) + circshift(spin,[0 -1]) + circshift(spin,[1 0]) + circshift(spin, [-1 0]);
        deltaE = 2*(J*(spin.*neighbors)+B*spin);
        p_trans = exp(-deltaE);
        transitions = (rand(N) < p_trans).*(rand(N)<randTol)*-2+1;
        spin=spin.*transitions;
        E = -sum(sum(deltaE))/2;
        image((spin+1)*128);
        xlabel(sprintf('J=%0.2f,E=%0.2f',J,E/N^2);
        set(gca,'YTickLabel',[],'XTickLabel',[]);
        axis square; colormap bone; drawnow;
    end
    [L,num]=bwlabel(spin==1,4);
end
end