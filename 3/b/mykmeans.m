%hello

function [output] = mykmeans(input, k) 

    
    % initialize the means
    means = [];
    for i=1: k
        means = [means;[i,1,1]];
    end
    
    done = 0;
    while done == 0
        % iterate through the image
        [height, width, depth] = size(input);
        
        meanvalues = getmeanvalues(input,means);
        
        for i=1 : width
            for j=1 : height
                
            end
        end
        done = 1;
    end
    
end