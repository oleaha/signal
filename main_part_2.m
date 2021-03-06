function dtmf_decode = main_part_2( sound_sequence )


%% Remove pause from signal
Fs = 8000;
tone_sample = 0.2*Fs; % Tone length times sample frequency
pause_sample = 0.05*Fs; % Pause length times sample frequency

%Find out how many numbers input signal contains
num_tones = round(length(sound_sequence) / (tone_sample + pause_sample)); % Number of digits in sequence

num_tones

tones = [];
from = 1; % Keep track of where in the sequence we want to access
for x = 1 : num_tones
   tones = [tones (sound_sequence(from : from + tone_sample - 1))]; % Get one tone from the sequence from given startpoint to endpoint and add to new list
   from = from + tone_sample + pause_sample;
end

%figure(1)
%plot(sound_sequence)
% figure(2)
% plot(tones)


%% Create bandpass filter
% Identify numbers
freq = [697, 770, 852, 941, 1209, 1336, 1477];
nice_plot = ['r', 'y', 'b', 'm', 'g', 'c', 'k'];
L = 80; % Number of for samples for given DTMF frequences
n = 0:L-1; 
filters = []; % Matrix with all DTMF signal frequences

figure(1)
lp_filter = 1/L; % Low-pass filter

for i = 1 : length(freq)
    center_freq = (2*pi*freq(i))/Fs;
    bp_filter = 2*lp_filter*cos(center_freq*n);
    filters = [filters; bp_filter];
    [h w] = freqz(bp_filter, 1, L);
    plot(w*Fs / (2*pi), abs(h), nice_plot(i));
    hold on;
end
title('Filter');
xlabel('Frekvens');
axis([400 2000 0 1]);
hold off;

%% Decompose signal to frequency

result = [];

for i = 1 : (length(tones)/tone_sample)
    filter_number = tones((i-1)*(tone_sample)+1:i*tone_sample);
    
    temp = [];
    for n = 1:length(freq)
        y = filter(filters(n, 1:L), 1, filter_number); %% Compare generated tones from "filters" with incoming signal.
        if(max(y) > 0.50)                              %% If tone is above treshold, add number to telephone number list. 
            temp = [temp n]; 
        end
    end
   switch (freq(temp(1)) + freq(temp(2)))
        case 1906
            result = [result '1'];
        case 2033
            result = [result '2'];
        case 2174
            result = [result '3'];
        case 1979
            result = [result '4'];
        case 2106
            result = [result '5'];
        case 2247
            result = [result '6'];
        case 2061
            result = [result '7'];
        case 2188
            result = [result '8'];
        case 2329
            result = [result '9'];
        case 2150
            result = [result '*'];
        case 2277
            result = [result '0'];
        case 2418
            result = [result '#'];
        otherwise
            print('Illegal frequency')
    end % End switch
end % End for loop

result
end % End function
