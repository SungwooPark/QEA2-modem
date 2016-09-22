%records the sound for a given amount of time, and returns an array that
%represents the sound. 
function res = RecordSound(time)
recObj = audiorecorder(44100,16,1);
disp('Begin Recording.')
recordblocking(recObj, time);
disp('End of Recording.');
play(recObj);
res = getaudiodata(recObj);