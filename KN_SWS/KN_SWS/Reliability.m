function R = Reliability(G ,m ,C, r, W, k, type)
    F = 0; U = [0 1 0];
    
    switch type
        case 'even'
            recreateG = GetEvenG(G, C, m);
        case 'uneven'
            recreateG = GetUnevenG(G, C, m); 
    end
    
    for j = 1:m
        U = GenerateG(recreateG{j}, U);
        if j >= r

            if j > r                                % When sliding to the second group, start to remove the like term
                U = DuplicateU(U, r);
            end
            [row, col] = size(U);
            for i = 1:row                           % 第一组开始计算 
                if sum(U(i, 1:col-2)) < W
                    U(i, col) = U(i, col) + 1;
                end
            end
        end  

        if j >= k + r - 1
            [F, U] = GetFail(U, F, k); 
        end
        if isempty(U)
            F = 1;
            break
        end
    end
    
    R = 1 - F;
    clear U;
    clear recreateG;
    clear F;
end