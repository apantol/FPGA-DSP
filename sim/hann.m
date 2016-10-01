clc;
clear all;

N = 1024;

n = 0:1:N/2 - 1;
hann_wnd = 0.5*sin(2*pi*n/(N-1)).^2;