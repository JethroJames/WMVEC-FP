function [W] = update_W(view,dis,features,gamma)
W = cell(1,view);
for i=1:view
    W{i} = eye(features(i)) ./ features(i);
    temp = [];
    for j = 1:features(i)
        D = sum(sum(dis{i}{j}));
        temp = [temp exp(-D/gamma)];
    end
    for j = 1:features(i)
        W{i}(j,j) = temp(j)/sum(temp);
    end
end
end

