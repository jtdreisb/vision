% Does the face finding algorithms for all of the different types of characterizations

function [nmout,bcout] = findskin(image, p_skin, p_other, m_skin, m_other, s_skin, s_other) 

	[height, width, depth] = size(image);

	% skin classification using nearest mean classifier
	nmout=zeros([height width]);
	for r=1: height;
	    for c=1: width;
	        % if it is closer to the mean it is a face pixel
            skin_diff = m_skin-image(r,c);
            other_diff = m_other-image(r,c);
	        if skin_diff*(skin_diff') < other_diff*(other_diff')
	            nmout(r,c) = 1;
	        end
	    end
    end
	
	% bayes classification
	bcout = zeros([height, width]);

	for r=1: height;
	    for c=1:width;
            b_skin=1;
            b_other=1;
            for i=1:depth
                b_skin = b_skin * gaussmf(image(r,c,i),[s_skin(i) m_skin(i)]);
                b_other = b_other * gaussmf(image(r,c,i), [s_other(i) m_other(i)]);
            end
	        b_skin = p_skin * b_skin;
	        b_other = p_other * b_other;
	        if (b_skin > b_other)
	            bcout(r,c) = 1;
	        end
	    end
	end

end