% PROGETTO ZERO INTERLEAVING
%
% Lo script deve ricostruire una sequenza x_n a partire da una sua versione "zero interleaved" indicata con y_n 
% in cui ogni M campioni sono inseriti M-1 zeri (al posto dei campioni originari) 

% Esempio:
% sequenza originaria                       x_n = 1,2,3,4,5,6,7,8,9,10...
% sequenza zero_interleaved (fattore M = 3)  y_n= 1,0,0,4,0,0,7,0,0,10...

% La sequenza di partenza x_n ha 400 campioni ed è fornita nel file zerointerleaving.mat

% Si richiede che lo script Matlab esegua le seguenti operazioni:

% - generi la sequeza zero-interleaved y_n con M variabile (M = 2,3,...),
% cioé si deve poter scegliere il numero di campioni (M-1) da azzerare. 

% - permetta di scegliere la posizione dei campioni non nulli, es. si chiede la 
% possibilità di generare M possibili sequenze con campioni non nulli in posizione 
% Mk, Mk+1, Mk+2, ... Mk+(M-1) con k = 0,1,2,... 

% - rappresenti graficamente la sequenza x_n e le sequenze y_n (zero_interleaved) 
% nel dominio del tempo e delle frequenze (trasformata discreta di Fourier). 
%
% - rappresenti graficamente nel dominio del tempo e delle frequenze il filtro impiegato per la ricostruzione 
% della sequenza x_n 

% - rappresenti graficamente la sequenza originaria x_n e la sua versione
% ricostruita, mostrando che la sequenza ricostruita è la stessa qualunque
% sia la scelta della posizione dei campioni non nulli (purché non vi siano fenomeni di alias). 

% - permetta di valutare il massimo valore di M che non produce distorsione del segnale ricostrutito.

% Strutturare lo script Matlab in modo tale che possa essere rapidamente adattato per gestire sequenze in ingresso 
% diverse da quella assegnata (es. diverso numero di campioni).
% Definire in modo chiaro le variabili utilizzate e commentare sinteticamente i vari passi dello script. 

%close all;
%clear all;
clc;
prompt = ('Inserisci nome file :  ');
nome_file = input (prompt, 's');
load (nome_file);
%load zerointerleaving ; %si può trovare un modo per caricare direttamente in una variabile?
y = x; %crea un secondo vettore per non modificare sequenza originale
dim = length(y);
prompt = 'Inserisci M:  ';
M = input(prompt);
f_s = 1/M;
for i=1:M:dim
        for j = 1:M-1
            if (i+j)>dim
                break
            end
            y(i+j) = 0; 
        end
end
figure
subplot (5,1,1)
stem (x);
subplot (5,1,2)
stem (y);
f  = -f_s : 1 : f_s;
%f  = linspace(-M,M);
filtro = M*rectangularPulse(-M/2,M/2,f);
% syms fx
% fplot(rectangularPulse(fx), [-M/2 M/2])
% filtro = M*rectangularPulse(-M/2,M/2,f*M);
filtro_t = ifft (filtro);
subplot (5,1,3)
stem(f,filtro);
subplot (5,1,4)
stem(f,filtro_t);
z = conv(y,filtro_t)

%creare filtro rettangolo, tenerlo discreto, fare trasformata discreta. 
