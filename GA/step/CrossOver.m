function child = CrossOver(parents, parentsFitness, parentsSize, m)
    crossPoint      = ceil(m * rand());
    inverseFitness  = zeros(1, parentsSize);
    selectProb      = zeros(1, parentsSize);
    cumulativeProb  = zeros(1, parentsSize);
    child           = zeros(2, m);
    
    for i = 1:parentsSize
        inverseFitness(i) = 1 / parentsFitness(i);
    end
    
    total = sum(inverseFitness);
    for i = 1:parentsSize
        selectProb(i) = inverseFitness(i) / total;
    end
    
    tof = 0;
    for i = 1:parentsSize
        cumulativeProb(i) = selectProb(i) + tof;
        tof = cumulativeProb(i);
    end 
    
    fatherProb = rand(); motherProb = rand();
    father = zeros(m,1); mother = zeros(m,1); 
    
    for i = 1:parentsSize
        if fatherProb <= cumulativeProb(i) && ~any(father(:))
            father = parents(i, :);
        end
        if motherProb <= cumulativeProb(i) && ~any(mother(:))
            mother = parents(i, :);
        end
    end

    if ~any(father(:))
        father =  parents(end,:);
    end
    if ~any(mother(:))
        mother =  parents(end,:);
    end
    
    
    a = father; b = mother;
    for i = 1:m
        child(1, i) = a(1, i);
        child(2, i) = b(1, i);
        temp = a;
        a = b;
        b = temp;
    end
    
%     child(1, 1:crossPoint)     = father(1, 1:crossPoint);
%     child(1, crossPoint+1:m)   = mother(1, crossPoint+1:10);
%     
%     child(2, 1:crossPoint)     = mother(1, 1:crossPoint);
%     child(2, crossPoint+1:m)   = father(1, crossPoint+1:10);
end