# Communication_Projects
Analog QAM Communication System in MATLAB

Overview:
This project demonstrates an Analog Quadrature Amplitude Modulation (QAM) system using MATLAB. In the system, two different message signals are transmitted using two orthogonal carriers with the same carrier frequency.
The first message signal is a song signal, which is modulated using a cosine carrier. The second message signal is a 3 kHz triangle wave, which is modulated using a sine carrier. Since sine and cosine carriers are orthogonal, both signals can share the same carrier frequency band and can be separated at the receiver using coherent demodulation.

Main Idea:
Analog QAM allows two signals to be transmitted simultaneously over the same carrier frequency by using two orthogonal carrier components:
In-phase carrier: cosine carrier
Quadrature carrier: sine carrier
In this project:
The song signal is transmitted on the cosine carrier.
The triangle wave is transmitted on the sine carrier.
The two modulated signals are added to form the Analog QAM transmitter output.
At the receiver, coherent demodulation and lowpass filtering are used to recover both original signals.

System Description:
The carrier frequency is selected as:
fc = 60 kHz
The triangle wave has a fundamental frequency of:
F = 3 kHz
The transmitted QAM signal is formed as:
xqam = song(t)cos(2πfct) + triangle(t)sin(2πfct)
At the receiver side, the QAM signal is multiplied by the corresponding carrier and then passed through a lowpass filter.
For the song signal:
y = 2xqam cos(2πfct)
z = lowpass(y)
For the triangle signal:
y2 = 2xqam sin(2πfct)
z2 = lowpass(y2)

Features:
This MATLAB script performs the following tasks:
Loads a song signal from song.mat
Generates a 3 kHz triangle wave
Modulates the song signal using a cosine carrier
Modulates the triangle wave using a sine carrier
Combines both modulated signals to create an Analog QAM signal
Displays the Fourier transform of the transmitter output
Recovers the song signal using coherent demodulation
Recovers the triangle wave using coherent demodulation
Displays both time-domain and frequency-domain results

Files:
analog_qam.m              Main MATLAB script
song.mat                  Input song signal and sampling frequency
fouriertransform.m        Function used to calculate the Fourier transform
README.md                 Project description

Requirements:
This project requires:
MATLAB
Signal Processing Toolbox
The MATLAB lowpass() function is used for receiver filtering.

How to Run:
Open MATLAB.
Make sure the following files are in the same folder:
analog_qam.m
song.mat
fouriertransform.m
Run the main script:
analog_qam
The script will generate the transmitter and receiver plots.

Output Figures:
The script generates the following figures:
Figure 1: Whole Song Signal
Displays the original song signal in the time domain.
Figure 2: Fourier Transform of Analog QAM Transmitter Output
Shows the frequency-domain representation of the combined QAM signal.
Figure 3: Short Segment of Recovered Song Signal
Displays a short time-domain segment of the recovered song signal.
Figure 4: Fourier Transform of Recovered Song Signal
Shows the frequency-domain representation of the recovered song signal.
Figure 5: Short Segment of Recovered Triangle Signal
Displays three periods of the recovered triangle wave.
Figure 6: Fourier Transform of Recovered Triangle Signal
Shows the frequency-domain representation of the recovered triangle signal.

Result:
The results verify the main principle of Analog QAM. Two different message signals can be transmitted simultaneously using orthogonal carriers with the same carrier frequency. The receiver can then separate these signals using coherent demodulation and lowpass filtering.
The recovered song signal appears in the cosine receiver branch, while the recovered triangle wave appears in the sine receiver branch.

Notes:
The song.mat file must contain:
song
Fs
where song represents the audio samples and Fs represents the sampling frequency.
If song.mat or fouriertransform.m is missing, the script will not run correctly.

Author:
Bartu Alkan
