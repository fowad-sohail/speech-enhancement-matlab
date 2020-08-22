%*********************ADD FROM NOISEX DATABASE *******************
% function [t] = addnoisex(sclean,snoise,snr,outfile)
% add noise from a file in noisex database to signal
% t - noisy signal - written in output wave file 
% sclean - clean signal - read either as dat or wave file
% snoise - name of noise file, example: white for 'white.dat'
%       - read in as dat or wave file
% snr - desired snr in db
% outfile - The output file is written as a wav file
% Example [t]=addnoisex('s.wav','street.dat',30,'s_noisy_snr30.wav')
%****************************************************
%
function [t] = addnoisex(sclean,snoise,snr,outfile)

% Read input clean sognal and noise file
[s]=load_or_audioread(sclean);
[nfile]=load_or_audioread(snoise);

% Record length of speech signal and noise file
nspeech=length(s);
nns=length(nfile);

% Randomly select starting sample of noise file and
% read same number of samples as speech signal
start=ceil(rand()*(nns-nspeech+1)); 
finish=start+nspeech-1;
noise=nfile(start:finish);

% Calculate noise power and signal power
powernoise=norm(noise,2);
powersignal=norm(s,2);

% Adjust noise level for desired SNR
u=10^(snr/20);
powerdesirednoise=powersignal/u;
ratio=powerdesirednoise/powernoise;
noise=ratio*noise;

% Add the noise
t=s+noise;

% Display snr
signaltonoise=20.0*log10(powersignal/norm(noise));

% Write as wave file
audiowrite(outfile,t,8000,'BitsPerSample',16);
