% returns the mean of hue distributions
% project 4
% Jason, Blake, Jen

function [meannum] = mymean(distribution)

            distsum = sum(distribution);
            length = size(distribution);
            meannum = distsum/length(1);
end