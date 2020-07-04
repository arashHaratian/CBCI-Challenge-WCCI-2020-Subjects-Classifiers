function [class_1, class_2] = myclassseparator(data, Labels)
% ******* crop trials from eeg ****
group= Labels;
Fs = 512;
Ltr= 8 * Fs;
c1 = 0;
c2 = 0;
size_m = size(data);

pos = zeros(1,size_m(1)/4096);
c = 0;
for i = 1 : 4096 : size_m(1)
    c = c + 1;
    pos(1,c) = i; 
end
for i = 1:length(group)       
    ind = pos(i):pos(i)+Ltr-1;
    trial = data(ind,:);
    if group(i) == 1
        c1 = c1+1;
        class_1(:,:,c1) = trial;  % all traials with label 1 are in the class_1
    elseif group(i) == 2
        c2 = c2+1;
        class_2(:,:,c2) = trial;  %  all traials with label 2 are in the class_2
    end
end
end