% Least-Mean-Squared Algorithm
%   INPUTS
%     a  -  learning rate
%     s  -  desired signal
%     v  -  noise
%     m  -  noise path
%     i  -  epochs, iterations, or seconds
%     d  -  adaptive filter delays
%   OUTPUTS
%     X  -  evolution of the weight matrix
%     r  -  reconstructed signal
%     e  -  original signal minus restored signal
%     t  -  corrupted signal, for optional playback
% Other Notes:
% z(j) contains each v(k) sample at a time k for a sample j..
%   "For each unit of time, take delays+1 samples of v(k)"
%   (where samples is the number of delays - 1)
% X(j, k) replaces X(i), Y(i) in the project hint
%   This is used to plot how W changes per iteration of time,
%   for each sample's weight.
function [ X, r, e, t ] = LMSalg( alph, s, v, m, i, d )

    % Initialization of the LMS Algorithm:
    
    samples = d + 1;
    
    W = zeros(1, samples);
    %W = [0 -2];
    z = zeros(1, samples);  % samples of v
    X = zeros(i, samples);
    a = zeros(1, i);        % filter output
    e = zeros(1, i);
    r = zeros(1, i);
    t = zeros(1, i);
    
    % where k is each epoch / unit of time..
    for k = 1:i     
        
        % z = [v(k) v(k-1) ... ]
        for j = 1:samples
            if j <= k
                z(j) = v(k - (j - 1));
            end
        end
                  
        a(k) = W * z';          % Output of adaptive filter
        t(k) = s(k) + m(k);     % Original + noise
        e(k) = m(k) - a(k);     % Error: difference of noise and adaptive output
        r(k) = t(k) - a(k);     % Restored: corrupted signal t(k) less adaptive output a(k)
                
        W = W + 2*alph*e(k)*z;  % Update weight matrix based on learing rate and results
        
        % Tracking the changes to W with respect to:
        %   k - time
        %   j - sample
        for j = 1:samples 
            X(k, j) = W(j); 
        end
        
    end
    
end
