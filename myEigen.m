function [ eigenValues, eigenVectors ] = myEigen( H )
% Find eigenvalues and eigenvectors of a Hessian matrix H
    eigenValues = eig(H);
    [eigenVectors, ~] = eig(H);
end

