% Draws a rough countour from the Hessian and Gradient
%  R  -  Hessian
%  h  -  Gradient
%  c  -  Offset
function [x, y, z] = LMScontour(R, h, c)

    [x,y] = meshgrid(-2:.1:2, -2:.1:3); % 2-D grid of coordinates pairs
    [j,k] = size(x);                    % size of grid (only need x, which is 2-D)
    z = zeros(j, k);

    for m=1:j
        for n=1:k
            % F(x) = c   - 2 x' h               + x' R x
            X = [x(m,n);y(m,n)];
            z(m,n) = 0 - 2*X'*h + (X'*R)*X;
        end
    end

end