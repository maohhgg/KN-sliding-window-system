function SaveExcel(store, SWS, RM)

    names = fieldnames(store);

    for i = 1:length(names)
        field = string(names(i));
        
        project = getfield(store, field);

        [~, maxIteration] = size(project.fitValue);

        fileName = sprintf('%s_Astar_%03.2f_%s_%d.xls', field, RM.AStar, SWS.type, maxIteration);
        xlswrite(fileName, project.fitValue', 'Sheet1', sprintf('A1:A%d', maxIteration))
        xlswrite(fileName, project.sysAva', 'Sheet1',  sprintf('C1:C%d', maxIteration))
        xlswrite(fileName, project.string, 'Sheet2', sprintf('A1:J%d', maxIteration))
        xlswrite(fileName, project.V, 'Sheet3', sprintf('A1:J%d', maxIteration))
        xlswrite(fileName, project.TInd, 'Sheet4', sprintf('A1:J%d', maxIteration))
    end

end

