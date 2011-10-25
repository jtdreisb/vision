% Calcuates variance
% project 4
% Jason, Blake, Jen

function [variance] = myvariance(distribution, meanvalue)


	distribution = distribution-meanvalue;
	distribution = distribution .* distribution;
	variance = sum(distribution)/(size(distribution)(1));

end