function [Open, RHS, newobstNode, Model] = checkForUpdate(Open, RHS, newobstNode, Model, G, t)

% check for Map change
if t==4
    % update model
    newobstNode = [newobstNode 36];
    Model.Obst.nodeNumber(end+1) = 36;
    Model.Obst.count = Model.Obst.count+1;
    Model.Predecessors{newobstNode,2} = Model.Predecessors{newobstNode,2}+inf;
    
    % update vertex
    nodesForUpdate = newobstNode(end);
    [Open, RHS] = updateVertex(Open, RHS, G, nodesForUpdate, Model);
end

end