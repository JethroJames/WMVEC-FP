function [Dis] = get_distance(mode,varargin)
% Calculate the corresponding distance in different modes
view = varargin{1};data = varargin{2}; nbFoc = varargin{3}; Aj = varargin{4};F_update = varargin{5};
alpha = varargin{6}; beta = varargin{7}; delta = varargin{8}; features = varargin{9};
Dis = cell(1,view);
if mode == 1
    R = varargin{10};W = varargin{11};
end
if mode == 2
    M = varargin{10};W = varargin{11};
end
if mode == 3
    M = varargin{10};R = varargin{11};
end
if mode ==4
    W= varargin{10};M = varargin{11};R = varargin{12};
end
for i=1:view
    [Row,~] = size(data{i});
    [ROW,~] = size(F_update{i});
    dis_temp = zeros(Row,ROW);
    dis_cell = cell(1,features(i));
    for p = 1:features(i)
        dis_cell{p} = zeros([Row,nbFoc]);
    end
    % Handle non-empty sets %
    [row,~] = size(Aj{i});
    for j=2:row
        temp = (data{i}-Aj{i}(j,:)).* (data{i}-Aj{i}(j,:));
        % Calculate the cardinality of each class in Aj
        if sum(F_update{i}(j,:)) > 0
            card = sum(F_update{i}(j,:));
        else
            card = 0; % Empty sets and invalid classes are set to 0
        end
        if mode == 1
            temp = temp * W{i};
            temp = sum(transpose(temp));
            temp = temp';
            temp(temp == 0) = 1e-10;
            dis_temp(:,j)=(temp .* R(i) .* card^alpha)';
        end
        
        if mode == 2
            temp = temp * W{i};
            temp = sum(transpose(temp)); 
            temp = temp';
            temp(temp == 0) = 1e-10;
            dis_temp(:,j)=(temp.* (M(:,j).^beta) * card^alpha)';
        end
        if mode == 3
            for p = 1:features(i)
                dis_cell{p}(:,j)=(temp(:,p).* R(i) .* (M(:,j) .^ beta) * (card^alpha))'; 
            end
        end
        if mode == 4
            temp = temp * W{i};
            temp = sum(transpose(temp)); 
            temp = temp';
            dis_temp(:,j)=(temp.* (M(:,j).^beta) * card^alpha .*R(i))';
        end
    end
    % Handle empty sets %
    if mode == 1 
        dis_temp(:,1) = delta(i)^2 .* R(i);
        Dis{i}=dis_temp;
    end
    if mode == 2 
        dis_temp(:,1) = delta(i)^2 .* (M(:,1).^beta);
        Dis{i}=dis_temp; 
    end
    if mode == 3
        Dis{i} = dis_cell;
    end
    if mode == 4 
        dis_temp(:,1) = delta(i)^2 .* (M(:,1).^beta);
        Dis{i}=dis_temp; 
    end
end
end

