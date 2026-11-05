clc; clear;
// EXERCISE 2: Z-TRANSFORM ANALYSIS & POLE-ZERO PLOT
mprintf("\n================ EXERCISE 2 ================\n");
z = poly(0, 'z');
num2 = 2*z^2 - 0.9*z;
den2 = z^2 - 0.9*z + 0.2;
X2 = syslin('d', num2, den2);

disp("Hàm truyền Z-transform X(z):");
disp(X2);

zeros_ex2 = roots(num2);
poles_ex2 = roots(den2);

disp("Zeros (Nghiệm tử):"); disp(zeros_ex2);
disp("Poles (Nghiệm mẫu):"); disp(poles_ex2);

scf(1); clf(1);
ax1 = gca();
ax1.auto_clear = "off";

plot(real(zeros_ex2), imag(zeros_ex2), 'bo', 'LineWidth', 2, 'MarkerSize', 8);
plot(real(poles_ex2), imag(poles_ex2), 'rx', 'LineWidth', 2, 'MarkerSize', 8);

theta = linspace(0, 2*%pi, 300);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 1);           
plot(0.5*cos(theta), 0.5*sin(theta), 'g-.', 'LineWidth', 1.5); 

legend(['Zeros'; 'Poles'; 'Unit Circle (|z|=1)'; 'ROC Boundary (|z|=0.5)']);
xlabel('Re(z)'); ylabel('Im(z)');
title('Exercise 2: Pole-Zero Plot and ROC (|z| > 0.5)');
xgrid(1); 
isoview("on");
ax1.auto_clear = "on";

// EXERCISE 4: AUDIO DATA PROCESSING DEMO
mprintf("\n================ EXERCISE 4 ================\n");

Fs = 8000;                      
t = 0 : 1/Fs : 0.5;             
f0 = 440;                       
audio_sig = sin(2 * %pi * f0 * t); 
N_fft = length(audio_sig);
fft_sig = abs(fft(audio_sig));
freq_axis = (0 : N_fft/2 - 1) * Fs / N_fft;

scf(2); clf(2);
subplot(2, 1, 1);
plot(t(1:200), audio_sig(1:200), 'b', 'LineWidth', 1.5);
title('Exercise 4: Audio Signal Waveform (Time Domain)');
xlabel('Time (seconds)'); ylabel('Amplitude'); xgrid(1);

subplot(2, 1, 2);
plot(freq_axis, fft_sig(1:N_fft/2), 'r', 'LineWidth', 1.5);
title('Exercise 4: Audio Spectrum (Frequency Domain)');
xlabel('Frequency (Hz)'); ylabel('Magnitude'); xgrid(1);

mprintf("Đã tạo và phân tích tín hiệu âm thanh %d Hz.\n", f0);

// EXERCISE 6: LINEAR CONVOLUTION & SIGNAL ENERGY PLOT
mprintf("\n================ EXERCISE 6 ================\n");
x = [1, 2, -3, 2, 1];
h = [1, 0, -1];
Nx = length(x);
Nh = length(h);
Ny = Nx + Nh - 1;
y_fold = zeros(1, Ny);
for n = 1:Ny
    for k = 1:Nx
        if ((n - k + 1) >= 1) & ((n - k + 1) <= Nh)
            y_fold(n) = y_fold(n) + x(k) * h(n - k + 1);
        end
    end
end
disp("Tích chập y(n) bằng Folding & Shifting:");
disp(y_fold);
H_mat = zeros(Ny, Nx);
for i = 1:Nx
    H_mat(i : i + Nh - 1, i) = h';
end
y_matrix = (H_mat * x')';
disp("Tích chập y(n) bằng Ma trận:");
disp(y_matrix);
Ex = sum(x.^2);            
Ey = sum(y_fold.^2);       
Ex_cum = cumsum(x.^2);
Ey_cum = cumsum(y_fold.^2);
mprintf("Năng lượng x(n): Ex = %.2f\n", Ex);
mprintf("Năng lượng y(n): Ey = %.2f\n", Ey);
scf(3); clf(3);
subplot(3, 1, 1);
plot2d3(0:Nx-1, x, 2); 
plot(0:Nx-1, x, 'bo', 'MarkerSize', 6);
title('Discrete Signal x(n)'); xlabel('n'); ylabel('Amplitude'); xgrid(1);

subplot(3, 1, 2);
plot2d3(0:Ny-1, y_fold, 3); 
plot(0:Ny-1, y_fold, 'ro', 'MarkerSize', 6);
title('Convolution Result y(n)'); xlabel('n'); ylabel('Amplitude'); xgrid(1);

subplot(3, 1, 3);
ax3 = gca();
ax3.auto_clear = "off";
plot(0:Nx-1, Ex_cum, 'b-s', 'LineWidth', 2);
plot(0:Ny-1, Ey_cum, 'r-d', 'LineWidth', 2);
title('Cumulative Energy of Signals'); xlabel('n'); ylabel('Energy');
legend(['Energy of x(n)'; 'Energy of y(n)']); xgrid(1);
ax3.auto_clear = "on";
