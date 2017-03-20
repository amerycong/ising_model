function [U,L] = ising2d(j,J,T,M,m,q)

% parameters
beta = 1.0 / j*T;

% Monte Carlo loop
r_rands = randi(m,[m^2 M]);
c_rands = randi(m,[m^2 M]);
U = 0;
for idx = 1:M
    for idx2=1:m^2
        
        % pick random spin and flip
        i = r_rands(idx2,idx);
        j = c_rands(idx2,idx);
        q_trial = q;
        q_trial(i,j) = -q(i,j);
        
        % calculate new energy and difference
        E_old = find_energy(i,j,m,q,J);
        dE = -2*E_old;
        
        % decide if accept flip
        if dE <= 0
            q = q_trial;
            U = U+dE;
        elseif dE > 0
            if rand < exp(-beta*dE)
                q = q_trial;
                U = U+dE;
            end
        end
    end
    % show spins and E, L
    figure(3)
    imagesc(q)
    n_plus = sum(sum(q > 0));
    n_minus = sum(sum(q < 0));
    Ltmp = (n_plus - n_minus) / numel(q);
    title(sprintf('L=%f',Ltmp))
    colormap(gray)
    drawnow;
end

% compute L
n_plus = sum(sum(q > 0));
n_minus = sum(sum(q < 0));
L = abs(n_plus - n_minus) / numel(q);
end
