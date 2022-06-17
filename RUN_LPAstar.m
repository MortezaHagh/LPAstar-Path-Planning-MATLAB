% LPA*: Lifelong Planning A* Path Planning Algorithm - MATLAB
% Morteza Haghbeigi, m.haghbeigi@gmail.com

% Initialization
clc
clear
close

%% settings
Model.expandMethod = 'random';   % random or heading
Model.distType = 'manhattan';    % euclidean or manhattan;
Model.adjType = '4adj';          % 4adj or 8adj

%% create Map and Model - loading a Map Matrix

% % load Map and create model - (1:free, o:obstacles)
%  load(map_name, 'Map');
% Model = createModelFromMap(Map, Model);

% % add robot data to model
% Model = addRobotToModel(Model);

%% Create Map and Model by User
% createModelBaseEmpty createModelBase
Model=createModelBase(Model);
Model = createModelLPAstar(Model);

%% optimal path by LPAstar
% Path: nodeNumbers, coords, dirs
tic
[Model, Path] = myLPAstar(Model);
Sol = Path;
Sol.pTime = toc;
Sol.cost = costL(Sol.coords);
Sol.smoothness = smoothness(Sol.coords);
% [Sol.cost, Sol.solChar]= costLinear(Model, Sol.coords);

%% display data and plot solution
disp(['process time for path= ' num2str(Sol.pTime)])
disp(Sol)

plotModel(Model)
plotSolution(Sol.coords, [])
% plotAnimation2(Sol.coords)

%% clear temporal data
clear adj_type dist_type

