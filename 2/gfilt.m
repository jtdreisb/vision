% grayscale filt  returns doubles


function [output] = gfilt(input,mask)
% These are the variables that we use as stopping points when iterating
[maskWidth, maskHeight] = size(mask);
[inputHeight, inputWidth] = size(input);

% offset is the buffer that is required by the mask
offset = (maskWidth+1)/2;

% new is the buffer that we store the values into after applying the filter
new = zeros(inputHeight, inputWidth);

% Loop through each pixel in the input image
for i=offset:(inputWidth-offset+1)
   locx = i-offset+1;
   for j=offset:inputHeight-offset+1
      locy = j-offset+1;
      mult = double(mask).*double(input(locy:locy+maskHeight-1, locx:locx+maskWidth-1));
      new(j,i) = sum(mult(:));
   end
end

output = double(new);
