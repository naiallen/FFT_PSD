% __________________________________________________________________%
%                                                                   %

%___________________________________________________________________%

%Time domain representation-----------------------------------------
%Transmitted signal 
A = 20;                  %[V]   Amplitude: The maximum absolute value reached by a voltage or current waveform.
fs = 500;
Ts = 1/fs;
t = -0.1:Ts:0.1;
w = 80e-3; %width
f = 1/w;
yt = A*rectpuls(t,w);     
magnitude = 2*w*A/(t(end)-t(1))
% power = (A*( w/(t(end)-t(1)) ) )

%--------------------------------------------------------------------

subplot(4,2,1), plot(t,yt,'g');
title(['Square Wave - f =', num2str(f), 'Hz']);
xlabel('Tempo(s)');
ylabel('Amplitude');

%Frequency domain representation-------------------------------------
%O matlab utiliza a fft (fast fourier transform) que implementa a
%transformada de fourier discreta (DFT). O comando FFT(x,N) computa os N
%pontos de uma DFT.
%Bins de frequencia = fs/NFFT = 500/500 = 1
NFFT = 512; %1024;    %sample - número de pontos da DFT, pntos de amostragem
L = length(yt); %tamanho do vetor yt

%1. PLOTANDO VALORES BRUTOS
%The 10 Hz frequency shoud appear in the bin 10 (f/1 -> 10/1)
Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
nVal = 0:NFFT-1;    %pontos de amostragem para o gráfico

subplot(4,2,3), plot (nVal, abs(Yf), 'r');
title('1 - Double Side FFT - Sem utilizar o FFTSHIFT');
xlabel('Pontos de Amostragem');
ylabel('valores DFT');

%2. PLOTANDO VALORES BRUTOS COM EIXO DA FREQUENCIA NORMALIZADO
Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
nVal = (0:NFFT-1)/NFFT;%normalizacao dos pontos de amostragem

subplot(4,2,5), plot (nVal, abs(Yf), 'r');
title('2 - Double Side FFT - Sem utilizar o FFTSHIFT');
xlabel('Frequencia normalizada');
ylabel('valores DFT');

%3. PLOTANDO VALORES BRUTOS COM EIXO DA FREQUENCIA NORMALIZADO E SHIFTADO PARA
%ZERO
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
fVal = (-NFFT/2:NFFT/2-1)/NFFT;%pontos de amostragem normalizados para o gráfico

subplot(4,2,7), plot (fVal, abs(Yf), 'r');
title('3 - Double Side FFT - Utizando o FFTSHIFT');
xlabel('Frequencia normalizada e deslocada para 0');
ylabel('valores DFT');

%4. PLOTANDO FREQUENCIA ABSOLUTA X MAGNITUDE
Yf = fftshift(fft(yt, NFFT))/(0.1*NFFT); %computa 1024 pontos da DFT 
fVal = fs*(-NFFT/2:NFFT/2-1)/NFFT;%pontos de amostragem normalizados para o gráfico

subplot(4,2,2), plot (fVal, abs(Yf), 'r');
title('4 - Double Side FFT - Utizando o FFTSHIFT');
xlabel('Frequencia (Hz)');
ylabel('|valores DFT|');


subplot(4,2,4), plot (fVal, 10*log10(abs(Yf)), 'r');
title('4 - Double Side FFT - Utizando o FFTSHIFT');
xlabel('Frequencia (Hz)');
ylabel('|valores DFT|');

%5. PLOTANDO "POWER SPECTRUM" FREQUENCIA ABSOLUTA X POWER
%Um dos pontos mais importantes ao se trabalhar com o espectro da
%frequencia é saber sua potencia, esta pode ser plotada na escala linear
%logaritma. A potencia é calculada: 
%               Px(f)=Yf.Y*f  (Y* = conjugado)
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
Px = Yf.*conj(Yf)/(NFFT*L);   %Potencia de cada frequencia

fVal = fs*(-NFFT/2:NFFT/2-1)/NFFT; %pontos de amostragem normalizados para o gráfico (negativo ao positivo)
subplot(4,2,6), plot (fVal, Px, 'b');
title('5 - Densidade da Potencia Espectral');
xlabel('Frequencia (Hz)');
ylabel('Potencia');

%6. PLOTANDO "POWER SPECTRUM" FREQUENCIA ABSOLUTA X POWER, na escala log
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
Px = Yf.*conj(Yf)/(NFFT*L); %Potencia de cada frequencia

fVal = fs*(-NFFT/2:NFFT/2-1)/NFFT; %pontos de amostragem normalizados para o gráfico (negativo ao positivo)
subplot(4,2,8), plot (fVal, 10*log10(Px), 'b'); %plota na escala logaritma
title('6 - Densidade da Potencia Espectral');
xlabel('Frequencia (Hz)');
ylabel('Potencia (dB)');


% 7. PLOTANDO "POWER SPECTRUM" com uma banda de frequencia
% Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
% Px = Yf.*conj(Yf)/(NFFT*L); %Potencia de cada frequencia
% 
% fVal = fs*(0:NFFT/2-1)/NFFT; %pontos de amostragem normalizados para o gráfico (negativo ao positivo)
% subplot(4,2,8), plot(fVal,Px(1:NFFT/2), 'b'); %plota na escala logaritma
% title('7- Densidade da Potencia Espectral de uma banda');
% xlabel('Frequencia (Hz)');
% ylabel('Potencia');


