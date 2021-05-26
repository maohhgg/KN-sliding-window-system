function R = Reliability(k, r, m, W, G, C, type)
    F = 0; U = [];
    EP = {
        [0 10 15;1-G(1) 0.1*G(1) 0.9*G(1)];
        [0 10 15;1-G(2) 0.3*G(2) 0.7*G(2)];
        [0 10 15;1-G(3) 0.2*G(3) 0.8*G(3)];
        [0 15 20;1-G(4) 0.3*G(4) 0.7*G(4)];
        [0 15 20;1-G(5) 0.1*G(5) 0.9*G(5)];
        [0 15 20;1-G(6) 0.2*G(6) 0.8*G(6)];
        [0 15 25;1-G(7) 0.1*G(7) 0.9*G(7)];
        [0 20 25;1-G(8) 0.3*G(8) 0.7*G(8)];
        [0 20 25;1-G(9) 0.2*G(9) 0.8*G(9)];
        [0 25 35;1-G(10) 0.1*G(10) 0.9*G(10)];
    };
    switch type
        case 'even'
            recreateG = GetEvenG(EP, C, m);
        case 'uneven'
            recreateG = GetUnevenG(EP, C, m); 
    end

    for j = 1:m
        U = GenerateG(recreateG{j}, U);
        if j >= r
            if j > r                                % When sliding to the second group, start to remove the like term
                U = DuplicateU(U, r);
            end
            [row, col] = size(U);
            for i = 1:row                           % 第一组开始计算
                W_ = W(1, 2);GR = W(1, 1);
                if rand() <= W(2, 1)
                    W_ = W(2, 2);GR = W(2, 1);
                end
                if sum(U(i, 1:col-2)) < W_
                    U(i, col) = U(i, col) + 1;
                    U(i, col-1) = U(i, col-1) * GR;
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