%%
J = 0.0728;
b = 0.0;
K = 0.0273;
R = 0.33;
L = 0.000103;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
D = 0;
state = ss(A,B,C,D);

%%
% Adams / MATLAB Interface - Release 2018.1.0
global ADAMS_sysdir; % used by setup_rtw_for_adams.m
global ADAMS_host; % used by start_adams_daemon.m
machine=computer;
datestr(now)
if strcmp(machine, 'GLNXA64')
   arch = 'linux64';
elseif strcmp(machine, 'PCWIN64')
   arch = 'win64';
else
   disp( '%%% Error : Platform unknown or unsupported by Adams Controls.' ) ;
   arch = 'unknown_or_unsupported';
   return
end
   [flag, topdir]=system('adams2018_1_SE -top');
if flag == 0
  temp_str=strcat(topdir, '/controls/', arch);
  addpath(temp_str)
  temp_str=strcat(topdir, '/controls/', 'matlab');
  addpath(temp_str)
  temp_str=strcat(topdir, '/controls/', 'utils');
  addpath(temp_str)
  ADAMS_sysdir = strcat(topdir, '');
else
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2018_1\controls/win64' ) ;
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2018_1\controls/matlab' ) ;
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2018_1\controls/utils' ) ;
  ADAMS_sysdir = 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2018_1\' ;
end
ADAMS_exec = '' ;
ADAMS_host = 'DESKTOP-F3FKN9V.mdh.se' ;
ADAMS_cwd ='C:\Users\gct14001\Documents\Latest DECEMBER Bike Model\Simulation Files'  ;
ADAMS_prefix = 'Nonlinear_Torque_15km' ;
ADAMS_static = 'no' ;
ADAMS_solver_type = 'C++' ;
ADAMS_version = '2018_1_SE' ;
if exist([ADAMS_prefix,'.adm']) == 0
   disp( ' ' ) ;
   disp( '%%% Warning : missing Adams plant model file(.adm) for Co-simulation or Function Evaluation.' ) ;
   disp( '%%% If necessary, please re-export model files or copy the exported plant model files into the' ) ;
   disp( '%%% working directory.  You may disregard this warning if the Co-simulation/Function Evaluation' ) ;
   disp( '%%% is TCP/IP-based (running Adams on another machine), or if setting up MATLAB/Real-Time Workshop' ) ;
   disp( '%%% for generation of an External System Library.' ) ;
   disp( ' ' ) ;
end
ADAMS_init = '' ;
ADAMS_inputs  = 'TorqueMotor.var_motor_torque!V_In!FrameDisturbance' ;
ADAMS_outputs = 'LeanAng_In!SteerAngle!V_Out!Dist!DriftAngle' ;
ADAMS_pinput = 'Nonlinear_Torque_15km.ctrl_pinput' ;
ADAMS_poutput = 'Nonlinear_Torque_15km.ctrl_poutput' ;
ADAMS_uy_ids  = [
                   21
                   5
                   25
                   12
                   2
                   3
                   6
                   13
                ] ;
ADAMS_mode   = 'non-linear' ;
tmp_in  = decode( ADAMS_inputs  ) ;
tmp_out = decode( ADAMS_outputs ) ;
disp( ' ' ) ;
disp( '%%% INFO : ADAMS plant actuators names :' ) ;
disp( [int2str([1:size(tmp_in,1)]'),blanks(size(tmp_in,1))',tmp_in] ) ;
disp( '%%% INFO : ADAMS plant sensors   names :' ) ;
disp( [int2str([1:size(tmp_out,1)]'),blanks(size(tmp_out,1))',tmp_out] ) ;
disp( ' ' ) ;
clear tmp_in tmp_out ;
% Adams / MATLAB Interface - Release 2018.1.0
tf = P_motor;