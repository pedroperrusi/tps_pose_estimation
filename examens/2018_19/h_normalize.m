function [ pts ] = h_normalize( h_pts )
%H_NORMALIZE Remove homogeneous row while normalizing it
%   h_pts: 3xN or 4xN vector of points with last homogeneous row
dim = size(h_pts, 1); % points dimension (2D/3D)
pts = h_pts(1:dim-1,:)./repmat(h_pts(dim,:), dim-1, 1);

end

