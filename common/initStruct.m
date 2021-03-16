function [excel, image] = initStruct(config, SWS)
    excel.fitValue  = zeros(1, config.maxIteration);
    excel.sysAva    = zeros(1, config.maxIteration);
    excel.string    = zeros(config.maxIteration, SWS.m);
    excel.V         = zeros(config.maxIteration, SWS.m); 
    excel.TInd      = zeros(config.maxIteration, SWS.m);
    image.y         = zeros(1, config.maxIteration);
end
