% doimg(takes an image as an input and puts images into figures
% project 3
% Jason, Blake, Jen
function [ ] = doimg( inputimg )
    figure
    subplot(331); imshow(inputimg); title('Input');
    for i=2 : 9     
        out = mykmeans(inputimg,i);
        subplot(3,3,i);imshow(label2rgb(out));
        title(sprintf('k = %d', i));
    end
end

