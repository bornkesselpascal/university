temp = 30;
desiredTemp = 25;

calc = temp - desiredTemp;
if(calc >= 5)
    disp('AC');
elseif(calc <= -5)
    disp('Heat');
else
    disp('off');
end