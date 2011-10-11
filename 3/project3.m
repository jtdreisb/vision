% Project 3

figure;
dirlist = dir('faces/*');

for x=1: length(dirlist)
	if (dirlist(x).isdir==1)%make sure it's a dir
	cd dirlist(x)
	imlist=dir('*.jpg');

	for y=1: length(imlist)
		
	end
end
