% Does the face finding algorithms for all of the different types of characterizations

function [x] = findskin(image, p_skin, p_other, 
						h_m_skin, h_m_other, h_s_skin, h_s_other) 
					%	g_m_skin, g_m_other, g_s_skin, g_s_other)

	hsv = rgb2hsv(image);
	hue = mod(hsv(:,:,1)+.2,1);
	[height, width] = size(hue);

	% skin classification using nearest mean classifier
	nmout=zeros([height width]);
	for r=1: height;
	    for c=1: width;
	        % if it is closer to the mean it is a face pixel
	        if (abs(h_m_skin-hue(r,c)) < abs(h_m_other-hue(r,c)))
	            nmout(r,c) = 1;
	        end
	    end
	end

	figure;
	imshow(nmout); title('Nearest mean classifier on hue');

	% bayes classification
	bcout = zeros([groupheight, groupwidth]);

	for r=1: height;
	    for c=1:width;
	        h_b_skin = p_skin * gaussmf(hue(r,c),[h_s_skin h_m_skin]);
	        h_b_other = p_other * gaussmf(hue(r,c), [h_s_other h_m_other]);
	        if (h_b_skin > h_b_other)
	            bcout(r,c) = 1;
	        end
	    end
	end
	figure;
	imshow(bcout); title('Bayes Classifier on hues');
	x=1;
end