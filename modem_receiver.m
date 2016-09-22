%modem receiver
received_sound = RecordSound(30);
low_pass_sound = LowPass(received_sound,700);
high_pass_sound = HighPass(HighPass(received_sound,1500),1500);

for i=1:size(high_pass_sound)
    if high_pass_sound(i) < 0
        high_pass_sound(i) = 0;
    end
end

moving_average = MovingAverage(high_pass_sound,8000);

received_value = [];
counter = 1;
for i=0:8000:size(moving_average)
    if moving_average(7000+i) > 0.19
        received_value(counter) = 1;
        counter = counter + 1;
    else
        received_value(counter) = 0;
        counter = counter + 1;
    end
    disp(7000+i)
    disp(moving_average(7000+i))
end