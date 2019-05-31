function [C,labels] = extract_theme(I, k, sigma)
%I: Image
%K: number of palettes
%Sigma: is sigma!
% increase one more to remove dark palette color
k = k + 1;
bin = 16;
Ibin = floor(255*I/bin);

[weights, X,l1] = im3Dhist(I,Ibin, bin);
% Initialize the cluster centers
cinits = zeros(k, 3);
cw = weights;
N = size(X, 1);
sigma2 = sigma^2;
for i = 1:k
    [~,id] = max(cw);
    cinits(i,:) = X(id,:);
    d2 = repmat(cinits(i,:), N, 1) - X; 
    d2 = sum(d2 .* d2,2);
    cw = cw .* (1 - exp(-d2/sigma2));
end


opt.weight = weights;
[l2, C, ~] = fkmeans(X, cinits, opt);

% C = cinits;
% sort by brightness
[~,id] = sort(C(:,1), 'descend');
C = C(id,:);
C = C(1:k-1,:); %ignore black or darkest color

labels=l1;
for kk=1:length(l2)
    if l2(kk)~=id(end)
        v=find(id==l2(kk));
        labels(l1==kk)=v;
    else
        labels(l1==kk)=0;
    end
end

% covert to rgb
colorTransform = makecform('lab2srgb');
C = applycform(C, colorTransform);

function [W, C,labels] = im3Dhist(I,Ibin, bin)
[h, w, ~] = size(I);

% Compute 3D histogram 
Ibin = reshape(Ibin, [], 3);
n = bin;
J = Ibin(:,1)*n*n + Ibin(:,2)*n + Ibin(:,3) + 1;
N = h*w;
M = n * n * n;


% Compute the mean of each bin in Lab
colorTransform = makecform('srgb2lab');
lab = applycform(I, colorTransform);
lab = reshape(lab, [], 3);
weights = zeros(M, 2);
csums = zeros(M, 3);
for i = 1:N
    weights(J(i),1) = weights(J(i),1) + 1;
    weights(J(i),2)=J(i); %index of J
    csums(J(i),:) = csums(J(i),:) + lab(i,:);
end

% Remove all empty bins
ids = find(weights(:,1) ~= 0);
W = weights(ids,:);
C = csums(ids,:);
C = C ./ repmat(W(:,1),1,3);

labels=zeros(size(J));
for i=1:size(W,1)
    labels(J==W(i,2))=i;
end
labels=reshape(labels,[h, w]);
W=W(:,1);