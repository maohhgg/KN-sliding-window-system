function system = GetFuncResult(individual, SWS, RM)
    system.individual          = individual;
    system.position            = zeros(SWS.m, 1);  % element allocation
    system.intervalIndex       = zeros(SWS.m, 1);  % replacement interval number index
    
    %Step 2.1: Decode the String into Element Allocation and the replacement interval number T_ind
    [~, popSortIndex] = sort(individual);

    for j = 1:SWS.m
        switch SWS.type
            case 'even'
                system.position(popSortIndex(j)) = j;  % even position
            case 'uneven'
                system.position(j) = floor(individual(j) / RM.maxReplacementInterval) + 1; % uneven position
        end           
        system.intervalIndex(j) = mod(individual(j), RM.maxReplacementInterval) + 1;
    end

    %Step 2.2:Obtain Element Availability
    elementAvailability = GetEA(SWS.m, RM.replacementTime, RM.systemLifetime, RM.interval, system.intervalIndex, RM.repairTime, RM.lamda);

    %Step 2.3:Get total cost
    totalCost = GetTC(SWS.m, RM.systemLifetime, RM.interval, system.intervalIndex, RM.lamda, RM.replacementCost, RM.repairCost);

    %Step 2.4: Get System Availability
    system.availability = Reliability(SWS.k, SWS.r, SWS.m, SWS.W, elementAvailability, system.position, SWS.type);
    
    %Step 2.5 Compute the fitness Value
    if system.availability < RM.AStar
        system.fitness = RM.penalty * (RM.AStar - system.availability) + totalCost;
    else
        system.fitness = totalCost;
    end
end