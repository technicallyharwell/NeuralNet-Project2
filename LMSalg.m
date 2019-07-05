% Least-Mean-Squared Algorithm
%   INPUTS
%     alph  -  learning rate
%     s  -  original input signal
%     v  -  raw noise signal
%     m  -  noise path
%     i  -  epochs/iterations
%     d  -  adaptive filter delays
%   OUTPUTS
%     X  -  evolution of the weight matrix
%     r  -  reconstructed signal
%     e  -  original signal minus restored signal (error signal)
%     t  -  corrupted signal, for optional playback
% Other Notes:
% X(j, k) replaces X(i), Y(i) in the project hint
%   This is used to plot how W changes per iteration of time
function [ X, r, e, t ] = LMSalg( alph, s, v, m, i, d )

    % Initialization of the LMS Algorithm:
    
    samples = d + 1;    % where samples is the total number of inputs resulting from d-delays
                            % e.g. d = 1 delay results in 2 inputs to the network, v(k) and v(k-1)    
    W = zeros(1, samples);  % each input introduces a column to W
    
    %W = [0 -2];    % this weight used to draw "pretty" plots of W against the contour
    
    z = zeros(1, samples);  % samples/delay inputs of v
    X = zeros(i, samples);  % X tracks the value of W over all iterations
    a = zeros(1, i);        % filter output
    e = zeros(1, i);        % error signal
    r = zeros(1, i);        % restored signal
    t = zeros(1, i);        % corrupted signal
    
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
