function new = GetEvenG(G, C, m)
    new = cell(1, m);
    for i = 1:m
        %将ME的状态矩阵转置
        new{i} = G{C(i)}';
    end
end