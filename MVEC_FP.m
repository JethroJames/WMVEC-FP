%% Adaptive Weighted Multi-View Evidential Clustering
% @Date: 2023.04.22
clear all; clc; 
%% Load Data Set
load ProP.mat
Y = truth;
view = 3;features = [393,3,438];
Data{1} = gene_repert;
Data{2} = proteome_comp;
Data{3} = text;
for i = 1:view
    X{i} = Data{i};
    X1 = mapminmax(X{i}',0,1);
    X{i} = X1';
end
%% Initialization
alpha = 2;delta = repmat(5,1,view);threshold = 3;
n_max = 50; epsilon = 1e-3; cluster = max(Y); jaccard = 1e10;
center = cell(1,view); Aj = cell(1,view); U = cell(1,view); F_update=cell(1,view);W = cell(1,view);

%% test
name = "ProP"; % Dataset name
metrics = [];epoch = 0;
beta = 1.8; % beta -> {1.1,1.2,...,2}
lambda = 20.0855369231877; %lambda -> {exp(0),exp(1),...,exp(10)}
gamma = 1; %gamma -> {exp(0),exp(1),...,exp(10)}

for i = 1:view
    center{i} = Centroids_Initialization(X{i},cluster);
end
%-------------------- Initialization ----------------------%
% construction of the focal set matrix %
ii=1:2^cluster;
F=zeros(length(ii),cluster);
for i=1:cluster
      F(:,i)=bitget(ii'-1,i);
end

if cluster>3
    truc = sum(F,2);
    if cluster >= 7
        ind = find((cluster>truc) & (truc>1));
    else
        ind = find(truc>2);
        ind(end)=[];
    end
    F(ind,:)=[];
end

FF = F ; 

if cluster~=2
    if cluster >= 7
        nbFoc = cluster + 2 ; % with empty set and total ignorance
    else
        nbFoc = cluster + cluster*(cluster-1)/2 + 2 ; % with empty set
    end
else
    nbFoc=4;
end
c = sum(F(2:end,:),2)'; 
% R Initialization %
R = repmat(1/view,[1,view]);
% W Initialization %
for i = 1:view
    W{i} = eye(features(i)) ./ features(i);
end
%-------------------- WMVEC-FP ----------------------%

n = 0; output = cell(1,5);flag = 1;m_value=[];J_value = [];
while n < n_max && flag
    n = n + 1;
    if n > 1
       m = M;
       r = R;
    end
    % Aj Initialization %
    [Aj,~] = update_Aj(view,cluster,features,Aj,F,center,nbFoc);
    % Update M %
    F_update = [];
    for i = 1:view
        F_update = [F_update {F}];
    end
    dis = get_distance(1,view,X,nbFoc,Aj,F_update,alpha,beta,delta,features,R,W);
    M = update_M(view,X,dis,beta,nbFoc);
    % Update R %
    dis = get_distance(2,view,X,nbFoc,Aj,F_update,alpha,beta,delta,features,M,W);
    R = update_R(view,dis,lambda);  
    % Update V %
    center = update_V(view,cluster,alpha,beta,X,M,R,F_update,features);
    % Update W %
    dis = get_distance(3,view,X,cluster,Aj,F_update,alpha,beta,delta,features,M,R);
    W = update_W(view,dis,features,gamma);
    % Update Jaccard %    
    dis = get_distance(4,view,X,nbFoc,Aj,F_update,alpha,beta,delta,features,W,M,R,gamma);
    jaccard = update_jaccard(view,lambda,gamma,R,W,dis);
    J_value(end+1) = jaccard;
    % update epsilon %
    if n > 1
        eps_m = abs(jaccard - J_value(end-1));
        if eps_m < epsilon
            flag = 0;
        end
    end
end
%-------------------- BetP ----------------------%
BetP = zeros([length(M),cluster]);
for i = 1:cluster
    pos=[];
    for z = 1:length(F)
        if F(z,i) == 1
           pos(end+1) = z; 
        end
    end
    for j = 1:length(M)
        betp = 0;
        for x = 1:length(pos)
            card = sum(F(pos(x),:));
            betp = betp + M(j,pos(x))/(card * (1 - M(j,1))); 
            BetP(j,i) = betp;
        end
    end
end

%------------------- Evaluation -------------------------%
mass = M; K = cluster;real_label = Y; 
row = size(real_label,1);
res = zeros(row,1);
for i = 1:size(real_label,1)
    [~,idx] = max(BetP(i,:));
    res(i,1) = idx;
end
predY = bestMap(Y, res);
result = CalcMeasures(Y, res);
Outs = valid_external(predY,Y);
fprintf("ACC:%f,RI:%f\n",result(1),Outs(1));
metrics = [metrics;[alpha,beta,lambda,gamma,result(1),Outs(1)]];

%% Save Data
metrics = sortrows(metrics,[5,6]);
Name = "Metrics_" + name + ".mat";
% save(Name,"metrics");  %Save result at local directory
cd ..\Metrics\
save(Name,"metrics");  %Save result at another "Metrics" directory
cd ..\Code\