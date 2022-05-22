function [open, RHS, newobstNode, model] = checkForUpdate(open, RHS, newobstNode, model, G, t)

% check for update cost
if t==4
    % update model
    newobstNode = [newobstNode 36];
    model.obstNode(end+1) = 36;
    model.numOfObs = model.numOfObs+1;
    model.cost(:, newobstNode(end)) = 1000;
    model.cost(newobstNode(end, :)) = 1000;
    
    % update vertex
    nodes_for_update = newobstNode(end);
    [open, RHS] = updateVertex(open, RHS, G, nodes_for_update, model);
    
end

end