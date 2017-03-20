function cong_erf(x)
% error function

format long

%x = 1;

% MATLAB
erf_ml = erf(x);
fprintf('MATLAB error function = %.11f\n',erf_ml)

% Monte Carlo 
N = 10^8;
%randn has std of 1, want 1/sqrt(2) for error function
nums = 1/sqrt(2)*randn(1,N); 
erf_mc = 2/N * length(nums(nums < x & nums > 0));
fprintf('Monte Carlo error function = %.11f\n',erf_mc)

% Riemann Middle sum
epsilon = 10^-11;
num_bins = ceil(x^(3/2)/sqrt(24*epsilon) * sqrt(max(abs(diff(diff(2/sqrt(pi) * exp(-nums.^2)))))));
bin_width = x / num_bins;
r_sum = 0;
for i = 1:num_bins
    r_sum = r_sum + exp(-(bin_width*(i-1/2))^2)*bin_width;
end

erf_rs = 2/sqrt(pi)* r_sum;
fprintf('Riemann Middle sum error function = %.11f\n',erf_rs)

end
