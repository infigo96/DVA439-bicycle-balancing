 v=8/3.6; % Changes depending on initial model speed
 A1=[0 0; 0 0];
 A2=[1 0; 0 1];
 A3=-inv(M)*(g*K0+v^2*K2);
 A4=-inv(M)*v*C1;
 A=[A1, A2; A3, A4];
 
 %B matrix
 B0=[[0; 0]; inv(M)*[0;1]]; 
 
 %B1 matrix
 B1=[[0; 0]; inv(M)*[1;0]]; 
 B=[B0 B1] 
 %C matrix
 C=[1 0 0 0; 0 1 0 0];
 
 %D matrix
 D=[0 0; 0 0];
 
 sys=ss(A,B,C,D);
 sys=tf([-1],[3 2])
 
 SysD=c2d(sys,0.005);
 
 