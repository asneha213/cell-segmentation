function idx = detect_noncellular_objects(L,num,th)

% Detect the indices of non cellular objects in a binary image.
% Use:  indices = detect_noncellular_objects(Label matrix, no.of objects,
% threshold)

% Inputs : Label matrix of a binary image,
%          Number of objects in the image,
%          Threshold of Rectangularity (Area of the object/ Area of its
%          minimum bounding box)
% Output : Indices of the objects that are not cells
% Threshold for this usage = 0.7

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
    if a(i)/(arr) < th
        idx = [idx i];
    end
end
end