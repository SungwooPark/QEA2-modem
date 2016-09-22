text = StringToBits('hello')
text_size = size(text);
text_row = text_size(1);
text_col = text_size(2);
%Create 0.5s sound at sampling rate of 8192
low_freq = 660;
high_freq = 1320;
t = 0:(1/8192):0.5;
low_sound = sin(2*pi*low_freq*t);
high_sound = sin(2*pi*high_freq*t);

for i = 1:text_row
    for j = 1:text_col
        num_value = str2num(text(i,j));
        if num_value == 0
            PlaySound(low_sound)
            pause(0.6)
        else
            PlaySound(high_sound)
            pause(0.6)
        end
    end
end

%sound_result = RecordSound(1);