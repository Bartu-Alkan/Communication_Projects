

%% Analog QAM
% In this experiment, the song signal is transmitted on a
% cosine carrier, while an additional triangle wave is transmitted on a
% sine carrier with the same carrier frequency. Since cosine and sine are
% orthogonal carriers, the two message signals can share the same carrier
% frequency band and still be separated at the receiver by coherent
% demodulation.
%
% In this script, the following tasks are performed:
%
% # The song signal is loaded and represented in discrete time.
% # A 3 kHz triangle signal is generated.
% # The song is modulated by a cosine carrier.
% # The triangle signal is modulated by a sine carrier.
% # The two modulated signals are added to form the Analog QAM transmitter
%   output.
% # The Fourier transform of the transmitter output is displayed.
% # Two separate coherent demodulators are used to recover the song and the
%   triangle signal.
% # The required time-domain and frequency-domain plots of the receiver
%   outputs are displayed.

%% Program Initialization
%Clear Variables and Close All Figure Windows

% Clear all previous variables
clear
% Close all previous figure windows
close all

%% Read Song File
% *song.mat* contains  *song* variable containing Song samples and *Fs* which is
% the sampling frequency

% Load the song file
load song.mat
% song is the song samples
% Fs is the sampling frequency

% Transform the song to low rate sampling for listening (sound command
% requires sampling rate to be less than 44K
songlowrate=downsample(song,10);
% Listen to
sound(songlowrate,Fs/10);
% convert it to row array
song=reshape(song,1,length(song));
% Sampling Period
Ts=1/Fs;
% Sampling times
t=(0:1:(length(song)-1))*Ts;

%% Display the whole  song

% Display the whole song
figure(1)
plot(t,song);
grid
title('Whole song signal');
xlabel('Time (seconds)');


%% Generate Carrier Signals
% In this QAM system, both carriers have the same carrier frequency:
%
% $$f_c = 60 \text{ kHz}$$
%
% The first carrier is cosine and carries the song signal. The second
% carrier is sine and carries the triangle signal. These two carriers are
% orthogonal, which is the key idea behind Analog QAM.

fc = 60e3;              % Carrier frequency: 60 kHz
c  = cos(2*pi*fc*t);    % In-phase carrier for the song signal
c2 = sin(2*pi*fc*t);    % Quadrature carrier for the triangle signal

%% Triangle wave generation
% Triangle wave between -1 and 1 with 3 kHz fundamental frequency
triangle = @(t) 2*(abs(mod((2*t+1), 2)-1))-1;
F = 3 .* 10 .^ 3; % 3 kHz fundamental frequency
twave = triangle(F*t);

%% Generate QAM transmitter output

% Song is transmitted on cosine carrier
x1 = song .* c;

% Triangle wave is transmitted on sine carrier
x2 = twave .* c2;

% Total transmitter output
xqam = x1 + x2;

%% Fourier Transform of the Transmitter Output
% The Fourier transform of the transmitter output is calculated in order to
% observe how the two message signals share the spectrum around the same
% carrier frequency.

% Figure 2 shows the spectrum of the Analog QAM transmitter output. Since
% the two baseband signals are transmitted using orthogonal carriers at the
% same carrier frequency, the resulting spectrum contains the combined
% effect of both modulated signals.

% Calculate the Fourier Transforms of transmitter output
[FTxqam,freqs]=fouriertransform(xqam, Fs);

% Display the Fourier Transforms of transmitter output
figure(2)
plot(freqs/1000, 20*log10(abs(FTxqam)+1e-12));
grid on
xlabel('Frequency (kHz)');
ylabel('Magnitude (dB)')
title('Fourier Transform of Analog QAM Transmitter Output')
axis([-Fs/2000 Fs/2000 -40 100])




%% Receiver Processing for the Song Signal
% To recover the song signal, the received QAM signal is multiplied by the
% cosine carrier and then passed through a lowpass filter. The multiplication
% step produces a baseband term plus high-frequency terms. The lowpass
% filter removes the high-frequency components and leaves the recovered
% song signal.

y = 2*xqam.*c;
z = lowpass(y,30e3,Fs);

%% Receiver Processing for the Triangle Signal
% To recover the triangle signal, the same QAM signal is multiplied by the
% sine carrier and then passed through a lowpass filter. Due to carrier
% orthogonality, this branch mainly extracts the triangle component while
% suppressing the song component after lowpass filtering.

y2 = 2*xqam.*c2;
z2 = lowpass(y2,30e3,Fs);

%% Fourier transforms of receiver outputs
[FTz, freqs]  = fouriertransform(z, Fs);
[FTz2, freqs] = fouriertransform(z2, Fs);

%% Display a Short Time Segment of the Recovered Song Signal
% Figure 3 shows a short segment of the recovered song output *z*. A small
% window is selected instead of plotting the entire signal so that the
% waveform details can be seen clearly. This figure is useful for checking
% whether the recovered signal shape resembles the original song waveform
% locally.

figure(3)
plot(t(40000:43000)*1000, z(40000:43000))
grid on
xlabel('Time (msecs)')
ylabel('Amplitude')
title('Short Segment of Receiver Output z (Recovered Song Signal)')

%% Display the Fourier Transform of the Recovered Song Signal
% Figure 4 shows the Fourier transform of *z*. Since *z* is the recovered
% song signal, its spectrum is expected to resemble a baseband message
% spectrum.

figure(4)
plot(freqs/1000, 20*log10(abs(FTz)+1e-12))
grid on
xlabel('Frequency (kHz)');
ylabel('Magnitude (dB)')
title('Fourier Transform of Receiver Output z')
axis([-Fs/2000 Fs/2000 -40 100])

%% Display short segment of z2 (3 periods)
% Dispalying the 3 periods of *z2* signal.
N3 = round(3*(1/F)*Fs);
figure(5)
plot(t(1:N3)*1000, z2(1:N3), 'r')
grid on
xlabel('Time (msecs)')
ylabel('Amplitude')
title('Short Segment of Receiver Output z2 (3 Periods)')

%% Display the Fourier Transform of the Recovered Triangle Signal
% Figure 6 shows the Fourier transform of *z2*. Since *z2* is the recovered
% triangle signal, its spectrum should correspond to a baseband triangle-wave
% spectrum. This figure verifies that the sine branch of the receiver
% successfully extracts the second message signal.

figure(6)
plot(freqs/1000, 20*log10(abs(FTz2)+1e-12), 'r')
grid on
xlabel('Frequency (kHz)')
ylabel('Magnitude (dB)')
title('Fourier Transform of Receiver Output z2')
axis([-Fs/2000 Fs/2000 -40 100])

%% Discussion of Results
% The generated figures demonstrate the operation of the Analog QAM system.
%
% * In Figure 2, the transmitter spectrum shows the combined modulated
%   structure produced by the song and the triangle wave.
% * In Figure 3, the recovered song waveform is displayed over a short
%   interval in time, showing that the cosine branch of the receiver
%   extracts the song component.
% * In Figure 4, the Fourier transform of *z* confirms that the recovered
%   song appears in baseband after coherent demodulation and lowpass
%   filtering.
% * In Figure 5, three periods of the recovered triangle signal are shown,
%   which makes the triangular shape clearly visible in the time domain.
% * In Figure 5, three periods of the recovered triangle signal are shown,
%   which makes the triangular shape clearly visible in the time domain.
%
% Overall, the results verify the main idea of Analog QAM: two different
% message signals can be transmitted simultaneously using orthogonal
% carriers of the same carrier frequency and then separated at the receiver
% by coherent demodulation.