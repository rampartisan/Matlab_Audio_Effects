function yrs = MAE_Downsamp(x,Ds)

y = x(1:Ds:end,:);
yr = repmat(y,1,Ds);
yrs = reshape(yr',size(x,2),length(y)*Ds);

% l = length(x);
% 
% for i = 1:l
%     if ~mod(i,Ds)
%         for j = 1:Ds
%     y(i - (j-1),:) = x(i,:);
%         end
%     end
% end