function [jaccard] = update_jaccard(view,lambda,gamma,R,W,dis)
part_1 = 0;
for i= 1:view
    part_1 = part_1 + R(i)*sum(sum(dis{i}));
end
part_2 = 0;
for i=1:length(R)
    part_2 = part_2 + lambda .* sum((R(i)+1e-4).*log(R(i)+1e-4));
end
part_3 = 0;

for i = 1:view 
    for j=1:size(W{i},1)
        part_3 = part_3 + gamma .* sum((W{i}(j,j)+1e-4).*log(W{i}(j,j)+1e-4));
    end
end

jaccard = part_1 + part_2 + part_3;
end