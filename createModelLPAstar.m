function Model=createModelLPAstar(Model)
% add neccessary data for LPAstar to Astar Base Model

disp('Complete Model for LPAstar');

%% edge costs, G, RHS
Nodes = Model.Nodes;

switch Model.adjType
    case '4adj'
        ixy = [1 0; 0 1; 0 -1; -1 0];
        nAdj=4;
    case '8adj'
        ixy = [1 0; 0 1; 0 -1; -1 0; 1 1; -1 -1; 1 -1; -1 1];
        nAdj=8;
end

% euclidean manhattan
switch Model.distType
    case 'manhattan'
        edgeLength=2;
    case 'euclidean'
        edgeLength=sqrt(2);
end

nNodes = Model.Nodes.count;
Successors = cell(nNodes,1);
cost = inf*ones(nNodes, nNodes);

for iNode=1:nNodes
    if ~any(iNode==Model.Obst.nodeNumber)
        xNode = Nodes.cord(1,iNode);
        yNode = Nodes.cord(2,iNode);
        for iAdj=1:nAdj
            ix=ixy(iAdj,1);
            iy=ixy(iAdj,2);
            newX = xNode+ix;
            newY = yNode+iy;
            
            % check if the Node is within array bound
            if(newX>=Model.Map.xMin && newX<=Model.Map.xMax) && (newY>=Model.Map.yMin && newY<=Model.Map.yMax)
                newNodeNumber = iNode+ix+iy*(Model.Map.xMax-Model.Map.xMin+1);
                
                if ~any(newNodeNumber==Model.Obst.nodeNumber)
                    Successors{iNode} = [Successors{iNode}, newNodeNumber];
                    if ix~=0 && iy~=0
                        cost(iNode, newNodeNumber) = edgeLength;
                    else
                        cost(iNode, newNodeNumber) = 1;
                    end
                    
                end
            end
        end
    end
end

% G, RHS
G = inf(1, nNodes);
RHS = inf(1, nNodes);

%% save model
Model.startNode = Model.Robot.startNode;
Model.Successors=Successors;
Model.cost=cost;
Model.RHS=RHS;
Model.G=G;

%% plot model
% plotModel(model);

end
