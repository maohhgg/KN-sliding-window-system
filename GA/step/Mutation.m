function individual = Mutation(GA)

    global pop;
    
    for i = 1:GA.populationSize
        individual = pop(i,:);
        if rand() <= GA.mutationRate
            selectIndex1 = ceil(10 * rand());
            selectIndex2 = ceil(10 * rand());
            
            temp = individual(1, selectIndex1);
            individual(1, selectIndex1) = individual(1, selectIndex2);
            individual(1, selectIndex2) = temp;
        end
        pop(i,:) = individual;
    end

end