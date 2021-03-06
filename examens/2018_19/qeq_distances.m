function [ sq_dist_P, proj_m ] = qeq_distances( Pcam, Pobj )
%QEQ_DISTANCES Quadratic equations of distances between pairs of points
% Pcam: 3xN Points in camera coordinate frame (mm/mm)
% Pobj: 3XN Points in object coordinate frame (mm/mm/mm)
norm_dot = @(v1, v2) v1'*v2/(norm(v1)*norm(v2));
n = size(Pcam, 2);
n_pairs = n*(n-1)/2; % combination of n elements, 2 by 2
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
                '||P%d P%d|| = %.1f \t= D%d^2 + D%d^2 - 2*D%d*D%d*%.4f', ...
                ii, jj, sq_dist_P(idx), ii, jj, ii, jj, proj_m(idx));
            disp(msg);
            idx = idx + 1;
        end
    end
end

end

