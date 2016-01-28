function outPut = downsamp(input,Ds)

l = length(input);

for i = 1:l
    if ~mod(i,Ds)
        for j = 1:Ds
    outPut(i - (j-1),:) = input(i,:);
        end
    end
end