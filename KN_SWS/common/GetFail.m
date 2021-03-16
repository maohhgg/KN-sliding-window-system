function [F, new] = GetFail(U, F, k)
    [row, col] = size(U);
    new = [];
    
    for i = 1:row
        if U(i, col) == k
            F = F + U(i, col-1);
        else
            new = [new; U(i,1:col)];
        end
    end

end