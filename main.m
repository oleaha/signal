%% Main function for encoding phonenumber into sound
function sound_sequence = generator( )

% The array we want to return containing the different signals
sound_sequence = [];
 % Given sample rate
Fs = 8000;
% Zero Vector
z = 0:1/Fs:.05;
% Pause between sound_sequences
zeroFrequency = 0*z; 

% Table
% Fs/Hz | 1209 | 1336 | 1477
%  697  |  1   |   2  |  3
%  770  |  4   |   5  |  6
%  852  |  7   |   8  |  9
%  941  |  *   |   0  |  #
% The seven frequences that represent the numbers dialed
freq = [697, 770, 852, 941, 1209, 1336, 1477];

input_number = input('Enter phonenumber: ', 's');

if input_number;
    for x = 1 : numel(input_number)
        switch input_number(x)
            case '1'
                sound_sequence = [sound_sequence (frequency(freq(1), freq(5)))];               
            case '2'
                sound_sequence = [sound_sequence (frequency(freq(1), freq(6)))];
            case '3'
                sound_sequence = [sound_sequence (frequency(freq(1), freq(7)))];
            case '4'
                sound_sequence = [sound_sequence (frequency(freq(2), freq(5)))];
            case '5'
                sound_sequence = [sound_sequence (frequency(freq(2), freq(6)))];
            case '6'
                sound_sequence = [sound_sequence (frequency(freq(2), freq(7)))];
            case '7'
                sound_sequence = [sound_sequence (frequency(freq(3), freq(5)))];
            case '8'
                sound_sequence = [sound_sequence (frequency(freq(3), freq(6)))];
            case '9'
                sound_sequence = [sound_sequence (frequency(freq(3), freq(7)))];
            case '*'
                sound_sequence = [sound_sequence (frequency(freq(4), freq(5)))];
            case '0'
                sound_sequence = [sound_sequence (frequency(freq(4), freq(6)))];
            case '#'
                sound_sequence = [sound_sequence (frequency(freq(4), freq(7)))];
            otherwise
                disp('Illegal input')
        end % End switch
        sound_sequence = [sound_sequence (zeroFrequency)];
    end % End for
    sound(sound_sequence)
end % End if
end % End function

%% Function for combining two frequencies
function frequency = frequency(freqOne, freqTwo)

    T = 0.2; % Length of signal/frequency/sound in seconds
    Fs = 8000; % Given sample rate
    t = 0:1/Fs:T; % Sample vektor from 0 to T with steps of 1/Fs
    frequency = cos(2*pi*freqOne*t) + cos(2*pi*freqTwo*t);  % Combine the two frequencies
end

