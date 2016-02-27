% Downsamples input signal by discarding indicies 

function yrs = MAE_Downsamp(x,Ds)
% copy input vector, indices in multiples of downsample eg 1..5..9..
y = x(1:Ds:end,:);
% repeat and reshape matrix to make sure sample rate is the same
yr = repmat(y,1,Ds);
yrs = reshape(yr',size(x,2),length(y)*Ds);

% This implimentation is pretty matlab specific, taking advantage of its
% vector/matrix operations. Here is a more general way of doing it.
% l = length(x);
% 
% for i = 1:l
%     if ~mod(i,Ds)
%         for j = 1:Ds
%     y(i - (j-1),:) = x(i,:);
%         end
%     end
% end