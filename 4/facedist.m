% returns the hue distributions for face and nonface pixels
% project 4
% Jason, Blake, Jen

function [facehue, otherhue] = facedist(inputimage,mask)
	% do we need "nonzeros for otherhue?"
	otherhue = inputimage .* double(mask==0);
	facehue = nonzeros(normhue .* double(mask>0));
end
