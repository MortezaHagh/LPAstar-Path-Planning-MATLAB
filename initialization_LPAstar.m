function [G, RHS, open] = initialization_LPAstar(model)


% G, RHS
G = model.G;
RHS = model.RHS;

% Open list
% open.count
% open.list.
% node key ind

% set the starting node as the first node in Open
topnode.node=model.startNode;
cost_h = Distance(model.xs, model.ys, model.xt, model.yt, model.dist_type);
topnode.key = [cost_h; 0];
RHS(topnode.node)=0;
topnode.ind = 1;

% insert start node in open list
open.list(1) = topnode;
open.count = 1;

end