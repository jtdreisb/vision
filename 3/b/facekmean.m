% face finding algorithm
% project 3
% Jason, Jenn, Blake

function [ facepoint ] = facekmean( inputimg ,k )

    meanclustered = mykmeans(inputimg, k);
    
    diffs = [];
    % loop through to find the best approximation for a face
    for i=1 : k
        
        [r,c] = find(meanclustered == k);
        redavg = 0;
        yellow_avg = 0;
        n = size(r);
        for idx=1 : n(1)
            px_rgb = inputimg(r(idx),c(idx),:);

            yellow_avg = yellow_avg + double(px_rgb(2)-px_rgb(3))/double(n(1));
            redavg = redavg + px_rgb(1)/n(1);
        end
        diffs = [diffs; redavg - yellow_avg];
    end
    
    [val, index] = min(abs(diffs));
    val = val;
    [r,c] = find(meanclustered == index);
    facepoint = [mean(r), mean(c)];
    
end