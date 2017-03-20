function E = find_energy(i,j,m,q,Jin)


sl = [i, j-1]; sr = [i, j+1]; 
sd = [i+1, j]; su = [i-1, j]; 

% Periodic boundary condition checking
%
% Top edge, 1st row
if (i == 1)
    sl = [i, j-1]; sr = [i, j+1];
    su = [m, j];   sd = [i+1, j]; 
    if (j == 1)
        sl = [i, m]; 
    end
    if (j == m)
        sr = [i, 1]; 
    end
end

% Left edge, 1st column
if (j == 1)
    sl = [i, m];    sr = [i, j+1];
    su = [i-1, j];  sd = [i+1, j]; 
    if (i == 1)
        su = [m, j];
    end
    if (i == m)
        sd = [1, j];
    end
end

% Bottom edge, last row
if (i == m)
    sl = [i, j-1];    sr = [i, j+1];
    su = [i-1, j];  sd = [1, j]; 
    if (j == 1)
        sl = [i, m];
    end
    if (j == m)
        sr = [i, 1];    
    end
end

% Right edge, last column
if (j == m)
    sl = [i, j-1];    sr = [i, 1];
    su = [i-1, j];  sd = [i+1, j]; 
    if (i == 1)
        su = [m, j];
    end
    if (i == m)
        sd = [1, j];
    end
end

% Sum the nearest neighbors and scale by the coupling
% cofficient, J
E = -J*q(i,j)*(q(sl(1),sl(2)) + q(sr(1),sr(2)) ...
        + q(sd(1),sd(2)) + q(su(1),su(2)));
end
