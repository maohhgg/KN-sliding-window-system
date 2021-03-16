function individual = GenPosition(pop)
    individual = pop;
    temp1 = randi([1 10]);
    while 1
        temp2 = randi([1 10]);
        if temp2 ~= temp1
            break;
        end
    end
    location1 = min(temp1,temp2);
    location2 = max(temp1,temp2);
    temp = individual(location1);
    individual(location1) = individual(location2);
    individual(location2) = temp;
end
