% closest mean
% project 3
% Jason, Blake, Jen

function [closest] = closestmean(means, pixel)

    delta = means - pixel;
    [diff, index] = min(delta);
    closest = index;
end