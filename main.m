% EE 4745 Project 2
% Robert Harwell



clear;
hold off;

v =  @(k) 1.2*sin(2*pi*k/3);                % raw noise signal
m1 = @(k) .12*sin(2*pi*k/3 + pi/2);         % original noise path m(k)
m2 = @(k) 1.2*sin(2*pi*k/3 - 3*pi/2);       % noise path m(k) for part (f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 : Steps (a) -> (f)
% (a) : eigenvals & eigenvectors of Hessian for mean-square error ;
%           locate minimum point

[eVals, eVecs, maxA, h1, h2, x1, x2, R] = Part1( v, m1, m2 );

fprintf('Eigenvalues and Eigenvectors of Hessian: \n')
eVals %#ok<*NOPTS>
eVecs
fprintf('Calculated minimum point x1: \n')
x1
fprintf('Calculated minimum point x2: \n')
x2

%figure
[ x3, y3, z3 ] = LMScontour( R, h1, 0);
contour(x3, y3, z3);
title('Rough Contour (m1)');
xlabel('w1,1');
ylabel('w1,2');

figure
[ x, y, z ] = LMScontour( R, h2, 0);
contour(x, y, z);
title('Rough Contour (m2)');
xlabel('w1,1');
ylabel('w1,2');

% (b) : maximum stable learning rate for LMS
fprintf('Maximum stable learning rate for LMS algorithm: \n')
maxA

% (c) : implement LMS algorithm
a = 0.12;
i = 95;
delays = 1;
samples = delays + 1;
s = zeros(1, i);
for k = 1:i
    s(k) = -2 + 4 * rand();
end

[ X1, r1, e1, t1 ] = LMSalg( a, s, v, m1, i, delays);
[ X2, r2, e2, t2 ] = LMSalg( a, s, v, m2, i, delays);

figure
%[ x3, y3, z3 ] = LMScontour( R, h1, 0);
%contour(x3, y3, z3);
%hold on;
plot(X1(:,1), X1(:,2))
title('Convergence to minimum point m1, alpha = 0.12')
xlabel('w1,1');
ylabel('w1,2');
hold off;

figure
plot(X2(:,1), X2(:,2))
title('Convergence to minimum point m2, alpha = 0.12')
xlabel('w1,1');
ylabel('w1,2');

% (d) : plot the original and restored signals
figure
subplot(2, 1, 1);
plot(s, '- red')
xlabel('k');
%ylabel('s(k)');
hold on;
plot(r1, '-- blue')
%ylabel('r1(k)');
title('Original signal s(k) and restored signal r1(k)')
subplot(2, 1, 2);
plot(e1);
title('e1(k) = m1(k) - a1(k)')
xlabel('k');
ylabel('e1(k)');
hold off;

figure
subplot(2, 1, 1);
plot(s, '- red')
hold on;
plot(r2, '-- blue')
title('Original signal s(k) and restored signal r2(k)')
subplot(2, 1, 2);
plot(e2);
title('e2(k) = m2(k) - a2(k)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(g) : record and play background, noise, corrupted signal, and filtered outputs

fprintf('Part (g) \n')

a = 0.36;
delays = 3;

[voice, vSamples] = audioread('voice.m4a');
[noise, nSamples] = audioread('noise.wav');
% Need to exetend noise signal to last duration of voice signal..
numRepeat = ceil(length(voice)/length(noise));  % how many times to repeat noise
extendedNoise = repmat(noise, 1, numRepeat);    % extend noise signal
extendedNoise = extendedNoise(1:length(voice)); % fit noise to len of voice

% assuming that noise signal == noise path..
[ X3, r3, e3, t3 ] = LMSalg( a, voice, extendedNoise, extendedNoise, length(voice), delays);

audiowrite('restored.wav', r3, vSamples);
audiowrite('corrupted.wav', t3, vSamples);

figure
subplot(3, 2, 1);

plot(voice, '- red');
%hold on;
%plot(r3, '-- green');
%title('Original and restored (sound)');
title('Original input signal');
xlabel('k');
ylabel('s(k)');
subplot(3, 2, 2);

plot(r3, '--green');
title(['Restored signal r(k) with alpha = ', num2str(a)]);
xlabel('k');
ylabel('r(k)');
subplot(3, 2, 3);

plot(extendedNoise);
title('Noise signal v(k)');
xlabel('k');
ylabel('v(k)');
subplot(3, 2, 4);

plot(t3);
title('Original signal s(k) + noise v(k)');
xlabel('k');
ylabel('s(k) + v(k)');

subplot(3, 2, 5);
plot(e3);
title(['e(k) = s(k) - r(k), with mean of: ', num2str(mean(e3)), ' and ', num2str(delays), ' delays']);
xlabel('k');
ylabel('e(k)');

subplot(3, 2, 6);
plot(voice, '-red');
hold on;
plot(r3, '--blue');
xlabel('k');
title(['Original signal s(k) (red) and restored signal r(k) (blue); mean error sq: ', num2str(mean(e3.^2))]);
hold off;

%figure
% subplot(2, 1, 1);
% plot(e3);
% title('Original audio minus restored audio (a=0.012, 2 delays)');
% subplot(2, 1, 2);
% plot(t3);
% title('Corrupted signal (sound)');

% figure
% plot(X3(:,1),X3(:,2))
% title('Convergence to minimum of audio (a=0.012, 2 delays)');
% 



