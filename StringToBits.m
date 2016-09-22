%this function takes a string input and returns a list of 8 bit binary 
%numbers.The data type of the result is a character array, so the first
%full binary number will be ans(:,1) instead of ans(1). 
function res = StringToBits(string)
res=dec2bin(string, 8);
