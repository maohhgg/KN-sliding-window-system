% parameters U r
function new = DuplicateU(U, r) 
    new = U;
    [uRow, uCol] = size(new);
    
    if uCol > (r + 2)  
        new(:, 1) = [];   i = 1;
        newCol = uCol - 1;
        while i < uRow
            if new(i, 1:newCol-2) == new(i+1, 1:newCol-2)
                new(i, newCol-1) = new(i, newCol-1) + new(i+1, newCol-1);
                new(i+1, :) = [];
                uRow = uRow - 1;
            else
                i = i + 1;
            end
        end
    end

end

