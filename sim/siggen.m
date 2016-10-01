clear all;
clc;

load('windows1024.mat');

N = 15;
f = 8000;
L = 1023;

x = 0:1:L;

y1 = (((2^N)/2) - 1).*square(2*3.14*f*x);%.*windows1024(2).coeff;
y2 = (((2^N)/2) - 1).*square(2*3.14*f*x);%.*windows1024(2).coeff;

y1_dig = round(y1);
y2_dig = round(y2);

y1_dig = repmat(y1_dig,1,1000);
y2_dig = repmat(y2_dig,1,1000);

file1 = fopen('C:\Users\Arek\Desktop\sim\sine.txt', 'w');
file2 = fopen('C:\Users\Arek\Desktop\sim\cosine.txt', 'w');


fr = fft((y1 + i*y2),1024);
fprintf(file1,'%d\n',y1_dig');
fprintf(file2,'%d\n',y2_dig');