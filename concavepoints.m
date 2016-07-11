function cpts = concavepoints(bw)

%Return the points along which the object can be split based on concave
%point analysis
% Input   : Binary image
% Output  : Coordinates of split points in every object on the image

L = bwlabeln(bw,4);
b = bwboundaries(L);
cpts = {};
%figure, imshow(bw); hold on;
for i = 1:size(b,1)
     bi = b{i};
      b0 = circshift(bi,5);
    b2 = circshift(bi,11); 
      br = b0(1:size(b0,1)-1, :);
    pd = pdist(br);
    Z = [];
    Z1 = [];
    Z = squareform(pd);
    for k = 1:size(Z,1)
        for j = 1:size(Z,1)
            Z1(k,j) = max(Z(k,j)/abs(k-j), Z(k,j)/abs(size(Z,1) - max(k,j) + min(k,j)));
        end
    end
    for k = 1:size(Z,1)

            Z1(k,k) = Inf;

    end
    
    d = abs((b2(:,2) - bi(:,2)).*(bi(:,1) - b0(:,1)) - (bi(:,2) - b0(:,2)).*(b2(:,1) - bi(:,1)))./ sqrt(sum((b2 - bi) .^2,2) );
    d = single(d);
    bt = 0.5*(bi + b2);
    bm = ceil(bt);
    bmi = sub2ind(size(L),bm(:,1),bm(:,2));
    bmw = bw(bmi);
    k3 = find(bmw ~= 0);
    d(k3) = 0;
    arr = [];
    k = find(d == max(d));
    for l = 1:size(k,1)
        if k(l) <= size(Z1,1)
        [minz, indz] = min(Z1(k(l),:));
       
        arr = [arr; b0(indz,1) b0(indz,2)];
        %plot(b0(indz,2),b0(indz,1),'ro');
        end
       
        arr = [arr; b0(k(l),1),b0(k(l),2)];
        %plot(b0(k(l),2),b0(k(l),1),'ro');
    
    end
    cpts{i} = arr;
end

end