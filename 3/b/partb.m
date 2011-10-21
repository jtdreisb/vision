% This will generate both all of the kmean resulta
% project 3
% Jason, Blake, Jen


% this will take quite a while to complete
land = imread('./landscape.jpg');
group = imread('./group.jpg');
face = imread('./face.jpg');

doimg(land);
doimg(group);

pt = facekmean(face, 3);
figure; imshow(face);
hold on; plot(pt(1), pt(2), 'Marker', 'p', 'Color', [.88 .48 0], 'MarkerSize', 20);