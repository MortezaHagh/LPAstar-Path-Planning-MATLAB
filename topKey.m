function topnode = topKey(open)

keys = [[open.list.key]', rand(open.count,1)];

% search for node with min cost
[~,sort_inds]=sortrows(keys);
top_key_ind = sort_inds(1);

topnode = open.list(top_key_ind);
topnode.ind = top_key_ind;

if keys(top_key_ind,1)==inf
    disp('No Path!')
end

end
