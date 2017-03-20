function [E]=ising_energy(u,J,H)

[L1,L2]=size(u);
E=0;
for i=1:L1
    for j=1:L2
        f1i = mod(i,L1)+1;
        f2j=mod(j,L2)+1;
        forward_neighbors = u(f1i,j)+u(i,f2j);
        E=E-J*u(i,j)*forward_neighbors-H*u(i,j);
    end; clear j
end; clear i