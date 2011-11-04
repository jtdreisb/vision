% Collects the face masks for all of the images and saves them to disk
% project 4
% Jason, Blake, Jen

getdists=0;
plotgauss=0;
getskin=0;
do2d=0;
calccov=0;
doskin2d=1;

if getdists
    dirlist = dir('faces/*');
    basedir = 'faces';
    maskdir = 'masks';
    facehue  = [];
    otherhue = [];  
    facegreen = [];
    othergreen = [];
     for x=3: length(dirlist)
        if (dirlist(x).isdir==1)%make sure it's a dir
            imgdir = strcat(basedir,'/',dirlist(x).name);
            imgsearch = strcat(imgdir,'/*.jpg');
            maskfolder = strcat(maskdir,'/',dirlist(x).name);

            imlist=dir(imgsearch);

            for y=1: length(imlist)
                imgpath = strcat(imgdir,'/',imlist(y).name);
                img = imread(imgpath);
                maskpath = strcat(maskfolder,'/',imlist(y).name);
                mask = imread(maskpath);

                HSVimage = rgb2hsv(img);
                normhue = mod(HSVimage(:,:,1)+.2,1);

                [fhue,ohue] = facedist(normhue,mask);
                facehue = [facehue; fhue(:)];
                otherhue = [otherhue; ohue(:)];

                %repeat for normalized green
                img = double(img);

                normgreen = img(:,:,2) ./ (img(:,:,1) + img(:,:,2) + img(:,:,3));
                normgreen(isnan(normgreen)) = 0;
                [fgreen, ogreen] = facedist(normgreen, mask);

                facegreen = [facegreen; fgreen(:)];
                othergreen = [othergreen; ogreen(:)];
            end
        end
     end
    % hues
    h_m_skin = mymean(facehue(:))
    h_s_skin = sqrt(myvariance(facehue(:),h_m_skin))
    h_m_other = mymean(otherhue(:))
    h_s_other = sqrt(myvariance(otherhue(:),h_m_other))
    % greens
    g_m_skin = mymean(facegreen(:))
    g_s_skin = sqrt(myvariance(facegreen(:), g_m_skin))
    g_m_other = mymean(othergreen(:))
    g_s_other = sqrt(myvariance(othergreen(:),g_m_other))
else
    %initialize these to the calculated values
    h_m_skin = 0.2143;
    h_s_skin = 0.1154;
    h_m_other = 0.4502;
    h_s_other = 0.2166;
    g_m_skin = 0.3035;
    g_s_skin = 0.0244;
    g_m_other = 0.3372;
    g_s_other = 0.0488;
end

if plotgauss
    % initialize the sampling vector
    x = 0:0.01:1;
    % find the hue distributions 
    figure; 
    subplot(221);imhist(facehue);title('Face'); 
    
    y = gaussmf(x,[h_s_skin h_m_skin]);
    subplot(223); plot(x,y); title('Skin distribution');
    subplot(222);imhist(otherhue); title('Other');
    
    y = gaussmf(x,[h_s_other h_m_other]);
    subplot(224); plot(x,y); title('Other distribution');

    % find normalized green components
    figure; 
    subplot(221);imhist(facegreen);title('Face');
    
    y = gaussmf(x,[g_s_skin g_m_skin]);
    subplot(223); plot(x,y); title('Skin distribution');
    
    subplot(222);imhist(othergreen); title('Other');
    
    y = gaussmf(x,[g_s_other g_m_other]);
    subplot(224); plot(x,y); title('Other distribution');
end

% calculating the p_values is not neccessary because they do not accurately
% represent the bayesian clustering
% count_skin = length(facehue);
% count_other = length(otherhue);
% p_skin = count_skin/(count_skin+count_other);
% p_other = count_other/(count_skin+count_other);
if getskin || doskin2d
%     reg_img = imread('faces/group.jpg');
%     reg_img =  imread('faces/2/image_0022.jpg');
    reg_img =  imread('faces/8/image_0138.jpg');
    %hueify
    img_hsv = rgb2hsv(reg_img);
    img_hue = mod(img_hsv(:,:,1)+.2,1);
    %green
    d_img = double(reg_img);
    img_green = d_img(:,:,2) ./ (d_img(:,:,1) + d_img(:,:,2) + d_img(:,:,3));
    img_green(isnan(img_green)) = 0;
end

if getskin
   
    [hue_nmout, hue_bcout] = findskin(img_hue, .4, .6, h_m_skin, h_m_other, h_s_skin, h_s_other);

    %display the data
    figure;
    subplot(311); imshow(reg_img); title('Goatee hue');
    subplot(312); imshow(hue_nmout); title('Nearest mean classifier');
    subplot(313); imshow(hue_bcout); title('Bayesian classifier');

    %plot the normalized green
    
    [green_nmout,green_bcout] = findskin(img_green, .5, .5, g_m_skin, g_m_other, g_s_skin, g_s_other);

    figure;
    subplot(311); imshow(reg_img); title('Goatee green');
    subplot(312); imshow(green_nmout); title('Nearest mean classifier');
    subplot(313); imshow(green_bcout); title('Bayesian classifier');
end

if do2d
    % plot 2d feature vector
    o_hue=otherhue;
    o_green=othergreen;
    f_hue=facehue;
    f_green=facegreen;
%     o_hue = decimate(otherhue,10);
%     o_green = decimate(othergreen,10);
%     f_hue = decimate(facehue,10);
%     f_green = decimate(facegreen,10);
    figure; scatter(o_hue,o_green);

    hold on; scatter(f_hue,f_green);
end


if calccov
    f_cov = cov(facehue,facegreen)
%     otherhue=decimate(otherhue,5);
%     othergreen=decimate(othergreen,5);
    o_cov = cov(otherhue,othergreen)
else
    f_cov = [0.0133,0.0004;0.0004,0.0006];
    o_cov = [0.0430,0.0015;0.0015,0.0019];
end

if doskin2d
    img_2d=[];
    img_2d(:,:,1) = img_hue;
    img_2d(:,:,2) = img_green;
    [nmout_2d,bcout_2d] = findskin(img_2d, [.5 .5], [.5 .5],[h_m_skin g_m_skin], [h_m_other g_m_other], [h_s_skin g_s_skin], [h_s_other g_s_other]);
    figure;
    subplot(311); imshow(reg_img); title('2d feature');
    subplot(312); imshow(nmout_2d); title('Nearest mean classifier');
    subplot(313); imshow(bcout_2d); title('Bayesian classifier');
end


