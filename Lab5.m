close all;
clc;
clear;
toPlot = 1; %plot the first history of the cart and rod
traindum = 0; %If 1 random starting position and trainduming. If 0 [0 0 0 0] and no trainduming
startState = [0 0 0 0];
learnRate = 0.8;
toPause = 0;

if(traindum == 0)
    toPause = 0.002;
end

x3 = -pi/15:pi/60:pi/15; %theta. The angle of the pendelum.  
x4 = -pi/4:pi/8:pi/4; %theta dot. The angle velocity of the pendelum
x1 = -2.4:1.2:2.4; %x pos. The position of the cart
x2 = -2:1:2; %x dist dot. The speed of the cart

actions = [-10, 10]; % Either force backward or forward
maxEpisodes = 1; %Max episodes of attempts



 
 %if exist('SavedQ.mat', 'file') == 2
 %   load('SavedQ','Q')
 %end
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
TrSet = {};
Tripplet = [];
for example = 1:200
    currentState = startState;
    TrSet{1, example} = [currentState];
    TrSet{2, example} = [0];

    while(abs(currentState(1)) <= 2.4 && abs(currentState(3))<=pi/15)
        action = 10*round(2*rand) + 10;
        nextState = SimulatePendel(action + 4*rand-2, currentState(1), currentState(2), currentState(3), currentState(4));
        TrSet{1, example} = [TrSet{1, example} ; nextState];
        TrSet{2, example} = [TrSet{2, example}; action];
        currentState = nextState;
    end
    cost = (abs(TrSet{1,example}(:,3)) > pi/20 | (abs(TrSet{1,example}(:,1)) > 2));
    Tripplet = [Tripplet; [TrSet{1,example}(1:end-1,:) TrSet{2,example}(2:end,:) cost(2:end)]];
end
QNeur;
for episode = 1:maxEpisodes
    if traindum == 0
        currentState = startState;
    elseif traindum == 1
        currentState = [-1.2 + (2.4)*rand, 0 ,-pi/40 + (pi/20)*rand, 0];
    end
    index = 0;

    while(abs(currentState(1)) <= 2.4 && abs(currentState(3))<=pi/15)
       index = index + 1;
    
           set(f,'XData',[currentState(1) currentState(1)+ sin(currentState(3))]); %x pos of stick
           set(g,'XData',currentState(1)); %x pos of dot
           set(f,'YData',[0 cos(currentState(3))]); %y pos of stick
 
        %%%%%%%%%%%%%%%%%%%%%
        %Simulate
        %%%%%%%%%%%%%%%%%%%%%
        Q1 = net([currentState 10]');
        Q3 = net([currentState 0]');
        Q2 = net([currentState -10]');
        if(Q2 > Q1 && Q3 > Q1)
            action = 10;
        elseif(Q1 > Q2 && Q3 > Q2)
            action = -10;
        else
            action = 0;
        end
        nextState = SimulatePendel(action rand -0.5, currentState(1), currentState(2), currentState(3), currentState(4)); 
          
        %%%%%%%%%%%%%%%%%%%%%%
        %traindum on result
        %%%%%%%%%%%%%%%%%%%%%%
       
       
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
    if (mod(episode, 20) == 0 && traindum == 1)
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