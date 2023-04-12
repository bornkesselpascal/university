a = 0;
b = 1;

while(temp < 20)
temp = a;
a = b;
b = temp + b;
disp(temp);
end