% returns the hue distributions for face and nonface pixels
% project 4
% Jason, Blake, Jen

function [facehue, otherhue] = facedist(inputimage,mask)
	% do we need "nonzeros for otherhue?"
	otherhue = inputimage(mask==0);
	facehue = inputimage(mask>0);
end
