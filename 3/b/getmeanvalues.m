% get mean values
% project 3
% Jason, Blake, Jen

function [values] = getmeanvalues(input, means)
    values = [];
    % means is a Kx2 matrix  
    meansize = size(means);
    for i=1: meansize(1) % number of means
        values = [values; input(means(i,:))];
    end
end