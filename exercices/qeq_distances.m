function [ sq_dist_P, proj_m ] = qeq_distances( Pcam, Pobj )
%QEQ_DISTANCES Quadratic equations of distances between pairs of points
% Pcam: 2xN Points in camera coordinate frame (mm/mm)
% Pobj: 3XN Points in object coordinate frame (mm/mm/mm)
norm_dot = @(v1, v2) v1'*v2/(norm(v2)*norm(v2));
n = size(Pcam, 2);
n_pairs = factorial(n)/(factorial(n-2)*factorial(2));
proj_m = zeros(n_pairs, 1);
sq_dist_P = zeros(n_pairs, 1);
idx = 1; % output idx (1:n_combinations)
disp(['Quadratic equations for the ' num2str(n_pairs) ' combinations']);
for ii = 1 : n
    for jj = ii : n
        if ii ~= jj
            proj_m(idx) = norm_dot(Pcam(:,ii), Pcam(:,jj));
            diff = Pobj(:, ii) - Pobj(:, jj);
            sq_dist_P(idx) = diff'*diff; % same as norm(diff)^2
            msg = sprintf( ...
                '||P%i P%i|| = %.1f \t= D%i^2 + D%i^2 - 2*D%i*D%i*%.4f', ...
                ii, jj, sq_dist_P(idx), ii, jj, ii, jj, proj_m(idx));
            disp(msg);
            idx = idx + 1;
        end
    end
end

end

