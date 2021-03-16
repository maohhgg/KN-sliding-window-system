function new = GetUnevenG(G, C, m)

    recreateG = cell(1, m);
    for i = 1:m
        recreateG{C(i)} = [recreateG{C(i)}; {G{i}}];
    end
    new = cell(1, m);
    
    for r = 1:m
        temp = recreateG{r};
        [row, ~] = size(temp);
        if row == 1
            new{r} = temp{1}';
        elseif row >= 2
            me = temp{1}';
            for index = 2:row
                [meRow, meCol] = size(me);
                t = temp{index}';
                [tRow, ~] = size(t);
                u = zeros(meRow*tRow, meCol);
                z = 1;
                for x = 1:meRow
                    for j = 1:tRow
                        u(z,:) = [(me(x,1)+t(j,1)) me(x,2)*t(j,2)];
                        z = z + 1;
                    end
                end
                me = u;
            end
            me = sortrows(me);
            [mc, ~] = size(me);

            while i < mc
                if me(i,1) == me(i+1,1)
                    me(i,2) = me(i,2) + me(i+1,2);
                    me(i+1, :) = [];
                    mc = mc - 1;
                else
                    i = i + 1;
                end
            end
            new{r} = me;
        else
            new{r} = [0;1]';
        end
        
    end
    
end