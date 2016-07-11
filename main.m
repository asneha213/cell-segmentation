%function bw1 = main(I)

% Return the cell segmented binary image from a given image
% Use:  Segmented_image = main(Image)

% Inputs : Input image,
% Output : Segmented image

I = imread('cropped_31.jp2');
If = imfilter(I,fspecial('gaussian',[50, 50], 10));
Is = I - If;
Ig = rgb2gray(Is);
Ig = I(:,:,2);
If = imfilter(Ig,fspecial('gaussian',[50, 50], 10));
Is = Ig - If;
threshold = graythresh(uint8(Is));
bw = im2bw(uint8(Is),threshold);

bw = bwareaopen(bw,75,4);

[L,num] = bwlabeln(bw,4);
[bw1,bw2,bw3] = shapeclassify(bw);

bw1c = bw1;  bw3c = bw3;
N = 1;

ct = 0;
l = 0;
while ct<20
    ct = ct+1;
    L1 = bwlabeln(bw2,4);
    cpts = concavepoints(bw2);
     for i = 1:size(cpts,2)
        cptsi = cpts{i};
        for j = 1:floor(size(cptsi,1)/2)
            %plot(cptsi(2*j-1,2),cptsi(2*j-1,1),'ro')
            % plot(cptsi(2*j,2),cptsi(2*j,1),'ro')
            [px, py] = bresenham(cptsi(2*j-1,1),cptsi(2*j-1,2),cptsi(2*j,1),cptsi(2*j,2));
            k2 = sub2ind(size(bw),px,py);
            bw2(k2) = 0;
        end
     end
    
     bw2 = bwareaopen(bw2,75,4);
     [bw1c,bw2,bw3c] = shapeclassify(bw2);
     bw1 = bw1 | bw1c;
     bw3 = bw3 | bw3c;
     [L2,N] = bwlabeln(bw2,4);
     if l==N
         break;
     else
         l = N;
     end
     
     
end
[L,num] = bwlabeln(bw1,4);
idx = detect_elongated_objects(L,num,2);
bw1n = ismember(L,idx);
bw1 = bw1 - bw1n;

 

    
