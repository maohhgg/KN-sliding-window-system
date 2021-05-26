clear; clc;
addpath(genpath(pwd)); 

%%% configuration.
RM.AStar					= 0.85;                                                  % pre-specified system availability requirement
RM.interval					= [4 6 10 18 30 50 80 120];                              % Replacement interval
RM.maxReplacementInterval   = length(RM.interval);                                   % maximal number of replacement interval choices              
RM.replacementTime			= 0.001*[6 8 7 8 6 8 9 11 12 11];                        % replacement time
RM.systemLifetime			= 120;                                                   % System lifetime 
RM.replacementCost			= [24 29 37 44 49 55 58 64 71 76];                       % replacement cost
RM.repairCost				= [2.9 2.3 2.5 3.2 3.2 2.7 2.5 3.1 3.2 2.1];             % minimal repair cost
RM.repairTime				= [0.38 0.37 0.31 0.32 0.29 0.31 0.37 0.41 0.39 0.37];   % minimal repair time
RM.penalty					= 9999999;

% the expected failure for each elment for each replacement interval
RM.lamda = [0.5 1.2 3.2 6.2 18.1 42.2 94.7 165.5;
       0.6	1.1	3.3	6.3	17.4 41.5 94.5 167.4;
       0.8	1.3	2.8	6.5	17.8 46.1 93.1 169.9;
       0.7	1.1	3.3	6.7	19.2 42.1 92.9 171.6;
       0.6	1.3	3.2	5.8	16.9 44.9 99.1 163.5;
       0.8	1.2	3.1	6.4	16.1 42.9 95.9 171.5;
       0.7	1.4	2.6	6.8	19.3 41.9 96.2 174.1;
       0.9	1.3	2.9	5.7	20.2 41.2 91.3 167.3;
       0.8	0.9	2.7	6.4	18.4 44.5 98.9 166.4;
       0.6	1.4	3.1	6.5	17.9 45.4 97.1 174.3];   
   
%%% system configuration.
SWS.k		= 2;   
SWS.r		= 4;
SWS.m		= 10;  
SWS.W		= [0.2 40; 0.8 45];     
SWS.type	= 'even';        % system type  even/uneven

%%% genetic algorithm configuration. (GA)
maxIteration = 450;
GA.populationSize	= 25;             % population size
GA.maxIteration		= maxIteration;   % maximal number of iteration
GA.crossoverRate	= 0.8;
GA.mutationRate		= 0.2;

Config.GA           = GA;
Algorithm.GA		= @GeneticAlgorithm;
clear GA;

%%% Simulated Annealing algorithm configuration.
SA.initialTemp		= 100;             % initial temperature
SA.miniTemp			= 0.1^2;           % lower bound of temperature
SA.maxLoop			= 25;              % number of iterations
SA.delta			= 0.98;            % temperature drop rate

%Config.SA          = SA;
%Algorithm.SA		= @SimulatedAnnealing;
clear SA;

%%% Tabu Search algorithm configuration. (TS)         
TS.neighbourSize    = 25;				% neighbour size
TS.tabuSize         = 20;				% tabu talbe size
TS.maxIteration     = maxIteration; 	% maximal number of iteration

Config.TS           = TS;
Algorithm.TS        = @TabuSearch;
clear TS;

%%% Particle Swarm Optimization algorithm configuration (PSO)
PSO.populationSize  = 25;               % population size
PSO.maxIteration    = maxIteration;     % maximal number of iteration
PSO.limit           = [0, SWS.m * RM.maxReplacementInterval]; % Populations of upper and lower boundary values
PSO.speedLimit      = [-1, 1]; 
PSO.learningFactor  = [1.49445, 1.49445];   % learning factor
PSO.inertness       = 0.8;                  % %w = omega      

%Config.PSO          = PSO;
%Algorithm.PSO       = @ParticleSwarmOptimization;
clear PSO;

names = fieldnames(Config);

for i = 1:length(names)
    field = string(names(i));
    [Excel.(field), Images.(field)] = Algorithm.(field)(SWS, RM, Config.(field));
end

SaveExcel(Excel, SWS, RM)
SaveImages(Images)


