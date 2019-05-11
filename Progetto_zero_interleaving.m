START
close all;
%clear all;
clc;

%prompt = ('Inserisci nome file :  ');
%nome_file = input (prompt, 's');
%load (nome_file);
%si può trovare un modo per caricare direttamente in una variabile?
load zerointerleaving.mat
%y = x; %crea un secondo vettore per non modificare sequenza originale
dim = length(x);
M = input('Inserisci M: ');
f_s = 1/M; %frequenza di campionamento
%f  = -f_s : 1 : f_s;

ZERO-INTERLEAVING
y_n=zeros(M,dim); %crea una matrice di zeri contenente le M sequenze lungo le righe
Yf_n=y_n; %copia la matrice creata in quella che sarà la trasformata
for j=1:M %ciclo per creare sequenze campionate
    i=j;
    while i<dim+1
        y_n(j,i)=x(i); 
        i=i+(M);
    end
end

TRASFORMAZIONI 
n = (0:dim-1);
To = dim*M;
DF = 1/To;
Xf=fft(x); 
figure
subplot(2,1,1)
stem (n,x);
xlabel ('Campioni')
title('Sequenza di Partenza')
pause
subplot(2,1,2)
stem (DF*n,real(Xf));
xlabel ('Frequenza (Hz)')
title('Trasf seq X')
pause
for k=1:M
    titolo = 'Sequenza con primo elemento diverso da 0 in posizione %d';
    pos = k-1; %indice di posizione che viene riportato nel grafico
    Yf_n(k,:)=fft(y_n(k,:));
    figure
    subplot(2,1,1)
    stem(n,y_n(k,:));
    xlabel ('Campioni')
    title(sprintf(titolo,pos))
    subplot(2,1,2)
    stem(DF*n,real(Yf_n(k,:)));
    xlabel ('Frequenza (Hz)')
    title('Sequenza trasformata')
    pause
end

FILTRO
figure
f = linspace(-M,M);
filtro = M*rectangularPulse(-M/2,M/2,f*M);
% syms fx
% fplot(rectangularPulse(fx), [-M/2 M/2])
filtro_t = fft (filtro);
subplot (3,1,1)
stem(f,real(filtro));
title('Filtro in frequenza')
subplot (3,1,2)
stem(f,real(filtro_t));
title('Filtro nei tempi')
%subplot (3,1,3)
for i=1:M
    figure
    %z = Yf_n(i,:).*real(filtro);
    z = conv(y_n(i,:),real(filtro_t),'full');
    stem(z);
end
%% 

%creare filtro rettangolo, tenerlo discreto, fare trasformata discreta. 
