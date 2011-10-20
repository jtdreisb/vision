
% Project 3

function [] = manfacefind(inputpath)
            figure;
            faceimage = imread(inputpath);
            HSVface = rgb2hsv(faceimage);
            hueimg = HSVface(:,:,1);
            
            HB =(hueimg < .252);
            LB =(hueimg > .1685);
           
            mask = ((LB==0).*HB);
            imshow(mask);
%            [R,C] = find(mask == 1);
 %           
  %          H = max(R);
   %         W = max(C);
    %        x = min(R);
     %       y = min(C);
            
      %      rectangle('Position',[x,y,W,H]);
            
end