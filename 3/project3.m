% Project 3

figure;

dirlist = dir('faces/*');
basedir = 'faces';

for x=3: length(dirlist)
	if (dirlist(x).isdir==1)%make sure it's a dir
        imgdir = strcat(basedir,'/',dirlist(x).name);
        imgsearch = strcat(imgdir,'/*.jpg');
        
        imlist=dir(imgsearch);
       
        for y=1: length(imlist)
            imgpath = strcat(imgdir,'/',imlist(y).name);
            imshow(imread(imgpath));
            H = imrect;
            pos = wait(H);
        end
    end
end
