% Manual face finding algorithm based on hue statistics derived from part a
% project 3
% Jason, Blake, Jen

function [] = manfacefind(inputpath)
            figure;
            faceimage = imread(inputpath);
            HSVface = rgb2hsv(faceimage);
            hueimg = HSVface(:,:,1);
            
            HB =(hueimg < .255);
            LB =(hueimg > .1685);
           
            mask = ((LB==0).*HB);
           imshow(faceimage);
            [R,C] = find(mask == 1);
            
            y = mean(R)
            x = mean(C)
            
            
            
            hold on; plot(x,y,'Marker','p','Color',[.88 .48 0],'MarkerSize',20)

            
end