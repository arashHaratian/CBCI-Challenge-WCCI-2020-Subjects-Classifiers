function [extractedfeatures] = myfeatures(W, data, type)
for i = 1:size(data,3)
    x = data(:,:,i)';
    y = W'*x; 
    
    if type == 'var'
        extractedfeatures(:,i) = var(y');
    elseif type == 'log'
        extractedfeatures(:,i) = log10(var(y')/sum(var(y')));
    end
end
end