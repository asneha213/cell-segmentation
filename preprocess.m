function bw = preprocess(I,m,v,th)

% Preprocess the given image to output a binary image for segmentation
% Use:  binary image = preprocess(Image, window_of_gaussian_filter,
% variance_of_gaussian_filter, threshold_of_object_size)
% Inputs : Image,
%          Window size of Gaussian filter,
%          Variance of Gaussian filter,
%          Threshold of object size (Remove objects of area less than a
%          given threshold)
% Output : Indices of the objects that are not cells
% Window size of Gaussian filter = 50, Variance = 10
% Threshold for this usage = 75


If = imfilter(I,fspecial('gaussian',[m, m], v));
Is = I - If;
Ig = rgb2gray(Is);
Ig = I(:,:,2);
If = imfilter(Ig,fspecial('gaussian',[m, m], v));
Is = Ig - If;
threshold = graythresh(uint8(Is));
bw = im2bw(uint8(Is),threshold);

bw = bwareaopen(bw,th,4);

end