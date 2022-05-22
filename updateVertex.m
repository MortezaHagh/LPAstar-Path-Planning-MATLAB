function [open, RHS] = updateVertex(open, RHS, G, nodes_for_update, model)

for node=nodes_for_update
    if node~=model.startNode
        pred_nodes = model.successors{node};
        [val_minG, ~] = min(G(pred_nodes) + model.cost(pred_nodes, node)');
        RHS(node) = val_minG;
    end
    
    check = node==[open.list.node];
    if any(check)
        open.list(check) = [];
        open.count = open.count-1;
    end
    
    if G(node)~=RHS(node)
        open.count = open.count+1;
        op.node = node;
        node_xy = model.nodes.cord(:,node);
        cost_h = Distance(node_xy(1), node_xy(2), model.xt, model.yt, model.dist_type);
        op.key = min(G(node), RHS(node)) + [cost_h; 0];
        op.ind = open.count;
        open.list(op.ind) = op;
    end
    
end

end