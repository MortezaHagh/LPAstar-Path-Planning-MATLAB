function pathNodes = finalPathNodes(G, Model)
% calculate optimap path nodes

i=1;
pathNodes = [];
nodeNumber = Model.Robot.targetNode;

pathNodes(i) = nodeNumber;
while nodeNumber ~= Model.startNode
    i = i+1;
    predNodes = Model.Successors{nodeNumber};
    [~, indMinG] = min(G(predNodes)+ Model.cost(predNodes, nodeNumber)');
    nodeNumber = predNodes(indMinG);
    pathNodes(i) = nodeNumber;
end

pathNodes = flip(pathNodes);

end