% get mean values

function [values] = getmeanvalues(input, means)
    values = [];
    meansize = size(means);
    for i=1: meansize(1) % number of means
        values = [values; input(means(i))];
    end

end