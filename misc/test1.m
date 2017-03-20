clear all;
close all
L=256;
u=2*randi(2,L,L)-3; 
beta = 1e-3:1e-4:1e-2;
J=1;
H=0;
colormap(gray)
for i = 1:length(beta)
    [u,acceptance]=ising_metropolis_2D(u,1./beta(i),J,H);
    E=ising_energy(u,J,H);
    en(i)=E;
    T(i)=beta(i);
    figure(1)
    imagesc(u)
    pause(0.01)
end
