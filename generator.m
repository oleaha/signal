function generated_array = generator( )

generated_array = []; % The array we want to return containing the different signals

freq = [697, 770, 852, 941, 1209, 1336, 1447];
Fs = 8000;
z = 0:1/Fs:.05; % Zero Vektor
zeroFrequency = 0*z; % Small pause betweend dials

% Table funny
% Fs/Hz | 1209 | 1336 | 1477
%  697  |  1   |   2  |  3
%  770  |  4   |   5  |  6
%  852  |  7   |   8  |  9
%  941  |  *   |   0  |  #

input_number = input('Enter phonenumber: ', 's');

if input_number;
    for x = 1 : numel(input_number)
        switch input_number(x)
            case '1'
                generated_array = [generated_array (frequency(freq(1), freq(5)))];               
            case '2'
                generated_array = [generated_array (frequency(freq(1), freq(6)))];
            case '3'
                generated_array = [generated_array (frequency(freq(1), freq(7)))];
            case '4'
                generated_array = [generated_array (frequency(freq(2), freq(5)))];
            case '5'
                generated_array = [generated_array (frequency(freq(2), freq(6)))];
            case '6'
                generated_array = [generated_array (frequency(freq(2), freq(7)))];
            case '7'
                generated_array = [generated_array (frequency(freq(3), freq(5)))];
            case '8'
                generated_array = [generated_array (frequency(freq(3), freq(6)))];
            case '9'
                generated_array = [generated_array (frequency(freq(3), freq(7)))];
            case '*'
                generated_array = [generated_array (frequency(freq(4), freq(5)))];
            case '0'
                generated_array = [generated_array (frequency(freq(4), freq(6)))];
            case '#'
                generated_array = [generated_array (frequency(freq(4), freq(7)))];
            otherwise
                disp('Illegal input')
        end % End switch
        generated_array = [generated_array (zeroFrequency)];
    end % End for
    sound(generated_array)
end % End if
end % End function

% Simple function to add simplicity
function frequency = frequency(freqOne, freqTwo)
    T = 0.2; % Tid for hver lyd
    Fs = 8000; % Samplingsrate
    t = 0:1/Fs:T; % Sample vektor from 0 to T with steps of 1/Fs
    frequency = cos(2*pi*freqOne*t) + cos(2*pi*freqTwo*t);
end

