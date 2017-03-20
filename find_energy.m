function [U] = find_energy(q,J)

nn = circshift(q,[0 1]) + circshift(q,[0 -1]) + circshift(q,[1 0]) + circshift(q,[-1 0]);
U = -J*sum(sum(q.*nn))/numel(q);

end
