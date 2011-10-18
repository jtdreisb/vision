% k means
% Project 3 b
% Jason, Blake, Jen

function [output] = mykmeans(input, k) 
    [height, width, depth] = size(input);
    
    inputmag = input(:,:,1);
    
    for r=1 : height
        for c=1 : width
            inputmag = sqrt(input(r,c,1)*input(r,c,1)+input(r,c,2)*input(r,c,2)+input(r,c,3)*input(r,c,3));
        end
    end
    
    
    output = input(:,:,1);
    
    % initialize the means
    means = [];
    for i=1: k
        means = [means;[i,1,1]];
    end
    
    done = 0;
    while done == 0
        % iterate through the image
        meanvalues = getmeanvalues(inputmag,means);
        
        for i=1 : width
            for j=1 : height
                output(j,i) = closestmean(meanvalues,inputmag(j,i));
            end
        end
        done = 1;
    end
    
end
