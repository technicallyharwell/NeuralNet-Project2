function [ eigenVals, eigenVecs, maxAlpha ] = Part1( v )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    numDelays = 1;
    z1 = zeros(numDelays, 1);
    z2 = zeros(numDelays, 1);
    z3 = zeros(numDelays, 1);
    
    for n = 1:numDelays + 1    %Builds z vector with k=1.
       z1(n,1) = v(2 - n);
    end
    for n = 1:numDelays + 1    %Builds z vector with k=2.
       z2(n,1) = v(3 - n);
    end
    for n = 1:numDelays + 1    %Builds z vector with k=3.
       z3(n,1) = v(4 - n);
    end
      
    R1 = z1 * transpose(z1);    % Builds R with k=1.
    R2 = z2 * transpose(z2);    % Builds R with k=2.
    R3 = z3 * transpose(z3);    % Builds R with k=3.
    R = (R1 + R2 + R3) * (1/3); % Sums k's and gives 1/3 weighting to each
    H = 2 * R;                  % Hessian = 2 * R
    
    [eigenVals, eigenVecs] = myEigen(H);
    
    maxAlpha = 2/(max(eigenVals.'));
    
    
    
    
    
end

