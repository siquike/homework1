function [Ifil] = convolution(I,filter,paddingx,paddingy)

% Ifft = fft2(I);
% filterfft = fft2(filter);
% Ifil = ifft(Ifft.*filterfft);
Ifil = imfilter(I,filter);
Ifil = padarray(Ifil,[paddingx paddingy]);
% Ia = imfilter(a,filter); 
% Ib = imfilter(b,filter); 