%this takes as an input a binary number and returns a
%letter.
%BitsToStrings(01110011) = 's'
function res = BitsToStrings(binary)
string = '';
character = num2str(binary); %turns the binary number into a string
string = char(bin2dec(character)); %turns it back into ascii
res = string;
end
        
    