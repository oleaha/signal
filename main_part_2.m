function dtmf_decode = main_part_2( sound_sequence )


%% Remove pause from signal
Fs = 8000;
tone_sample = 0.2*Fs; % Tone length times sample frequency
pause_sample = 0.05*Fs; % Pause length times sample frequency

%Find out how many numbers input signal contains
num_tones = round(length(sound_sequence) / (tone_sample + pause_sample)); % Number of digits in sequence

tones = [];
from = 1; % Keep track of where in the sequence we want to access
for x = 1 : num_tones
   tones = [tones (sound_sequence(from : from + tone_sample - 1))]; % Get one tone from the sequence from given startpoint to endpoint and add to new list
   from = from + tone_sample + pause_sample;
end

figure(1)
plot(sound_sequence)
% figure(2)
% plot(tones)
%% Create bandpass filter
% Identify numbers
freq = [697, 770, 852, 941, 1209, 1336, 1447];

%% Decompose signal to frequency

%% Find corresponding telephone number
% dtmf_decode = [];
% 
% for x = 1 : length(sound_sequence)
%     switch sound_sequence(x)
%         case 1906
%             dtmf_decode = [dtmf_decode '1'];
%         case 2033
%             dtmf_decode = [dtmf_decode '2'];
%         case 2174
%             dtmf_decode = [dtmf_decode '3'];
%         case 1979
%             dtmf_decode = [dtmf_decode '4'];
%         case 2106
%             dtmf_decode = [dtmf_decode '5'];
%         case 2247
%             dtmf_decode = [dtmf_decode '6'];
%         case 2061
%             dtmf_decode = [dtmf_decode '7'];
%         case 2188
%             dtmf_decode = [dtmf_decode '8'];
%         case 2329
%             dtmf_decode = [dtmf_decode '9'];
%         case 2150
%             dtmf_decode = [dtmf_decode '*'];
%         case 2277
%             dtmf_decode = [dtmf_decode '0'];
%         case 2418
%             dtmf_decode = [dtmf_decode '#'];
%         otherwise
%             print('Illegal frequency')
%     end % End switch
% end % End for loop
% end % End function
