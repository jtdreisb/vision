% closest mean
% project 3
% Jason, Blake, Jen

function [index, val] = closestmean(meanvalues,k, pixel)
    delta = [];
    for i=1 : k
        dmat = meanvalues(i,:) - pixel(:)';
        delta = [delta; dmat*(dmat')];
    end

    [val, index] = min(delta);
end
