function[matrix2D] = my2Dmatrix(input_data)
Fs = 512;
size_m = size(input_data);

data = squeeze(input_data(1,:,:));
data = data';
matrix2D = data;

for trial= 2:size_m(1)
    data = squeeze(input_data(trial, :, :));
    data = data';
    matrix2D = [matrix2D; data];
end
end
