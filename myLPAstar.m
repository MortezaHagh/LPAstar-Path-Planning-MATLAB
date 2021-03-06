function [Model, Path] = myLPAstar(Model)
% LPAstar algorithm
% moves robot to next node, then check for map changes and update path

% initialization
[G, RHS, Open] = initializeLPAstar(Model);

t=1;
newObstNode = [];
finalPathNodeNumbers = [Model.Robot.startNode;];

%% main procedure
while Model.startNode~=Model.Robot.targetNode
    
    % compute shortest path
    [G, RHS, Open] = computeShortestPath(G, RHS, Open, Model);
    
    % optimal paths nodes
    pathNodes = finalPathNodes(G, Model);
    
    % move robot to new startNode
    Model.startNode = pathNodes(2);
    finalPathNodeNumbers(end+1) = Model.startNode;
    t=t+1;
    
    % check for update in edge costs (obstacles)
    [Open, RHS, newObstNode, Model] = checkForUpdate(Open, RHS, newObstNode, Model, G, t);
    
end

%% optimal paths coordinations, nodes, directions
Path.nodeNumbers = finalPathNodeNumbers;
Path.coords = nodes2coords(Path.nodeNumbers, Model);
Path.dirs = nodes2dirs(Path.nodeNumbers, Model);

%% update model
Model.startNode = Model.Robot.startNode;
newObstXY = Model.Nodes.cord(:,newObstNode);
Model.Obst.x = [Model.Obst.x, newObstXY(1,:)];
Model.Obst.y = [Model.Obst.y, newObstXY(2,:)];

end