% Radix 4 Decimation in Frequency 
% Similar Adaptation of Radix 2 Decimation in Frequency
% Input : Normal Order, An array of Length N
% Output: Output Bits reversed X[k]
% For any length N (RADIX 4 DIF)
% Done by Nevin Alex Jacob
% Instructions : Input an array of numbers time domain (real or complex) to the function and
% ex : radix4DIF([1 2 3 4])
% If any mistakes/clarifications, do contact me
% Email : nevinalex1234@gmail.com
% Reference: DSP Proakis And Manolakis
% On Inspection its evident that Radix 4 is similar to the Radix 2 Posted
% Earlier Except for the change in Butterfly design

function radix4(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp=length(x);
p=1;                            
while (4^p)<temp                 % Finding the nearest power 
      p=p+1;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=[x zeros(1,(4^p)-length(x))]; % Appending the existing array with zeros and making the length a power of 4 (Radix 4)
N=length(x);
M=N/4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for stage=1:p 
       % No of stages for Decimation
    for k=0:N/(4^(stage-1)):N-1; % Starting Index for the 4 point butterflies
          k;
         for n=0:(M-1);          % Within each butterfly, indexing for the elements as a function of x[n] Input
             % Each Stage Contains N/4 FFTs PRECOMPUTATION OF all combo Here finding out all combinations of data values for future use & In place computation
            % *************************************************************  
              a=x(n+1+k) +  x(n+(M)+1+k) + x(n+(2*M)+1+k) +   x(n+(3*M)+1+k)  ;
              b=x(n+1+k) -j*x(n+(M)+1+k) - x(n+(2*M)+1+k) + j*x(n+(3*M)+1+k)  ;
              c=x(n+1+k) -  x(n+(M)+1+k) + x(n+(2*M)+1+k) -   x(n+(3*M)+1+k)  ;
              d=x(n+1+k) +j*x(n+(M)+1+k) - x(n+(2*M)+1+k) - j*x(n+(3*M)+1+k)  ;
            % *************************************************************
              x(n+1+k)       = a*exp(  -j*((2*pi)/N)* (0) *(4^(stage-1)) ) ;
              x(M+n+1+k)     = b*exp(  -j*((2*pi)/N)*(n*1)*(4^(stage-1)) ) ;                 % In place Computation
              x((2*M)+n+1+k) = c*exp(  -j*((2*pi)/N)*(n*2)*(4^(stage-1)) ) ;
              x((3*M)+n+1+k) = d*exp(  -j*((2*pi)/N)*(n*3)*(4^(stage-1)) ) ;
             %*************************************************************
           end;     
    end;
M=M/4;
end;
x