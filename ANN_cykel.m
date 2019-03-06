function [Out2] = ANN_cykel(TrainSet,TestSet,TrainRes,TestRes,Training,depth,width,iter,TrainFactor)




    %Sigmoid function
    sig = @(x) 1./(1 + exp(-x)); 


    
if (Training == 1)
    [TrainSize,n]= size(TrainSet);
     
    T=TrainRes;
   
%ANN parameters------------------------------------------------------------

%     %Dimensions 
%     depth=100;
%     width=5;
% 
%     %Traning factor
      %TrainFactor = 0.001; 
%     %Training iterations
%     iter = 10000; 

    %Initializations-------------------------------------------------------
    d1=ones(TrainSize,width,depth); %hidden layers

    %Initial weigths
    w1=2*rand(n,width) - 1; %Input layer to first hidden layer
    w2=2*rand(width,width,depth-1) - 1; %hidden layers
    w3=2*rand(width,1) - 1; %output layer

    %Initial delta_weights
    dw2=ones(width,width,depth-1); %hidden layers

    %Initial bias
    bias1 = 2*rand(width,depth) - 1; %hidden layers
    bias2 = 2*rand(1) - 1; %output layer

    %Initial delta_bias
    dbias1=ones(width,depth);

    %Initial output
    Out1=ones(TrainSize,width,depth); %hidden layer    


%Train ANN-----------------------------------------------------------------

    for i=1 : iter
    
        %Run ANN---------------------------------------------------------------

            %Multiply weights with input layer to first hidden layer
            tosig1=TrainSet*w1; %First hidden layers
            
            for j=1:width %Add bias
                tosig1(:,j)=tosig1(:,j)+bias1(j,1);
            end
            Out1(:,:,1)=sig(tosig1);

            %Multiply weights with hidden layer outputs
            for k=1:depth-1
                tosig2=Out1(:,:,k)*w2(:,:,k); %Hidden layers
                
                for j=1:width %Add bias
                    tosig2(:,j)=tosig2(:,j)+bias1(j,k+1); 
                end
                
                Out1(:,:,k+1)=sig(tosig2); %Sigmoid on hidden layers
            end

            %Multiply weights with hidden layer outputs and add bias
            tosig3=Out1(:,:,depth)*w3+bias2; %Output layer

            Out2=sig(tosig3); %Sigmoid on output layer

        %Backward propagation--------------------------------------------------

            %Output delta      
            d2=Out2.*(1-Out2).*(T-Out2); %Output layer

            d1(:,:,depth)= Out1(:,:,depth).*(1-Out1(:,:,depth)).*d2;
            
            for j=1:width
                d1(:,j,depth)=d1(:,j,depth)*w3(j);
            end

            if(depth > 1) 
                for j=1:depth-1                
                    d1(:,:,depth-j)=Out1(:,:,depth-j).*(1-Out1(:,:,depth-j)).*d1(:,:,depth+1-j)*w2(:,:,depth-j);                
                end
            end

            %Wights delta
            dw1=(TrainFactor.*TrainSet'*d1(:,:,1)); %First hidden layer

            for j=1:depth-1 %Hidden layers
                dw2(:,:,j)=TrainFactor*Out1(:,:,j)'*d1(:,:,j+1);
            end

            dw3=TrainFactor*Out1(:,:,depth)'*d2; %Output layer


            %Wights bias
            for j=1:depth %Hidden layers
                for k=1:width
                    dbias1(k,j)=TrainFactor.*(d1(:,k,j)'*ones(TrainSize,1));  
                end
            end

            dbias2=TrainFactor*d2'*ones(TrainSize,1);


        %Update----------------------------------------------------------------
            w1=w1+dw1;
            w2=w2+dw2;
            w3=w3+dw3;

            %bias
            bias1=bias1+dbias1;
            bias2=bias2+dbias2;
        %----------------------------------------------------------------------

    end
%         save('bias1','bias1');  
%         save('bias2','bias2'); 
%         save('w1','w1'); 
%         save('w2','w2'); 
%         save('w3','w3'); 
end
    
% if(Training ~= 1)
%     if exist('bias1.mat', 'file') == 2
%         load('bias1','bias1');
%     else
%     end
%     if exist('bias2.mat', 'file') == 2
%         load('bias2','bias2');
%     else
%     end
%     if exist('w1.mat', 'file') == 2
%         load('w1','w1');
%     else
%     end
%     if exist('w2.mat', 'file') == 2
%         load('w2','w2');
%     else
%     end
%     if exist('w3.mat', 'file') == 2
%         load('w3','w3');
%     else
%     end
% end 


%Prediction----------------------------------------------------------------


    [eval,~]= size(TestSet);
    Out1=ones(eval,width,depth); %hidden layer
    
    %Run ANN---------------------------------------------------------------

            %Multiply weights with input layer to first hidden layer
            tosig1=TestSet*w1; %First hidden layers
            
            for j=1:width %Add bias
                tosig1(:,j)=tosig1(:,j)+bias1(j,1);
            end
            Out1(:,:,1)=sig(tosig1);

            %Multiply weights with hidden layer outputs
            for k=1:depth-1
                tosig2=Out1(:,:,k)*w2(:,:,k); %Hidden layers
                
                for j=1:width %Add bias
                    tosig2(:,j)=tosig2(:,j)+bias1(j,k+1); 
                end
                
                Out1(:,:,k+1)=sig(tosig2); %Sigmoid on hidden layers
            end

            %Multiply weights with hidden layer outputs and add bias
            tosig3=Out1(:,:,depth)*w3+bias2; %Output layer

            Out2=sig(tosig3); %Sigmoid on output layer
  
end

