% Median filter


function [output] = mymedian(input, dimension) 

[inputHeight, inputWidth] = size(input);

offset = (dimension+1)/2;

% new is the buffer that we store the values into after applying the filter
new = zeros(inputHeight, inputWidth);

for i=offset:(inputWidth-offset+1)
   locx = i-offset+1;
   for j=offset:(inputHeight-offset+1)
      locy = j-offset+1;
      mask = input(locy:locy+dimension-1, locx:locx+dimension-1);
      new(j,i) = median(mask(:));
   end
end
output = uint8(new);
