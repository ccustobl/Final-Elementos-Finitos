function [hours,minutes,seconds] = calc_time()

c = clock;
if c(4)<10
    hours = strcat(['0',num2str(c(4))]);
else
    hours = num2str(c(4));
end
if c(5)<10
    minutes = strcat(['0',num2str(c(5))]);
else
    minutes = num2str(c(5));
end
if c(6)<10
    seconds = strcat(['0',num2str(c(6))]);
else
    seconds = num2str(c(6));
end
