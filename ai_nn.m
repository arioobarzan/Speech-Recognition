% تنظیمات اولیه شبکه
inputLayerSize = inputSize;
numClasses = numel(categories(labels));

% طراحی معماری شبکه
layers = [
    sequenceInputLayer(inputLayerSize)
    fullyConnectedLayer(128)
    reluLayer
    fullyConnectedLayer(128)
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

% تنظیمات آموزش
options = trainingOptions('adam', ...
    'MaxEpochs', 30, ...
    'MiniBatchSize', 16, ...
    'InitialLearnRate', 1e-3, ...
    'Plots', 'training-progress');

% آموزش شبکه
net = trainNetwork(data, labels, layers, options);
