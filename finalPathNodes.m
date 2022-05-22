function path_nodes = finalPathNodes(G, model)

i=1;
path_nodes = [];
node = model.targetNode;

path_nodes(i) = model.targetNode;
while node ~= model.startNode
    i = i+1;
    pred_nodes = model.successors{node};
    [~, ind_minG] = min(G(pred_nodes)+ model.cost(pred_nodes, node)');
    node = pred_nodes(ind_minG);
    path_nodes(i) = node;
end

path_nodes = flip(path_nodes);

end