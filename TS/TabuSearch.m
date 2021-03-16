function [excel, image] = TabuSearch(SWS, RM, TS)

    [excel, image] = initStruct(TS, SWS);
    image.x         = 1:TS.maxIteration;
    
    individual = floor( SWS.m * RM.maxReplacementInterval * rand(1, SWS.m));
    best = GetFuncResult(individual, SWS, RM);
    
    bestCandidate = best;
    tabuList      = zeros(TS.tabuSize, SWS.m);
    tabuList(1,:) = best.individual;
    i = 1;
    
    for iteration = 1:TS.maxIteration
        
        if i > TS.tabuSize
            i = 1;
        end
        
        neighborhood = GetNeighbors(bestCandidate, SWS, RM, TS);
        bestCandidate = neighborhood(1);
        for sCandidate = neighborhood
            if ~ismember(sCandidate.individual',tabuList,'rows') && (sCandidate.fitness < bestCandidate.fitness)
                bestCandidate = sCandidate;
            end
        end
        
        if bestCandidate.fitness < best.fitness
            best = bestCandidate;
        end
        tabuList(i, :) = bestCandidate.individual;
        i = i + 1;
         
        [excel, image] = Record(iteration, bestCandidate, excel, image);
    end
end