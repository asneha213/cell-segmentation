function idx = detect_elongated_objects(L,num,th)

% Detect the indices of elongated objects in a binary image.
% Use:  indices = detect_noncellular_objects(Label matrix, no.of objects,
% threshold)

% Inputs : Label matrix of a binary image,
%          Number of objects in the image,
%          Threshold of elongation (Rectangularity/Aspect Ratio of minimum
%          bounding box)
% Output : Indices of elongated objects
% Threshold for this usage = 2.5

idx = [];
pidx = regionprops(L,'PixelIdxList');
cc = regionprops(L,'Area');
a = [cc.Area];
for i = 1:num
   
    id = pidx(i).PixelIdxList;
    [x,y] = ind2sub(size(L),id);
    X =[];
    X(1,:) = y;
    X(2,:) = x;
    [ar,arr] = minBoundingBox(X);
    
    if a(i)/(arr*ar) > th 
       idx = [idx i];
   end
   
end
end