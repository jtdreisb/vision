% get mean values
% project 3
% Jason, Blake, Jen

function [values] = getmeanvalues(input, means)
    values = [];
    % means is a Kx2 matrix  
    meansize = size(means);
    for i=1: meansize(1) % number of means
        point = means(i,:);
        values = [values; input(point(1),point(2))];
    end
    % values is the vector described by the point that it corresponds to in
    % means
end