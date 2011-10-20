% Project 3

function [maskimage] = plotdists(inputpath)

            faceimage = imread(imgpath);
            imshow(faceimage);
            H = imrect;
            pos = wait(H);
            
            foo = size(faceimage(:,:,1))
            
            maskimage = zeros(foo);     
           
            maskimage(pos(2):pos(2)+pos(4),pos(1):pos(1)+pos(3)-1) = 1;
            
            
            nonzero1 = nonzeros(faceimage(:,:,1).*uint8(maskimage));
            nonzero2 = nonzeros(faceimage(:,:,2).*uint8(maskimage));
            nonzero3 = nonzeros(faceimage(:,:,3).*uint8(maskimage));
            
            subplot(2,3,1);imhist(nonzero1);title('Red Distribution');
            subplot(2,3,2);imhist(nonzero2);title('Green Distribution');
            subplot(2,3,3);imhist(nonzero3);title('Blue Distribution');
            
            HSVimage = rgb2hsv(faceimage);
            
            hsvnonzero1 = nonzeros(HSVimage(:,:,1).*(maskimage));
            hsvnonzero2 = nonzeros(HSVimage(:,:,2).*(maskimage));
            hsvnonzero3 = nonzeros(HSVimage(:,:,3).*(maskimage));
            
            subplot(2,3,4);imhist(mod((hsvnonzero1+.2),1));title('Hue Distribution');
            subplot(2,3,5);imhist(hsvnonzero2);title('Saturation Distribution');
            subplot(2,3,6);imhist(hsvnonzero3);title('Intensity Distribution');
end
