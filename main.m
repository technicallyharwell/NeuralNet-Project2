% EE 4745 Project 2
% Robert Harwell
% Samuel Smothers

v =  @(k) 1.2*sin(2*pi*k/3);                % raw noise signal
m1 = @(k) .12*sin(2*pi*k/3 + pi/2);         % original noise path m(k)
m2 = @(k) 1.2*sin(2*pi*k/3 - 3*pi/2);       % noise path m(k) for part (f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 : Steps (a) -> (f)
% (a) : eigenvals & eigenvectors of Hessian for mean-square error ;
%           locate minimum point

