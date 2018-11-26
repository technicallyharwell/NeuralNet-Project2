function [ eigenVals, eigenVecs, maxAlpha, h1, h2, x1, x2, R ] = Part1( v, m1, m2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    numDelays = 1;
    z1 = zeros(numDelays, 1);
    z2 = zeros(numDelays, 1);
    z3 = zeros(numDelays, 1);
    
    for n = 1:numDelays + 1    %Builds z vector with k=1.
%        if n < 2
%            z1(n,1) = v(2 - n);
%        end
%        if n > 1
%            z1(2,1) = 0;
%        end
       z1(n,1) = v(2-n);
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
    
    % Finds h's of first and second m(k)'s.
    h1= 1/3 * (m1(1)*z1 + m1(2)*z2 + m1(3)*z3);
    h2= 1/3 * (m2(1)*z1 + m2(2)*z2 + m2(3)*z3);
    
    %There is only a strong minimum for less than two delays. More than
    %that and there are weak minimums or no minimums due to some 
    %eigenvalues being 0 for single sine wave.
    if numDelays<2
    x1=R\h1; % Finds minimum point using first m(k).
    x2=R\h2; % Finds minimum point using second m(k).

    else x1='No strong minimums exist.';
        x2='No strong minimums exist.';
    end
    
end

