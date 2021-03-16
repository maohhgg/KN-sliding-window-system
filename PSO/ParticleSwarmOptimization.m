function [excel, image] = ParticleSwarmOptimization(SWS, RM, PSO)

    [excel, image] = initStruct(PSO, SWS);
    
    v          = zeros(PSO.populationSize, SWS.m);
    individual = zeros(PSO.populationSize, SWS.m);

    for i = 1:PSO.populationSize
        individual(i, :) = floor((PSO.limit(2) - PSO.limit(1)) * rand(1, SWS.m));%初始种群的位置
        v(i, :) = round(PSO.speedLimit(2) + rand(1, SWS.m));  % 初始种群的速度
    end 

    bestResult = GetFuncResult(individual(1,:), SWS, RM);
    globalBest = bestResult;
    
    for iteration = 1:PSO.maxIteration
        for i = 1:PSO.populationSize
            
            result = GetFuncResult(individual(i, :), SWS, RM);
            if bestResult.fitness > result.fitness
                bestResult = result;     % 更新个体历史最佳
            end 
            v(i,:) = v(i,:) * PSO.inertness + PSO.learningFactor(1) * rand * (bestResult.individual - individual(i,:)) + PSO.learningFactor(2) * rand * (globalBest.individual - individual(i,:));% 速度更新
            %越界处理
            v(i, v(i, :) > PSO.speedLimit(2)) = PSO.speedLimit(2);
            v(i, v(i, :) < PSO.speedLimit(1)) = PSO.speedLimit(1);

            individual(i, :) = round(individual(i, :) + v(i, :));% 位置更新

            individual(i, individual(i, :) > PSO.limit(2)) = PSO.limit(2); 
            individual(i, individual(i, :) < PSO.limit(1)) = PSO.limit(1);

        end
        if globalBest.fitness > bestResult.fitness
             globalBest = bestResult;
        end

        [excel, image] = Record(iteration, bestResult, excel, image);
    end
end