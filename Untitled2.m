k = 0;
if exist('QTable.mat', 'file') == 2
    load('QTable')
 end
for i=1:length(Q)
    if(Q(i-k,1)== 0 || Q(i-k,2) == 0)
        Q(i-k,:) = [];
        states(i-k,:) = [];
        k = k +1;
    end
end
Untitled;