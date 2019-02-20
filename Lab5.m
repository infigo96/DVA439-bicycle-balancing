clc;
clear;
toPlot = 1; %plot the first history of the cart and rod
train = 0; %If 1 random starting position and training. If 0 [0 0 0 0] and no training
startState = [0 0 0 0];
learnRate = 0.8;
toPause = 0;

if(train == 0)
    toPause = 0.002;
end

x3 = -pi/15:pi/60:pi/15; %theta. The angle of the pendelum.  
x4 = -pi/4:pi/8:pi/4; %theta dot. The angle velocity of the pendelum
x1 = -2.4:1.2:2.4; %x pos. The position of the cart
x2 = -2:1:2; %x dist dot. The speed of the cart

actions = [-10, 10]; % Either force backward or forward
maxEpisodes = 10000000000; %Max episodes of attempts


%----Create all the states combinations
    index = 1;
 for i=1:length(x1)   
    for j=1:length(x2)
        for k = 1:length(x3)
            for l = 1:length(x4)
                states(index,1)=x1(i);
                states(index,2)=x2(j);
                states(index,3)=x3(k);
                states(index,4)=x4(l);
                index=index+1;
            end
        end
    end
 end


 timesReached = zeros(length(states),2);
 Q = zeros(length(states), 2);
 if exist('SavedQ.mat', 'file') == 2
    load('SavedQ','Q')
 end
   %Initalize starting values
 currentState = startState;
 
 % Set up the pendulum plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

panel = figure;
panel.Color = [1 1 1];

hold on
 % Axis for the pendulum animation
f = plot(0,0,'b','LineWidth',6); % Pendulum stick
axPend = f.Parent;
axPend.XTick = []; % No axis stuff to see
axPend.YTick = [];
axPend.Visible = 'off';
axPend.Clipping = 'off';
axis equal
axis([-1.2679 1.2679 -1 1]); %bottom line
line([-2.4 2.4],[0 0],'color', 'red')
g  = plot(0.001,0,'.k','MarkerSize',30); % Pendulum axis point
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

for episode = 1:maxEpisodes
    if train == 0
        currentState = startState;
    elseif train == 1
        currentState = [-1.2 + (2.4)*rand, 0 ,-pi/40 + (pi/20)*rand, 0];
    end
    index = 0;

    while(abs(currentState(1)) <= 2.4 && abs(currentState(3))<=pi/15)
       index = index + 1;
    
           set(f,'XData',[currentState(1) currentState(1)+ sin(currentState(3))]); %x pos of stick
           set(g,'XData',currentState(1)); %x pos of dot
           set(f,'YData',[0 cos(currentState(3))]); %y pos of stick
 
    
   [~,stateIndex] = min(sum((states - repmat(currentState,[size(states,1),1])).^2,2)); %closest state as described by our state
   
   if (rand()>0.1 || ~train)
        [~,actionIndex] = max(Q(stateIndex,:)); % Calculates the next action to do from Qmatrix
   else
       if(rand >= 0.5)
       actionIndex = 1;
       else
       actionIndex = 2;
       end
   end
 

       nextState = SimulatePendel(actions(actionIndex), currentState(1), currentState(2), currentState(3), currentState(4)); 

       [~,nextStateIndex] = min(sum((states - repmat(nextState,[size(states,1),1])).^2,2)); %closest state as described by our state
       if(train == 1)
           timesReached(stateIndex,actionIndex) = timesReached(stateIndex,actionIndex) + 1;
           Q(stateIndex,actionIndex) = Q(stateIndex,actionIndex) + 1/timesReached(stateIndex,actionIndex) * (0.9*max(Q(nextStateIndex,:)) - Q(stateIndex,actionIndex));
          
           if(abs(nextState(1)) > 2.4 || abs(nextState(3))>pi/15)
               Q(stateIndex,actionIndex) = Q(stateIndex,actionIndex)-1/timesReached(stateIndex,actionIndex);
          end
       end

       currentState = nextState;
       clc;
       disp('%%%%%%%%%%%%%%%%%%%%%%%%%%');
       disp(episode)
       disp('cart distance is: ');
       disp(currentState(1));
       disp('cart speed is: ');
       disp(currentState(2));
       disp('Angle is: ');
       %disp(currentState(3));
       disp(180/pi*currentState(3));
       disp('Angle velocity is: ');
       %disp(180/pi*currentState(4));
       disp(currentState(4));
       disp('Survival time');
       disp(index*0.02);
        if (abs(currentState(1)) <= 2.4 && abs(currentState(3))<=pi/15 && index < 20000 )
                pause(toPause)
        end
        if toPlot == 1
            grap(index,1) = index*0.02;
            grap(index,2) = currentState(1);
            grap(index,3) = currentState(3)*180/pi;
        end
    end
    if (mod(episode, 20) == 0 && train == 1)
        save('SavedQ','Q')
    end
    if toPlot == 1
       figure;
       plot(grap(:,2),grap(:,1));
       ylabel("time (s)");
       xlabel("Cart position from center (m)");
       xlim([-2.4,2.4]);
       title("Cart position");
       figure;
       plot(grap(:,3),grap(:,1));
       ylabel("time (s)");
       xlabel("Rod angle (Degrees)");
       xlim([-12,12]);
       title("Rod angle");
       toPlot = 0;
    end

end  % SimulatePendel(1, 1, 1, 1, 1)