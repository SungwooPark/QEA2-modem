function result = HighPass(X, frequency)
%Filters a given signal with a 16th order butterworth high pass filter.
%Returns the filtered signal in the form of a vector
%   frequency is the desired cutoff frequency in Hz
%   X is a vector representing the input signal.
    samplingRate = 8192; %Hz
    Wn = frequency/samplingRate/2; %normalized cutoff frequency in pi*rad/sample
   %find transfer function coefficients
    [b,a] = fir1(8,Wn,'high');
    %filter the signal
    dataOut = filter(b,a,X);
    result = dataOut;
end

