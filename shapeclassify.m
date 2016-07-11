function [bw1,bw2,bw3] = shapeclassify(bw)

% Create three images with classified objects from a given binary image
% Use:  [bw1,bw2,bw3] = shapeclassify(binary image)

% Inputs : Binary image
% Output : bw1 - Image which contains cells
%          bw2 - Image with contains clumped objects
%          bw3 - Image which contains elongated objects

[L,num] = bwlabeln(bw,4);

idx = detect_noncellular_objects(L,num,0.7);
bwt = ismember(L,idx);
bw1 = bw - bwt;

[L,num] = bwlabeln(bwt,4);
idx = detect_elongated_objects(L,num,2.5);
bw3 = ismember(L,idx);
bw2 = bwt - bw3;
end