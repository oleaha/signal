% Function that takes in a DTMF signal and returns the corresponding
% telephone number
function main_part_2_2(signal)

    % Some global variables
    Fs = 8000;
    tone_sample = floor(0.2*Fs);
    pause_sample = floor(0.05*Fs);
    freq = [697, 770, 852, 941, 1209, 1336, 1477];
    nice_plot = ['r', 'y', 'b', 'm', 'g', 'c', 'k'];

    %% Remove pause from signal
    % Find number of digits in signal
    num_digits = round(length(signal)/(tone_sample + pause_sample));

    new_signal = [];
    from = 1;

    for x = 1 : num_digits
        % Get one tone from the signal with given start and endpoint
        new_signal = [new_signal (signal(from : from + tone_sample -1))];
        from = from + tone_sample + pause_sample;
    end

    figure(1)
    plot(signal)
    figure(2)
    plot(new_signal)

    %% Create badpass filter
    L = 80; % Number of samples for given DTMF frequences
    n = 0 : L-1;

    filters = []; % Matrix with all DTMF signal frequences

    figure(3)
    Hlp = 1/L; % Low-pass filter

    for i = 1 : length(freq)
        Wc = (2*pi*freq(i))/Fs;
        Hbp = 2*Hlp*cos(Wc*n);
        filters = [filters; Hbp];
        [H W] = freqz(Hbp, 1, L);
        plot(W*Fs / (2*pi), abs(H), nice_plot(i));
        hold on;
    end
    xlabel('Frekvens');
    title('Filter');
    axis([400 2000 0 1]);
    hold off;
    
    %% Decompose signal to frequency and find number
    number = [];
    
    for i = 1 : (length(new_signal)/tone_sample)
        frequency = new_signal((i-1)*(tone_sample)+1:i*tone_sample);
        
        match = [];
        
        for n = 1 : length(freq)
            Y = filter(filters(n, 1:L), 1, frequency); % Compare generated tones from filters with signal
            % If tone is above treshold, add frequency to list
            if max(Y) > 0.80
                match = [match n];
            end
        end
        
        % Connect frequency with corresponding number
        switch (freq(match(1)) + freq(match(2)))
            case 1906
                number = [number '1'];
            case 2033
                number = [number '2'];
            case 2174
                number = [number '3'];   
            case 1979
                number = [number '4'];
            case 2106
                number = [number '5'];
            case 2247
                number = [number '6'];
            case 2061
                number = [number '7'];
            case 2188
                number = [number '8'];
            case 2329
                number = [number '9'];
            case 2150
                number = [number '*']; 
            case 2277
                number = [number '0'];
            case 2418
                number = [number '#'];
            otherwise
                print('Illegal frequency')
        end
    end
    
    number
end


