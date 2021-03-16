function [excel, image] = RecordLog(iteration, fitness, index, best, excel, image)

        global pop;
        
        fprintf('\tgeneration: %d\n', iteration);
        fprintf('\tWhen %s, get the best individual', join(string(best.V)));
        fprintf('\tcost = %04.0f, R = %04.4f \n', best.fitness, best.systemAvailability);
    
%         [~, fitSize] = size(fitness);
        
        image.y(iteration) = best.fitness;
        if iteration > 1 && best.fitness > image.y(iteration - 1)
            image.y(iteration) = image.y(iteration - 1);
        end

        excel.fitValue(iteration)   = best.fitness;
        excel.sysAva(iteration)     = best.systemAvailability;
        excel.V(iteration, :)       = best.V;
        excel.string(iteration, :)  = pop(index(1),:);
        excel.TInd(iteration, :)    = best.intervalIndex;
end