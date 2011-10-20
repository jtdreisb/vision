% Project 3

dirlist = dir('faces/*');
basedir = 'faces';

maskdir = 'masks';
mkdir masks;

%for x=3: length(dirlist)
%	if (dirlist(x).isdir==1)%make sure it's a dir
 %       imgdir = strcat(basedir,'/',dirlist(x).name);
  %      imgsearch = strcat(imgdir,'/*.jpg');
        
    %    imlist=dir(imgsearch);
   %    
  %      for y=1: length(imlist)
 %           imgpath = strcat(imgdir,'/',imlist(y).name);
%            maskimage = plotdists(imgpath);

 %           maskpath = strcat(maskdir,'/',dirlist(x).name,'/',imlist(y).name);
%            imwrite(maskimage,maskpath,'jpg');

  %      end
 %   end
%end

manfacefind('./faces/1/image_0001.jpg');

%mask = plotdists('./faces/landscape.jpg');
%imwrite(maskimage,'masks/landscape','jpg');

%mask = plotdists('./faces/group.jpg');
%imwrite(maskimage,'masks/group','jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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