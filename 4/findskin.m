% Does the face finding algorithms for all of the different types of characterizations

function [nmout,bcout] = findskin(image, p_skin, p_other, m_skin, m_other, s_skin, s_other) 

	[height, width] = size(image);

	% skin classification using nearest mean classifier
	nmout=zeros([height width]);
	for r=1: height;
	    for c=1: width;
	        % if it is closer to the mean it is a face pixel
	        if (abs(m_skin-image(r,c)) < abs(m_other-image(r,c)))
	            nmout(r,c) = 1;
	        end
	    end
    end
	
	% bayes classification
	bcout = zeros([height, width]);

	for r=1: height;
	    for c=1:width;
	        b_skin = p_skin * gaussmf(image(r,c),[s_skin m_skin]);
	        b_other = p_other * gaussmf(image(r,c), [s_other m_other]);
	        if (b_skin > b_other)
	            bcout(r,c) = 1;
	        end
	    end
	end

end