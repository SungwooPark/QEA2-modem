bit_stream = StringToBits('hello');
%reshape bitstream to be a row vector
bit_stream = reshape(bit_stream,1,[]);

%Num of elements that each bit unit takes in a signal vector to be
%transmitted.
unit_length = 5000;

%counter pointing to current position in a signal vector
counter = 25001;

sig = [];

%Fill beginning part with start signal (0.2)
sig(1:25000) = 0.5;

%Generating a binary signal. -1 in the signal: 0 in binary data. 1 in the signal: 1
%0 is a filler value to differentiate discrete values
bit_stream_size = size(bit_stream);
num_elem = bit_stream_size(2);
for i=1:num_elem
    if bit_stream(i) == '0'
        sig(counter:counter+unit_length-1) = -1;
        counter = counter + unit_length;
    else
        sig(counter:counter+unit_length-1) = 1;
        counter = counter + unit_length;
    end
    sig(counter:counter+unit_length-1) = 0;
    counter = counter + unit_length;
end


fs = linspace(-pi, pi*(length(sig)-1)/length(sig),length(sig));
%plot(fs,abs(fftshift(fft(sig))));
% subplot(311)
%plot(sig)

%time value for signal vector
time_value_n = [0:length(sig)-1];
wc = 0.0712; %shifting factor

%modulate signal
mod_sig = sig .* cos(wc*time_value_n);
%plot(fs,abs(fftshift(fft(mod_sig))));
% plot(mod_sig)
%sound(mod_sig,44100)

%demodulating signal 
demod_sig = mod_sig.* cos(wc*time_value_n);
%plot(fs, abs(fftshift(fft(demod_sig))));

%Apply low pass filte on demodulated signal
cut_off = 0.001; %cut-off frequency for low pass filter
n = [-40:39];
h = cut_off/pi*sinc(cut_off*n/pi);

filtered_sig = conv(demod_sig,h);

%subplot(211)
%plot(filtered_sig)

[test, Fs] = audioread('recorded_sound.wav');
%plot(test)

test_fs = linspace(-pi, pi*(length(test)-1)/length(test),length(test));
%plot(test_fs, abs(fftshift(fft(test))));

demod_test_n = [0:length(test)-1];
demod_test = test' .* cos(wc*demod_test_n);
%plot(test_fs, abs(fftshift(fft(demod_test))))
% plot(demod_test)
filtered_test_sig = conv(demod_test,h);

%refilter signal
filtered_test_sig = conv(filtered_test_sig, h);
filtered_test_sig = conv(filtered_test_sig, h);
filtered_test_sig = conv(filtered_test_sig, h);

filtered_test_fs = linspace(-pi, pi*(length(filtered_test_sig)-1)/length(filtered_test_sig),length(filtered_test_sig));
% plot(filtered_test_fs, abs(fftshift(fft(filtered_test_sig))));
%subplot(212)
plot(filtered_test_sig)

%interpreting signal
demod_bit_low = []; %low bit signal indicators
demod_bit_high = []; %high bit signal indicators
for i=80000:10000:size(test)-10000
    demod_bit_low(end+1)= min(filtered_test_sig(i:i+5000));
    demod_bit_high(end+1)= max(filtered_test_sig(i:i+5000));
end

demod_bit = []; %demodulated bit
demod_bit_size = size(demod_bit_low);
for i=1:demod_bit_size(2)
    if demod_bit_low(i) < -1.5*10^-7
        demod_bit(i) = 0;
    elseif demod_bit_high(i) > 1.5*10^-7
        demod_bit(i) = 1;
    else
        demod_bit(i) = -1;
    end
end

%Filter unnecessary bits and reshape into vector of 8 columns
for i=1:demod_bit_size(2)
    if demod_bit(i) == -1
        unnecessary_bit_index = i;
        break
    end
end
demod_bit = demod_bit(1:unnecessary_bit_index-1);
demod_bit_size = size(demod_bit);
demod_bit = reshape(demod_bit,[int64(demod_bit_size(2)/8),8]);

%convert bits to string
trans_msg = BitsToStrings(demod_bit)