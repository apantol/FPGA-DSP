clear all;
clc;

file_real = fopen('C:\Users\Arek\Desktop\sim\fft_re.txt', 'r');
file_imag = fopen('C:\Users\Arek\Desktop\sim\fft_im.txt', 'r');
file_sinus = fopen('C:\Users\Arek\Desktop\sim\sine_in.txt', 'r');



fft_re = fscanf(file_real, '%d\n');
fft_im = fscanf(file_imag, '%d\n');
wv = fscanf(file_sinus, '%d\n');

fft_sig = fft_re + i*fft_im;
mag = abs(fft_sig);

log_fft = 10*log(mag/2^12);

fft_input = fft(wv,1025);

figure(1);
plot(mag,'Color','r')
hold on;
plot(abs(fft_input))

