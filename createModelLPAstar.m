function model=createModelLPAstar(model)

disp('Create Model LPAstar');

nodes = model.nodes;

%% edge costs, G, RHS
if strcmp(model.adj_type,'4adj')
    q = [1 0; 0 1; 0 -1; -1 0];
    n_adj=4;
elseif strcmp(model.adj_type,'8adj')
    q = [1 0; 0 1; 0 -1; -1 0; 1 1; -1 -1; 1 -1; -1 1];
    n_adj=8;
end

nodes_count = model.nodes.number(end);
successors = cell(nodes_count,1);
cost = inf*ones(nodes_count, nodes_count);

for node=1:nodes_count
    xNode = nodes.cord(1,node);
    yNode = nodes.cord(2,node);
    for k=1:n_adj
        i=q(k,1);  j=q(k,2);
        s_x = xNode+i;
        s_y = yNode+j;
        % check if the Node is within array bound
        if( (s_x>=model.xmin && s_x<=model.xmax) && (s_y>=model.ymin && s_y<=model.ymax))
            s_node = node+i+(j*(model.xmax-model.xmin+1));
            successors{node} = [successors{node}, s_node];
            if ~any(s_node==model.obstNode) && ~any(node==model.obstNode)
                cost(node, s_node) = 1;
                cost(s_node, node) = 1;
            end
        end
    end
end

% G, RHS
G = inf(1, nodes_count);
RHS = inf(1, nodes_count);

%% save model
model.successors=successors;
model.cost=cost;
model.RHS=RHS;
model.G=G;


%% plot model
% plotModel(model);

end
