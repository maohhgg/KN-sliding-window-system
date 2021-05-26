function [excel, image] = Record(i, result, excel, image, flag)

    fprintf('\t%s generation: %d\n', flag, i);
    fprintf('\tWhen %s, get the best individual', join(string(result.position)));
    fprintf('cost = %04.0f R = %04.4f \n', result.fitness, result.availability);
    
    excel.fitValue(i)   = result.fitness;
    excel.sysAva(i)     = result.availability;
    excel.V(i, :)       = result.position;
    excel.string(i, :)  = result.individual;
    excel.TInd(i, :)    = result.intervalIndex;
    
    image.x(i) = i;
    image.y(i) = result.fitness;
    if i > 1 && result.fitness > image.y(i - 1)
        image.y(i) = image.y(i - 1);
    end
end