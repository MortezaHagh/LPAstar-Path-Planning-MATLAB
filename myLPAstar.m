function [model, path] = myLPAstar(model)


% initialization
[G, RHS, open] = initialization_LPAstar(model);

t=1;
newobstNode = [];
first_startNode = model.startNode;
final_path_nodes = [model.startNode;];

%% main procedure
while model.startNode~=model.targetNode
    
    % compute shortest path
    [G, RHS, open] = computeShortestPath(G, RHS, open, model);
    
    % optimal paths nodes
    path_nodes = finalPathNodes(G, model);
    
    % move robot to new startNode
    model.startNode = path_nodes(2);
    final_path_nodes(end+1) = model.startNode;
    t=t+1;
    
    % check for update in edge costs (obstacles)
    [open, RHS, newobstNode, model] = checkForUpdate(open, RHS, newobstNode, model, G, t);
    
end

%% optimal paths coordinations, nodes, directions
path.nodes = final_path_nodes;
path.coords = nodes2coords(path.nodes, model);
path.dirs = nodes2dirs(path.nodes, model);

%% update model
model.startNode = first_startNode;
new_obst_xy = model.nodes.cord(:,newobstNode);
model.xc = [model.xc, new_obst_xy(1,:)];
model.yc = [model.yc, new_obst_xy(2,:)];

end