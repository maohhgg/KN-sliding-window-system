function SaveImages(images)

figure;

names = fieldnames(images);

for i = 1:length(names)
    field = string(names(i));
    plot(images.(field).x, images.(field).y)
    hold on;
end

xlabel('Iterations');
ylabel('Total Cost');
end