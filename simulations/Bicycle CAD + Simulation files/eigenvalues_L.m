%%
%(Ao ? LoCo)
L0=[1.557*10^3 ; 5.386*10^5; 4.148*10^7]
eig(Ao-L0*Co)
%%
%s2 + (?1 + ¯c11)s + (?0 + k¯11) = 0
% Alp0=22.412;
% Alp1=5.367; 

Alp0=22.812 %22.812;%Niklas kladd
Alp1=4.367 %4.367; %Niklas kladd
% tf([1 (Alp1+Cline(1,1)) (Alp0+Kline(1,1))],[1]) 
tf([1],[1 (Alp1+Cline(1,1)) (Alp0+Kline(1,1))])
pzmap(tf([1],[1 (Alp1+Cline(1,1)) (Alp0+Kline(1,1))]))

%%
syms s
Alp0=15.812 %22.812;%Niklas kladd
Alp1=0
tf([1],[1 (Alp1+Cline(1,1)) (Alp0+Kline(1,1))],0.0005)
pzmap(tf([1],[1 (Alp1+Cline(1,1)) (Alp0+Kline(1,1))],0.0005))

%%
Ai=[0 1 0 0 0 0; -Kline(2,2) -Cline(2,2) 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 0 0 0 0 0];
Li=[1.099*10^2; 4.693*10^3; 1.094*10^5; 0.22*10^5; 0.22*10^4; 0.3*10^2];
Ci=[1 0 0 0 0 0];
eig(Ai-Li*Ci)
%%
% s2 + (?1 + ¯c22)s + (?0 + k¯22) = 0
% gam0=448.438;
% gam1=41.538;

gam0=448.438; %Niklas kladd
gam1=38.538; %Niklas kladd
pzmap(tf([1],[1 (gam1+Cline(2,2)) (gam0+Kline(2,2))]))
%%
syms s
gam0=30; %Niklas kladd
gam1=10;
pzmap(tf([1],[1 (gam1+Cline(2,2)) (gam0+Kline(2,2))],0.005))

%%
eigenV=[-60.065; -26.038+33.566j; -26.038-33.566j; -0.051 + 0.088j; -0.051-0.088j; -0.101]
% Legein=place(Ai,Ci',eigenV);
%%

%!!!!!!!SPARAS!!!!!!!
syms s
Cs0=C(1,:);
vvary=linspace(0,10,100);
 B=[[0; 0]; inv(M)*[0;1]]; 
 
 %B1 matrix
  B1=[[0; 0]; inv(M)*[1;0]]; 
Bu=B+B1;
for i=1:100

 A1T=[0 0; 0 0];
 A2T=[1 0; 0 1];
 A3T=-inv(M)*(g*K0+vvary(i)^2*K2);
 A4T=-inv(M)*vvary(i)*C1;
 AT=[A1T, A2T; A3T, A4T];
 
 sys= ss(AT,Bu,Cs0, [0]);
% Gs=Cs0*inv(s*eye(4)-AT)*B

 systf=tf(sys);
 [~,Z(:,i)]=pzmap(systf);

end

plot(vvary,Z(1,:), vvary, Z(2,:));
grid on





%% 

eigIn = eig(sysDi.A-sysDi.B(:,4)*sysDi.C)
abs(eigIn)
eigOut = eig(sysDo.A-sysDo.B(:,3)*sysDo.C) 
zplane(eigOut)
% [0.2 0.3 0.4]
% Lo=place(sysDo.A',sysDo.C',[0.5 0.3+0.4i 0.3-0.4i])


