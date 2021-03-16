function [excel, image] = GeneticAlgorithm(SWS, RM, GA)
    global pop;
    pop             = zeros(GA.populationSize, SWS.m);      % Population
    parentsSize     = GA.populationSize * GA.crossoverRate; % 0.8 is called crossover rate
    parents         = zeros(parentsSize, SWS.m);
    parentsFitness  = zeros(1, parentsSize); 
    
    
    [excel, image] = initStruct(GA, SWS);
    image.x        = 1:GA.maxIteration;

    %Step 1: Initialize a population.
    for i = 1:GA.populationSize
        pop(i,:) = floor( SWS.m * RM.maxReplacementInterval * rand(1, SWS.m));
    end
    
    for iteration = 1:GA.maxIteration

        %%%  2. Calculate fitness value && Sort by fitness value.
        [fitness, index, best] = Fitness(GA, SWS, RM);

        %%% 2.5 Record the best individual.
        [excel, image] = RecordLog(iteration, fitness, index, best, excel, image);
        
        %%% 3. Selection
        for i = 1:parentsSize
            parents(i, :)       = pop(index(i),:);
            parentsFitness(i)   = fitness(i);
        end

        %%%% 4. CrossOver
%         i = 0;
%         while i < parentsSize
%             children = CrossOver(parents, parentsFitness, parentsSize, SWS.m);
%             pop(index(20-i),:)    = children(1, :);
%             pop(index(20-i-1), :) = children(2, :);
%             i = i + 2; 
%         end
        
        for i = 1:parentsSize/2
            children    = CrossOver(parents, parentsFitness, parentsSize, SWS.m);
            pop(i,:)    = children(1, :);
            pop(i+10,:) = children(2, :);
        end

        %%% 5: Mutation
        Mutation(GA);

    end
    
    clear parentsSize;
    clear parents;
    clear parentsFitness;
    clear store;
    clear pop;
end