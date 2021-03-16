function new = GenerateG(G ,U)
    % U是前面col-2列（除了最后两列的前面全部列）表示 performance，第col-1列（倒数第二列）表示对应概率
    % 第col列（最后一列）表示 d
    UCopy = U;
    [URow,UCol] = size(UCopy);
    
    ME = G;
    UCopy = U;

    [MERow, ~] = size(ME);  % ME显然只有两列，因此就不使用变量col了

    if URow == 0
        %如果是第一次迭代，那么此时的U应该直接是ME1的状态
        new = [ME(:,:) zeros(1, MERow)'];
    else
        %初始化一个新的矩阵，new存放计算结果
        %行数，即所有的状态总数，应当等于ME的状态总数乘以上一个U的状态总数 即 MERow*URow
        %至于列数
        %如果是论文里 j<=r的情况
        %那么列数显然应当等于上一个U的列数+1

        new = zeros(MERow*URow, UCol+1);
        index = 1;

        for i = 1:MERow
            for j = 1:URow
                %将[上一个U的状态，ME的状态，概率相乘]这个行向量 放入 new
                new(index,:) = [UCopy(j, 1:UCol-2) ME(i,1) ME(i,2)*UCopy(j,UCol-1), UCopy(j,UCol)];
                index = index + 1;
            end
        end
    end

    clear UCopy;
    clear URow;
    clear UCol;
    clear ME;
end