    
function ApplyGaussMixEM
    
    % read image with 3 channels!
    [file, path, image, img_size] = read_image('inputEx5.jpg');
 
    % Number of dimensions
    n_dims = img_size(3);
    
    %--------------------------------------------------------------------------
    % number of desired components (clusters)
    % vary this parameter to find an appropriate value for the input
    % image (Task )!!!
    n_comp = 6;
    %--------------------------------------------------------------------------
    
%     When the cluster number is 6, the white and blue parts are recognized
%     very well, but the red, orange and yellow parts are not good
%     but when the cluster number is larger than 8, there will be some points
%     which should belong to the same part but be catogorized to different
%     clusters
%     when the cluster number is smaller than 5, many different color parts
%     will be set the same color cluster
%     So we think the optimized number should be 6


    
    % reshaping of vectors for input of EM
    trainVect = reshape(image, [img_size(1)*img_size(2),n_dims] );
    
    % sample the vectors to reduce amount of data
    desired_number = 1000;
    step = img_size(1)*img_size(2) / desired_number; 
    indices = round(1:step:img_size(1)*img_size(2));
    trainVect = trainVect(indices,:);
    
    % filter out edge points (lead to covariance-matrices which are not invertible)
    s_t = sum(trainVect,2);
    test = find(s_t ~= 3.0);
    trainVect = trainVect(test, :);
    
    % GaussMixModel mittels EM lernen...
    model = LearnGaussMixModel(trainVect, n_comp);

    % classify pixels
    ClassImg = ClassifyImage(model, image);

    % visualize result
    figure(2); 
    subplot(1,2,1), imshow(image), title('Original Image');
    subplot(1,2,2), imshow(ClassImg,[]), colormap(jet), title('Classification Result');
end



%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% PASTE HERE YOUR IMPLEMENTED FUNCTION CalcLnVectorProb (TASK B.a)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function LnVectorProb = CalcLnVectorProb(model, trainVect)

% IMPLEMENT THIS FUNCTION (TASK A.a)
    LnVectorProb = [];
    weights = model.weight;
    %iterate trough all clusters
    for ci = 1:size(weights,1)
        
        weightC = model.weight(ci);
        meanC = model.mean(ci,:);
        SigmaC = squeeze(model.covar(ci,:,:));
        probility =[];
   
        for feature = 1:size(trainVect,1)
            
            x = trainVect(feature,:);            
            logProb = log(weightC)-(1/2)*(log(det(SigmaC))+(x'-meanC')'*inv(SigmaC)*(x'-meanC'));
            probility = [probility,logProb];
            
        end        
        LnVectorProb = [LnVectorProb;probility];        
    end



end


%--------------------------------------------------------------------------
function  ClassImg = ClassifyImage(model, image)
    
    % image dimensions
    s = size(image);
   
    % reshaping of feature vectors
    FeatureVects = reshape(image, [s(1)*s(2),s(3)]);
    
    % probability of all vectors for all clusters (classes)
    LnVectorProb = CalcLnVectorProb(model, FeatureVects);  
    
    % get the maximum value --> this is the corresponding class membership
    [max_values, max_pos]  = max(LnVectorProb,[],1); 
    
    % reshape vector to result array
    ClassImg = uint8(reshape(max_pos, s(1:2)));
end

%--------------------------------------------------------------------------
function [file, path, image, s] = read_image(text)

    % open a dialogue to pick afile
    [file, path] = uigetfile('*.*', text);
 
    % read image and convert to double [0,...,1]
    image = mat2gray( imread([path,file]) );
    
    % determine size/dimensions of image
    s = size(image);
end