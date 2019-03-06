clc
clear
%% Updated with data from the new more detailed CAD model
mtot=22.2390; %Total mass
h=0; %Height of bike
w=1.0805; %Wheel base
c=0.08694; %Trail
g=9.82; %Gravity
lambda=deg2rad(18); %Head angle
rR=0.349; %Rear wheel radius
mR=6.780; %Rear wheel mass
IRxx=0.2444; %Rear wheel inertia xx
IRyy=0.4850; %Rear wheel inertia yy
xB=0.7973; %Back frame centre of mass with repsect to O
zB=-0.6330; %Back frame centre of mass with repsect to O
mB=10.510; %Back frame mass
IBxx=0.4521; %Mass moments of inertia for back frame
IByy=1.0919; %Mass moments of inertia for back frame
IBzz=0.6655; %Mass moments of inertia for back frame
IBxz=-0.3845; %Mass moments of inertia for back frame, (Maby wrong)
xH=1.1740; %Front frame centre of mass with repsect to O
zH=-0.7320; %Front frame centre of mass with repsect to O
mH=3.110; %Front frame mass
IHxx=0.1154; %Mass moments of inertia for front frame
IHyy=0.1193; %Mass moments of inertia for front frame
IHzz=0.0255; %Mass moments of inertia for front frame
IHxz=0.0367; %Mass moments of inertia for front frame
rF=0.349;%Front wheel radius
mF=1.990;%Front wheel mass
IFxx=0.1004; %Front wheel inertia xx
IFyy=0.2003; %Front wheel inertia yy 

%% Equations
%Taken from http://ruina.tam.cornell.edu/research/topics/bicycle_mechanics/*FinalBicyclePaperv45wAppendix.pdf
%See appendix A


xT=(xB*mB + xH*mH + w*mF)/mtot; %A2
zT=(-rR*mR + zB*mB + zH*mH - rF*mF)/mtot; %A3
ITxx=IRxx + IBxx + IHxx + IFxx + mR*rR^2 + mB*zB^2 + mH*zH^2 + mF*rF^2; %A4
ITxz=IBxz + IHxz - mB*xB*zB - mH*xH*zH + mF*w*rF; %A5
IRzz=IRxx; %A6
IFzz=IFxx; %A6
ITzz=IRzz + IBzz + IHzz + IFzz + mB*xB^2 + mH*xH^2+mF*w^2; %A7
mA=mH + mF; %A8
xA=(xH*mH + w*mF)/mA; %A9
zA=(zH*mH -rF*mF)/mA; %A9
IAxx=IHxx + IFxx + mH*(zH - zA)^2 + mF*(rF + zA)^2; %A10
IAxz=IHxz - mH*(xH - xA)*(zH - zA) + mF*(w-xA)*(rF+zA); %A11
IAzz=IHzz + IFzz + mH*(xH - xA)^2 + mF*(w - xA)^2; %A12
uA=(xA - w - c)*cos(lambda) - zA*sin(lambda); %A13
IAlambdalambda=mA*uA^2 + IAxx*sin(lambda)^2 + 2*IAxz*sin(lambda)*cos(lambda) + IAzz*cos(lambda)^2;%A14
IAlambdax=-mA*uA*zA + IAxx*sin(lambda) + IAxz*cos(lambda); %A15
IAlambdaz=mA*uA*xA + IAxz*sin(lambda) + IAzz*cos(lambda); %A16
my=(c/w)*cos(lambda); %A17
SR=IRyy/rR; %A18
SF=IFyy/rF; %A18
ST=SR + SF; %A18
SA=mA*uA + my*mtot*xT; %A19
Mfifi=ITxx; %A20
Mfidelta=IAlambdax + my*ITxz; %A20
Mdeltadelta=IAlambdalambda + 2*my*IAlambdaz + my^2*ITzz; %A20
M=[Mfifi Mfidelta; Mfidelta Mdeltadelta]; %A21r
K0fifi=mtot*zT; %A22
K0fidelta=-SA; %A22
K0deltadelta=-SA*sin(lambda); %A22
K0=[K0fifi K0fidelta; K0fidelta K0deltadelta]; %A23
K2fifi=0; %A24
K2fidelta=((ST - mtot*zT)/w)*cos(lambda); %A24
K2deltafi=0; %A24
K2deltadelta=((SA + SF*sin(lambda))/w)*cos(lambda); %A24
K2=[K2fifi K2fidelta; K2deltafi K2deltadelta]; %A25
C1fifi=0; %A26
C1fidelta=my*ST + SF*cos(lambda) + (ITxz/w)*cos(lambda) - my*mtot*zT; %A26
C1deltafi=-(my*ST + SF*cos(lambda)); %A26
C1deltadelta=(IAlambdaz/w)*cos(lambda) + my*(SA + (ITzz/w)*cos(lambda)); %A26
C1=[C1fifi C1fidelta; C1deltafi C1deltadelta]; %A27
 %C=v*C1;
 
 
 %%
 %A matrix
 v=8/3.6; % Changes depending on initial model speed
 A1=[0 0; 0 0];
 A2=[1 0; 0 1];
 A3=-inv(M)*(g*K0+v^2*K2);
 A4=-inv(M)*v*C1;
 A=[A1, A2; A3, A4];
 
 %B matrix
 B=[[0; 0]; inv(M)*[0;1]]; 
 
 %B1 matrix
 B1=[[0; 0]; inv(M)*[1;0]]; 
  
 %C matrix
 C=[1 0 0 0; 0 1 0 0];
 
 %D matrix
 D=[0; 0];
 
 %% Lean angle control loop
 Cline=v*inv(M)*C1;
 Kline=inv(M)*(g*K0+v^2*K2);
 Mline=inv(M);

%Outer control loop - stabilizing controller

A0=[0 1 0; -Kline(1,1) -Cline(1,1) 1; 0 0 0]; %d 
B0=[0; 1; 0]; %f
E0=[0; Mline(1,2); 0]; %f
F0=[0; 0; 1]; %f
C0=[1 0 0]; %f

%x1(t)=fi(t); <-lean angle 
%x2(t)=dfi(t); <-lean angle velocity
%x3(t)=xi_fi(t); <-lean angle disturbance
 
%disturbace observer for lean (xi_fi(t))

