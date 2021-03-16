function neighborhood = GetNeighbors(best, SWS, RM, TS)

   
    bestCandidate = GetFuncResult(best.position, SWS, RM);
    neighborhood = struct(bestCandidate);
    
    neighborhood(1) = bestCandidate;
    
    for i = 2:TS.neighbourSize+1
        neighborhood(i) = GetFuncResult(GenPosition(best.position), SWS, RM);
    end
    
end