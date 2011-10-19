% k means
% Project 3 b
% Jason, Blake, Jen

function [output] = mykmeans(input, k) 
    input = double(input);
    [height, width, depth] = size(input);
    
    inputmag = input(:,:,1);
    
    for r=1 : height
        for c=1 : width
            inputmag(r,c) = norm(input(r,c));
        end
    end
    
    
    output = input(:,:,1);
    
    % initialize the means
    means = [];
    for i=1: k
        means = [means;[i,1]];
    end
    
    
    done = 0;
    while done < 2
        % iterate through the image
        meanvalues = getmeanvalues(inputmag,means);

        for i=1 : width
            for j=1 : height
                output(j,i) = closestmean(meanvalues,inputmag(j,i));
            end
        end
        
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
        
        % Check to see if we moved anything
        done = (newmeans == means);
        means = newmeans;

    end
    
end
