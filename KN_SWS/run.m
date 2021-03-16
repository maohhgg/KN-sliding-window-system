addpath(genpath(pwd)); 
clear; clc;

G = {
    [0 2 6;0.03 0.22 0.75];
    [0 1 3 4;0.1 0.1 0.4 0.4];
    [0 6;0.17 0.83];
    [0 3 5 6;0.05 0.25 0.4 0.3];
    [0 1 2 4 5;0.08 0.20 0.15 0.45 0.12];
    [0 4 5;0.01 0.22 0.77];
    [0 3 4 5;0.2 0.1 0.1 0.6];
    [0 4 6;0.05 0.25 0.70];
    [0 3 4 5;0.2 0.1 0.15 0.55];
    [0 2 6;0.05 0.25 0.70]
};

r = 5;  % Number of MEs in the group of consecutive MEs
W = 15;  % Minimum allowable cumulative performance for any group of r consecutive MEs
k = 2;  % Maximal allowable number of failed groups of r consecutive MEs in the system.


% C = [7,4,8,2,6,10,9,3,1,5];
% C = [1,2,3,4,5,6,7,8,9,10]; 
C = [2,3,4,4,6,7,7,8,8,10];
[~, m] = size(C);           % the number of MEs
% 
% disp(Reliability(G, m, C, r, W, k, 'uneven'));


max = 5; % max 
one = cell(max-r, 1);
i = 1;
for k = k : max
    R = 1; RS = []; WS = []; W = 0;
    while R > 0
        R = Reliability(G, m, C, r, W, k, 'uneven');
        RS(end+1) = R; WS(end+1) = W;
        W = W + 1;
    end
    one{i,1} = RS;
    one{i,2} = WS;
    i = i + 1;
end

figure;
ylabel('R');xlabel('W');
[len, ~] = size(one); str = cell(len, 1);
for i = 1:len
    stairs(one{i,2}, one{i,1});    hold on;
    str{i} = sprintf('k = %d, r = %d', k-len+i, r);
end
legend(str);