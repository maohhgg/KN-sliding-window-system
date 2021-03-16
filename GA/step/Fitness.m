function [fitness, index, best] = Fitness(GA, SWS, RM) 
    global pop;
    
    fitness             = zeros(1, GA.populationSize);      % fitness value
    totalCost           = zeros(1, GA.populationSize);      % total cost
    systemAvailability  = zeros(1, GA.populationSize);      % system availability
    elementAvailability = zeros(GA.populationSize, SWS.m);  % element availability
    position            = zeros(GA.populationSize, SWS.m);  % element allocation
    intervalIndex       = zeros(GA.populationSize, SWS.m);  % replacement interval number index
    

    for i = 1:GA.populationSize
       
        %Step 2.1: Decode the String into Element Allocation and the replacement interval number T_ind
        [~, popSortIndex] = sort(pop(i,:));
        for j = 1:SWS.m
            switch SWS.type
                case 'even'
                    position(i, popSortIndex(j)) = j;  % even position
                case 'uneven'
                    position(i,j) = floor(pop(i, j) / RM.maxReplacementInterval) + 1; % uneven position
            end           
            intervalIndex(i,j) = mod(pop(i, j), RM.maxReplacementInterval) + 1;
        end

        %Step 2.2:Obtain Element Availability
        elementAvailability(i,:) = GetEA(SWS.m, RM.replacementTime, RM.systemLifetime, RM.interval, intervalIndex(i,:), RM.repairTime, RM.lamda);
        
        %Step 2.3:Get total cost
        totalCost(i) = GetTC(SWS.m, RM.systemLifetime, RM.interval, intervalIndex(i,:), RM.lamda, RM.replacementCost, RM.repairCost);
        
        %Step 2.4: Get System Availability
        R = Reliability(SWS.k, SWS.r, SWS.m, SWS.W, elementAvailability(i,:), position(i,:), SWS.type);
        
        %Step 2.5 Compute the fitness Value
        if R < RM.AStar
            fitness(i) = RM.penalty * (RM.AStar - R) + totalCost(i);
        else
            fitness(i) = totalCost(i);
        end
        systemAvailability(i) = R;
    end
    
    [fitness, index] = sort(fitness);
    
    best.V                  = position(index(1),:);
    best.fitness            = fitness(1);
    best.individual         = pop(index(1),:);
    best.intervalIndex      = intervalIndex(index(1),:);
    best.systemAvailability = systemAvailability(index(1));

    clear position;
    clear totalCost;
    clear intervalIndex;
    clear systemAvailability;
    clear elementAvailability;
end