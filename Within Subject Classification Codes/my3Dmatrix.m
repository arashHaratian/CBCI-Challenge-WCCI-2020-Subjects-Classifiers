function [matrix] = my3Dmatrix(data)
% ******* crop trials from eeg ****
Fs = 512;
Ltr= 8 * Fs;
size_m = size(data);

pos = zeros(1,80);
c = 0;
c1 = 0;
for i = 1 : 4096 : size_m(1)
    c = c + 1;
    pos(1,c) = i;
end
for i = 1:size_m(1)/4096
    ind = pos(i):pos(i)+Ltr-1;
    trial = data(ind,:);
    c1 = c1+1;
    matrix(:,:,c1) = trial;  % all traials with label 1 are in the class_1
end
end