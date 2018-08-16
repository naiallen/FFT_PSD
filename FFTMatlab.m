% __________________________________________________________________%
%                                                                   %
%           Código exemplificando alguns tipos de plotagem          %
%           de espectro no Matlab, utilizando a fft                 %
%___________________________________________________________________%

%Representaçãono domínio do tempo
%SINAL SENOIDAL
f = 10; %frequncia da onda senoidal
osr = 30; %taxa de sobre amostragem
fs = osr*f; %frequencia de amostragem
fase = 1/3*pi; %fase em radianos
nc = 5; %gera a quantidade de ciclos, no nosso caso sao 5 ciclos

t = (0:1/fs:nc*(1/f)); %tempo de amostragem 

yt = sin(2*pi*f*t+fase); %sinal senoidal comum

subplot(4,2,1), plot(t,yt,'g');
title(['Onda Senoidal com f=', num2str(f), 'Hz']);
xlabel('Tempo(s)');
ylabel('Amplitude');

%____________________________________________________________________%
%Representação no domínio da frequencia
%O matlab utiliza a fft (fast fourier transform) que implementa a
%transformada de fourier discreta (DFT). O comando FFT(x,N) computa os N
%pontos de uma DFT.
NFFT = 1024; %número de pontos da DFT, pntos de amostragem
L = length(yt); %tamanho do vetor yt

%1. PLOTANDO VALORES BRUTOS
Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
nVal = 0:NFFT-1;    %pontos de amostragem para o gráfico

subplot(4,2,3), plot (nVal, abs(Yf), 'r');
title('Double Side FFT - Sem utilizar o FFTSHIFT');
xlabel('Pontos de Amostragem');
ylabel('valores DFT');

%2. PLOTANDO VALORES BRUTOS COM EIXO DA FREQUENCIA NORMALIZADO
Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
nVal = (0:NFFT-1)/NFFT;%normalizacao dos pontos de amostragem

subplot(4,2,5), plot (nVal, abs(Yf), 'r');
title('Double Side FFT - Sem utilizar o FFTSHIFT');
xlabel('Frequencia normalizada');
ylabel('valores DFT');

%3. PLOTANDO VALORES BRUTOS COM EIXO DA FREQUENCIA NORMALIZADO E SHIFTADO PARA
%ZERO
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
fVal = (-NFFT/2:NFFT/2-1)/NFFT;%pontos de amostragem normalizados para o gráfico

subplot(4,2,7), plot (fVal, abs(Yf), 'r');
title('Double Side FFT - Utizando o FFTSHIFT');
xlabel('Frequencia normalizada e deslocada para 0');
ylabel('valores DFT');

%4. PLOTANDO FREQUENCIA ABSOLUTA X MAGNITUDE
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
fVal = fs*(-NFFT/2:NFFT/2-1)/NFFT;%pontos de amostragem normalizados para o gráfico

subplot(4,2,2), plot (fVal, abs(Yf), 'r');
title('Double Side FFT - Utizando o FFTSHIFT');
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
subplot(4,2,4), plot (fVal, Px, 'b');
title('Densidade da Potencia Espectral');
xlabel('Frequencia (Hz)');
ylabel('Potencia');

%6. PLOTANDO "POWER SPECTRUM" FREQUENCIA ABSOLUTA X POWER, na escala log
Yf = fftshift(fft(yt, NFFT)); %computa 1024 pontos da DFT 
Px = Yf.*conj(Yf)/(NFFT*L); %Potencia de cada frequencia

fVal = fs*(-NFFT/2:NFFT/2-1)/NFFT; %pontos de amostragem normalizados para o gráfico (negativo ao positivo)
subplot(4,2,6), plot (fVal, 10*log10(Px), 'b'); %plota na escala logaritma
title('Densidade da Potencia Espectral');
xlabel('Frequencia (Hz)');
ylabel('Potencia (dB)');


%7. PLOTANDO "POWER SPECTRUM" com uma banda de frequencia
Yf = fft(yt, NFFT); %computa 1024 pontos da DFT 
Px = Yf.*conj(Yf)/(NFFT*L); %Potencia de cada frequencia

fVal = fs*(0:NFFT/2-1)/NFFT; %pontos de amostragem normalizados para o gráfico (negativo ao positivo)
subplot(4,2,8), plot(fVal,Px(1:NFFT/2), 'b'); %plota na escala logaritma
title('Densidade da Potencia Espectral de uma banda');
xlabel('Frequencia (Hz)');
ylabel('Potencia');
