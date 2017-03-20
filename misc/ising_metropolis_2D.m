function[u,acceptance]=ising_metropolis_2D(u,beta,J,H)

[L1,L2]=size(u);

acceptance = 0;
n_touch = L1*L2;
i_table = randi(L1,[n_touch,1]);
j_table = randi(L2,[n_touch,1]);
for loop_touch = 1:10*n_touch
    i = i_table(mod(loop_touch,n_touch)+1);
    j = j_table(mod(loop_touch,n_touch)+1);
    f1i = mod(i,L1)+1; b1i=mod(i+L1-2,L1)+1;
    f2j = mod(j,L2)+1; b2j=mod(j+L2-2,L2)+1;
    neighbors=u(f1i,j)+u(b1i,j)+u(i,f2j)+u(i,b2j);
    E_old = -J*u(i,j)*neighbors-H*u(i,j);
    E_new = J*u(i,j)*neighbors-H*u(i,j);
    boltz = exp(-beta*(E_new-E_old));

    if boltz>rand || E_new-E_old < 0
        u(i,j)=-u(i,j);
        acceptance=acceptance+1;
    end
end; clear loop_touch
acceptance = acceptance/n_touch;