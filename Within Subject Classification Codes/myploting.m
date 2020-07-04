function[] = myploting(featuretrain1, featuretrain2, featuretest1,featuretest2)
plot(featuretrain1(1,:),featuretrain1(2,:),'rs',...
    'linewidth',2,'markersize',8);
hold on
plot(featuretrain2(1,:),featuretrain2(2,:),'bo',...
    'linewidth',2,'markersize',8);

figure
plot(featuretest1(1,:),featuretest1(2,:),'rs',...
    'linewidth',2,'markersize',8);
hold on
plot(featuretest2(1,:),featuretest2(2,:),'bo',...
    'linewidth',2,'markersize',8);
end