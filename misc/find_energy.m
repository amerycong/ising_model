function E = find_energy(i,j,m,q,J)

% neighbor indices
left = [i j-1]; 
right = [i j+1]; 
down = [i+1 j]; 
up = [i-1 j]; 



% check boundaries
if (i == 1)
    left = [i j-1]; 
    right = [i j+1];
    up = [m j];   
    down = [i+1 j]; 
    if (j == 1)
        left = [i m]; 
    end
    if (j == m)
        right = [i 1]; 
    end
end

if (j == 1)
    left = [i m];    
    right = [i j+1];
    up = [i-1 j];  
    down = [i+1 j]; 
    if (i == 1)
        up = [m j];
    end
    if (i == m)
        down = [1 j];
    end
end

if (i == m)
    left = [i, j-1];    
    right = [i, j+1];
    up = [i-1, j];  
    down = [1, j]; 
    if (j == 1)
        left = [i, m];
    end
    if (j == m)
        right = [i, 1];    
    end
end

if (j == m)
    left = [i, j-1];    
    right = [i, 1];
    up = [i-1, j];  
    down = [i+1, j]; 
    if (i == 1)
        up = [m, j];
    end
    if (i == m)
        down = [1, j];
    end
end

% energy
E = -J*q(i,j)*(q(left(1),left(2)) + q(right(1),right(2)) + q(down(1),down(2)) + q(up(1),up(2)));
end
