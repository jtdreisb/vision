% Calcuates variance
% project 4
% Jason, Blake, Jen

function [variance] = myvariance(distribution, meanvalue)


	distribution = distribution-meanvalue;
	distribution = distribution .* distribution;
    length = size(distribution);
	variance = sum(distribution)/(length(1)-1);

end