function result = MovingAverage(X, window)
%This function creates an equally weighted moving average of window size
%"window".  Thus, MovingAverage(X,3) will return a vector in which each
%element is the average of three elements of X.
    v = zeros(window, 1);
    for i = 1:window
        v(i) = 1/window;
    end
    
    result = conv(X, v);

end

