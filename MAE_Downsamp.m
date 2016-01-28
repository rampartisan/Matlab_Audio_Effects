function y = MAE_Downsamp(x,Ds)

l = length(x);

for i = 1:l
    if ~mod(i,Ds)
        for j = 1:Ds
    y(i - (j-1),:) = x(i,:);
        end
    end
end