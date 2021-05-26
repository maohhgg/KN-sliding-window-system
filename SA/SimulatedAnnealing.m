function [excel, image] = SimulatedAnnealing(SWS, RM, SA)
    excel = struct();
    image = struct();
    
    individual  = floor( SWS.m * RM.maxReplacementInterval * rand(1, SWS.m));
    temperature = SA.initialTemp;
    bestResult  = GetFuncResult(individual, SWS, RM);
            
    iteration = 0;
    while (temperature > SA.miniTemp)
        iteration = iteration + 1;
        for i = 1:SA.maxLoop
            lastIndividual = individual;
            
            individual = GenPosition(individual);
            newResult  = GetFuncResult(individual, SWS, RM);
            
            df = newResult.fitness - bestResult.fitness;
            
            if df < 0
                bestResult = newResult;
            elseif exp(-df/temperature) > rand()
                bestResult = newResult;
            else
                individual = lastIndividual;
            end
        end
        
        temperature = temperature * SA.delta;
        
        [excel, image] = Record(iteration, bestResult, excel, image, 'SimulatedAnnealing');
        image.x(iteration) = iteration;
    end
end