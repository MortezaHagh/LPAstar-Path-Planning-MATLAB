function [G, RHS, open] = computeShortestPath(G, RHS, open, model)

% select top key
topnode = topKey(open);

% update goal_key
goal.node = model.targetNode;
goal.key = min(G(goal.node), RHS(goal.node))*[1; 1];

while compareKeys(topnode.key, goal.key) || RHS(goal.node)~=G(goal.node)
    
    % remove topkey from open
    open.list(topnode.ind)=[];
    open.count = open.count-1;
    
    % update vertex
    nodes_for_update = model.successors{topnode.node};
    if G(topnode.node)>RHS(topnode.node)
        G(topnode.node) = RHS(topnode.node);
    else
        G(topnode.node) = inf;
        nodes_for_update(end+1) = topnode.node;
    end
    [open, RHS] = updateVertex(open, RHS, G, nodes_for_update, model);
    
    % select top key
    topnode = topKey(open);
    
    % update goal_key
    goal.key = min(G(goal.node), RHS(goal.node))*[1; 1];
    
end

end