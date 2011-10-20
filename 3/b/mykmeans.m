% k means
% Project 3 b
% Jason, Blake, Jen

function [output] = mykmeans(input, k) 
    input = double(input);
    [height, width, depth] = size(input);

    output = input(:,:,1);
    
    % initialize the means
    means = [];
    for i=1: k
        means = [means;[randi(height),randi(width)]];
    end
    olddiff = Inf;
    
    done = 0;
    while done < 2
        diff = 0;
        % find the mean values for our k mean points
        meanvalues = getmeanvalues(input,means);

        % Go through assigning points to their closest mean value
        for i=1 : width
            for j=1 : height
                [output(j,i), delta] = closestmean(meanvalues, k,input(j,i,:));
                diff = diff + delta;
            end
        end
        
        if olddiff < diff
            done = 1;
            break
        end
        olddiff = diff;
        
        % iterate through the ouput array finding
        % The calculating the new location of the means
        newmeans = [];
        for n=1: k
            [rows, columns]= find(output == n);
            if size(rows) > 0
                newmeans = [newmeans;[round(mean(rows)), round(mean(columns))]];
            else
                newmeans = [newmeans; means(n,:)];
            end
        end
        if (newmeans == means)
            done = 1
        end
        means = newmeans;
    end
    means
end
