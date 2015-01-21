function generated_array = generator( )

generated_array = []; % The array we want to return containing the different signals

freq = [697, 770, 852, 941, 1209, 1336, 1447];

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
                generated_array = [generated_array (zFrequency(freq(1)))];
            case '2'
                generated_array = [generated_array (frequency(freq(1), freq(6)))];
                generated_array = [generated_array (zFrequency(freq(1)))];
            otherwise
                disp('Illegal input')
        end % End switch
    end % End for
    sound(generated_array);
end % End if
end % End function

% Simple function to add simplicity
function frequency = frequency(freqOne, freqTwo)
    T = 0.2;
    Fs = 8000;
    t = 0:1/Fs:T; % Sample vektor
    frequency = sin(2*pi*freqOne*t) + sin(2*pi*freqTwo*t);
end

function zeroFrequency = zFrequency(freqOne)
    Fs = 8000;
    z = 0:1/Fs:.05; % Zero Vektor
    zeroFrequency = 0*sin(2*pi*freqOne*z);
end

