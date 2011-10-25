% returns the hue distributions for face and nonface pixels
% project 4
% Jason, Blake, Jen

function [facehue, otherhue] = huedist(inputimage,mask)

            HSVimage = rgb2hsv(inputimage);
            normhue = mod(HSVimage(:,:,1)+.2,1);
            otherhue = normhue .* double(mask==0);
            facehue = nonzeros(normhue .* double(mask>0));
end
