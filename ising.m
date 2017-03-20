function [q,U,L] = ising(m,t,J,num_sweeps,q)


% show initial state
U=[];
L=[];

figure(1)
imagesc(q)
colormap bone
drawnow

% compute nearest neighbor indices for each spin
%all spins
s = ([1:m^2])-1;
%4 neighbors per spin
nn_idx = zeros(length(s),4);
nn_idx(:,1) = mod(floor(s/m)+1,m)*m+rem(s,m);  %down
nn_idx(:,2) = mod(floor(s/m)-1,m)*m+rem(s,m);  %up
nn_idx(:,3) = floor(s/m)*m+mod(rem(s,m)+1,m);  %right
nn_idx(:,4) = floor(s/m)*m+mod(rem(s,m)-1,m);  %left
nn_idx = nn_idx+1; % index by one again

% sequence of random spins (with a linear index)
M = m^2*num_sweeps;
spin = randi(m^2,M,1);

for i=1:M
    %random index
    s = spin(i);
    % energy change
    dE = 2*J*q(s)*sum(q(nn_idx(s,:)));
    if dE <= 0
        q(s) = -q(s);
    elseif dE > 0
        if rand < exp(-dE/t) 
            q(s) = -1*q(s); 
        end
    end

    if mod(i,m^2)==0,
        tmp = find_energy(q,J);
        U = [U tmp];
        np = sum(sum((q>0)));
        nd = sum(sum((q<0)));
        tmp2 = abs(np - nd) / (np + nd);
        L = [L tmp2];
        figure(1)
        imagesc(q);
        colormap bone; 
        drawnow;
    end
end
end
