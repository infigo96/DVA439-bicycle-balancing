!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = meter  &
   angle = deg  &
   force = newton  &
   mass = kg  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 0.8  &
   spacing_for_grid = 0.8
!
!--------------------------- Plugins used by Model ----------------------------!
!
!
plugin load  &
   plugin_name = .MDI.plugins.amachinery
!
plugin load  &
   plugin_name = .MDI.plugins.controls
!
!------------------------------ Adams View Model ------------------------------!
!
!
model create  &
   model_name = Bike  &
   title = "SOLIDWORKS Motion Mechanism"
!
view erase
!
!-------------------------------- Data storage --------------------------------!
!
!
data_element create variable  &
   variable_name = .Bike.DriftAngle  &
   adams_id = 13  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.SteerAngle  &
   adams_id = 2  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.V_Out  &
   adams_id = 3  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.SteerTorque  &
   adams_id = 4  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.V_In  &
   adams_id = 5  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.Dist  &
   adams_id = 6  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.FrameDisturbance  &
   adams_id = 25  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .Bike.LeanAng_In  &
   adams_id = 12  &
   initial_condition = 0.0  &
   function = ""
!
!--------------------------------- Materials ----------------------------------!
!
!
material create  &
   material_name = .Bike.steel  &
   adams_id = 1  &
   density = 7801.0  &
   youngs_modulus = 2.07E+11  &
   poissons_ratio = 0.29
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!---------------------------------- Ground_1 ----------------------------------!
!
!
! ****** Ground Part ******
!
part modify rigid_body name_and_position  &
   part_name = ground  &
   new_part_name = Ground_1
!
part modify rigid_body name_and_position  &
   part_name = Ground_1  &
   adams_id = 3
!
defaults model  &
   part_name = Ground_1
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.Ground_1.LeanAng_Ref  &
   adams_id = 10058  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.LeanAng_Ref_2  &
   adams_id = 10061  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 15.87016127d, 270.0d
!
marker create  &
   marker_name = .Bike.Ground_1.Ground_1_Origin_2  &
   adams_id = 10062  &
   location = 0.0, -2.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.MARKER_10063  &
   adams_id = 10063  &
   location = 0.0, -20.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.MARKER_6  &
   adams_id = 6  &
   location = 0.0, 0.0, -0.567989265  &
   orientation = 90.0d, 90.0d, -90.0d
!
marker create  &
   marker_name = .Bike.Ground_1.MARKER_7  &
   adams_id = 7  &
   location = 0.0, 0.0, 0.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .Bike.Ground_1.MARKER_9  &
   adams_id = 9  &
   location = 9.95, 0.0, 0.0  &
   orientation = 180.0d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.Ground_1_Origin  &
   adams_id = 10002  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.cm  &
   adams_id = 10003  &
   location = 9.95, 0.0, 2.5E-03  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Ground_1.PSMAR  &
   adams_id = 10034  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Ground_1.PSMAR  &
   visibility = off
!
part create rigid_body mass_properties  &
   part_name = .Bike.Ground_1  &
   mass = 200.0  &
   center_of_mass_marker = .Bike.Ground_1.cm  &
   ixx = 66.66708333  &
   iyy = 6666.667083  &
   izz = 6733.333333  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
geometry create shape block  &
   block_name = .Bike.Ground_1.BOX_81  &
   adams_id = 81  &
   corner_marker = .Bike.Ground_1.MARKER_10063  &
   diag_corner_coords = 150.0, 40.0, 5.0E-03
!
!----------------------------------- ground -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part create rigid_body name_and_position  &
   part_name = .Bike.ground  &
   adams_id = 1  &
   comments = "Mechanism simTime 1", "Mechanism simFrames 25"  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.ground
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.ground.MARKER_5  &
   adams_id = 5  &
   location = 0.0, 0.0, -0.567989265  &
   orientation = 90.0d, 90.0d, -90.0d
!
marker create  &
   marker_name = .Bike.ground.MARKER_8  &
   adams_id = 8  &
   location = 0.0, 0.0, 0.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .Bike.ground.MARKER_10  &
   adams_id = 10  &
   location = 9.95, 0.0, 0.0  &
   orientation = 180.0d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.ground.MARKER_20  &
   adams_id = 20  &
   location = 0.2341267485, -9.390958448E-05, -0.3532369819  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .Bike.ground._Origin  &
   adams_id = 10010  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.ground.MARKER_10057  &
   adams_id = 10057  &
   location = 0.2341267485, -9.390958448E-05, -0.3532369819  &
   orientation = 0.0d, 0.0d, 0.0d
!
!---------------------------------- Frame_1 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part create rigid_body name_and_position  &
   part_name = .Bike.Frame_1  &
   adams_id = 2  &
   location = 0.6871712257, -9.39095853E-05, -0.2772613557  &
   orientation = 90.0d, 15.87016127d, 270.0d  &
   exact_coordinates = X, Y, Z
!
part create rigid_body initial_velocity  &
   part_name = .Bike.Frame_1  &
   vx = 2.22
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Frame_1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_1  &
   adams_id = 1  &
   location = 0.1121260139, 0.0, -0.2604401454  &
   orientation = 180.0d, 90.0d, 164.1298387d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_3  &
   adams_id = 3  &
   location = -0.415, 7.5E-02, -0.1969685106  &
   orientation = 0.0d, 90.0d, 15.87016127d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_13  &
   adams_id = 13  &
   location = 0.5340158949, 0.0, -0.3674567423  &
   orientation = 90.0d, 2.0d, -90.0d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_15  &
   adams_id = 15  &
   location = 0.5456897215, 0.0, -0.4429101171  &
   orientation = -90.0d, 178.0d, 90.0d
!
marker create  &
   marker_name = .Bike.Frame_1.Frame_1_Origin  &
   adams_id = 10000  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Frame_1.cm  &
   adams_id = 10001  &
   location = 0.1892020447, -5.728722445E-04, -0.2925044888  &
   orientation = 88.54982212d, 21.3844567d, -88.54968141d
!
marker create  &
   marker_name = .Bike.Frame_1.SteerAngRef  &
   adams_id = 10056  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 2.0d, 268.16269019d
!
marker create  &
   marker_name = .Bike.Frame_1.LeanAng_corr  &
   adams_id = 10059  &
   location = 0.0, 0.0, 0.0  &
   orientation = 270.0d, 15.87016127d, 90.0d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_10065  &
   adams_id = 10065  &
   location = 0.5403151991, 0.0, -0.5968163043  &
   orientation = 270.0d, 178.0d, 180.0d
!
marker create  &
   marker_name = .Bike.Frame_1.cm_2  &
   adams_id = 10068  &
   location = 0.1892020447, -5.728722445E-04, -0.2925044888  &
   orientation = 270.0d, 15.87016127d, 90.0d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_10098  &
   adams_id = 10098  &
   location = -3.412214955E-11, 0.0, -0.512  &
   orientation = 180.0d, 90.0d, 164.12983873d
!
marker create  &
   marker_name = .Bike.Frame_1.MARKER_10099  &
   adams_id = 10099  &
   location = -3.412214955E-11, 0.0, -0.512  &
   orientation = 180.0d, 90.0d, 164.12983873d
!
marker create  &
   marker_name = .Bike.Frame_1.TorqueMotor_stator_attach_J  &
   adams_id = 10102  &
   location = 0.5403151991, 0.0, -0.5968163043  &
   orientation = 270.0d, 178.0d, 180.0d
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR  &
   adams_id = 10019  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR1  &
   adams_id = 10020  &
   location = -8.988533E-03, -1.956890433E-04, -0.4741101803  &
   orientation = 181.2471874d, 90.0d, 180.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR1  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR2  &
   adams_id = 10021  &
   location = 1.85E-02, 0.0, -0.1756130604  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR2  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR3  &
   adams_id = 10022  &
   location = 0.0, 4.0E-03, 0.0  &
   orientation = 270.0d, 117.8832833d, 270.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR3  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR4  &
   adams_id = 10023  &
   location = 0.2271261224, 0.0, -0.189003047  &
   orientation = 270.0d, 142.3679339d, 90.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR4  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR5  &
   adams_id = 10024  &
   location = 0.5479581888, 0.0, -0.3779497134  &
   orientation = 180.0d, 90.0d, 182.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR5  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR6  &
   adams_id = 10025  &
   location = 0.6253284221, 0.0, -0.4777106672  &
   orientation = 0.0d, 90.0d, 358.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR6  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR7  &
   adams_id = 10026  &
   location = 0.6289300502, 0.0, -0.3745735339  &
   orientation = 270.0d, 178.0d, 270.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR7  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR8  &
   adams_id = 10027  &
   location = 0.5432467567, 0.0, -0.512867475  &
   orientation = 0.0d, 90.0d, 358.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR8  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR9  &
   adams_id = 10028  &
   location = 0.5711043886, 0.0, -0.4457988359  &
   orientation = 90.0d, 92.0d, 180.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR9  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR10  &
   adams_id = 10029  &
   location = 0.6427746651, 0.0, -0.4365749669  &
   orientation = 180.0d, 90.0d, 182.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR10  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR11  &
   adams_id = 10030  &
   location = 0.5790852285, 0.0, -0.5181214202  &
   orientation = 270.0d, 178.0d, 270.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR11  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR12  &
   adams_id = 10031  &
   location = 0.626375407, 0.0, -0.4477289424  &
   orientation = 0.0d, 90.0d, 358.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR12  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR13  &
   adams_id = 10032  &
   location = 0.5912777429, 0.0, -0.5215490208  &
   orientation = 270.0d, 178.0d, 270.0d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR13  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Frame_1.PSMAR14  &
   adams_id = 10033  &
   location = 0.6229203569, 0.0, -0.5466686343  &
   orientation = 358.975619751d, 89.96422976d, 358.000319773d
!
marker attributes  &
   marker_name = .Bike.Frame_1.PSMAR14  &
   visibility = off
!
part create rigid_body mass_properties  &
   part_name = .Bike.Frame_1  &
   mass = 10.51  &
   center_of_mass_marker = .Bike.Frame_1.cm  &
   inertia_marker = .Bike.Frame_1.cm_2  &
   ixx = 0.1597595709  &
   iyy = 1.091887126  &
   izz = 0.9578468528  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
!------------------------------- BackWheelass_1 -------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part create rigid_body name_and_position  &
   part_name = .Bike.BackWheelass_1  &
   adams_id = 4  &
   location = 0.2341267485, -9.390958448E-05, -0.3532369819  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body initial_velocity  &
   part_name = .Bike.BackWheelass_1  &
   vx = 2.22  &
   wy = 6.37
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.BackWheelass_1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.BackWheelass_1.MARKER_2  &
   adams_id = 2  &
   location = 0.4896771544, 0.0, -0.2051993358  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker create  &
   marker_name = .Bike.BackWheelass_1.MARKER_4  &
   adams_id = 4  &
   location = 0.0, 8.7E-02, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .Bike.BackWheelass_1.MARKER_19  &
   adams_id = 19  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .Bike.BackWheelass_1.BackWheelass_1_Origin  &
   adams_id = 10005  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.BackWheelass_1.cm  &
   adams_id = 10006  &
   location = -1.215307608E-09, 1.002777E-03, -3.252656123E-08  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR  &
   adams_id = 10035  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR15  &
   adams_id = 10036  &
   location = 0.0, 2.45E-02, 0.0  &
   orientation = 180.0d, 180.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR15  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR16  &
   adams_id = 10037  &
   location = 7.2444437E-02, 3.45E-02, -1.94114284E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR16  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR17  &
   adams_id = 10038  &
   location = 7.2444437E-02, 3.45E-02, 1.94114284E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR17  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR18  &
   adams_id = 10039  &
   location = -7.2444437E-02, 3.45E-02, -1.94114284E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR18  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR19  &
   adams_id = 10040  &
   location = 0.0, -4.65E-02, 0.0  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR19  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR20  &
   adams_id = 10041  &
   location = -5.30330086E-02, 3.45E-02, -5.30330086E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR20  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR21  &
   adams_id = 10042  &
   location = 1.94114284E-02, 3.45E-02, -7.2444437E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR21  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR22  &
   adams_id = 10043  &
   location = -7.2444437E-02, 3.45E-02, 1.94114284E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR22  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR23  &
   adams_id = 10044  &
   location = -1.94114284E-02, 2.75E-02, -7.2444437E-02  &
   orientation = 180.0d, 90.0d, 326.84238036d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR23  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR24  &
   adams_id = 10045  &
   location = 5.30330086E-02, 3.45E-02, 5.30330086E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR24  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR25  &
   adams_id = 10046  &
   location = 5.30330086E-02, 3.45E-02, -5.30330086E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR25  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR26  &
   adams_id = 10047  &
   location = -5.30330086E-02, 3.45E-02, 5.30330086E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR26  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR27  &
   adams_id = 10048  &
   location = 1.94114284E-02, 3.45E-02, 7.2444437E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR27  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR28  &
   adams_id = 10049  &
   location = 0.0, 2.45E-02, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR28  &
   visibility = off
!
marker create  &
   marker_name = .Bike.BackWheelass_1.PSMAR29  &
   adams_id = 10050  &
   location = -1.94114284E-02, 3.45E-02, 7.2444437E-02  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.BackWheelass_1.PSMAR29  &
   visibility = off
!
part create rigid_body mass_properties  &
   part_name = .Bike.BackWheelass_1  &
   mass = 6.78  &
   center_of_mass_marker = .Bike.BackWheelass_1.cm  &
   ixx = 0.244411322  &
   iyy = 0.4850922576  &
   izz = 0.2444110247  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
!----------------------------------- Fork_2 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part create rigid_body name_and_position  &
   part_name = .Bike.Fork_2  &
   adams_id = 5  &
   location = 1.137207419, -2.61404841E-02, -0.7886271013  &
   orientation = 90.0d, 17.87016127d, 268.16269019d
!
part create rigid_body initial_velocity  &
   part_name = .Bike.Fork_2  &
   vx = 2.22
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Fork_2
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_32  &
   adams_id = 32  &
   location = -2.5249999693E-02, 2.5250000035E-02, -0.2289999999  &
   orientation = 181.83730981d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.Origin_straight  &
   adams_id = 10060  &
   location = 0.0, 0.0, 0.0  &
   orientation = 271.83730981d, 17.87016127d, 90.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_10064  &
   adams_id = 10064  &
   location = -2.5249999693E-02, 2.5250000035E-02, -0.2289999999  &
   orientation = 91.83730981d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.cm_2  &
   adams_id = 10067  &
   location = 3.0456162911E-03, 2.4042952E-02, 8.4567308042E-02  &
   orientation = 271.83730981d, 17.87016127d, 90.0d
!
marker create  &
   marker_name = .Bike.Fork_2.TorqueMotor_rotor_attach_J  &
   adams_id = 10103  &
   location = -2.5249999693E-02, 2.5250000035E-02, -0.2289999999  &
   orientation = 91.83730981d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_11  &
   adams_id = 11  &
   location = 6.55E-02, 2.525E-02, -0.209  &
   orientation = 0.0d, 90.0d, 90.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_14  &
   adams_id = 14  &
   location = -3.95426483E-02, 2.4791519E-02, 0.0  &
   orientation = 1.837309811d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_16  &
   adams_id = 16  &
   location = -2.525E-02, 2.525E-02, -0.115  &
   orientation = -178.1626902d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_17  &
   adams_id = 17  &
   location = 3.5E-02, 8.45E-02, 0.467  &
   orientation = -180.0d, 90.0d, -90.0d
!
marker create  &
   marker_name = .Bike.Fork_2.MARKER_31  &
   adams_id = 31  &
   location = -2.525E-02, 2.525E-02, -0.229  &
   orientation = -178.1626902d, 180.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.Fork_2_Origin  &
   adams_id = 10008  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Fork_2.cm  &
   adams_id = 10009  &
   location = 3.0456163E-03, 2.4042952E-02, 8.4567308E-02  &
   orientation = 87.47002312d, 1.74152456d, -87.57010547d
!
marker create  &
   marker_name = .Bike.Fork_2.PSMAR  &
   adams_id = 10051  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Fork_2.PSMAR  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Fork_2.PSMAR30  &
   adams_id = 10052  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Fork_2.PSMAR30  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Fork_2.PSMAR31  &
   adams_id = 10053  &
   location = 6.55E-02, 2.525E-02, -0.209  &
   orientation = 270.0d, 135.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Fork_2.PSMAR31  &
   visibility = off
!
marker create  &
   marker_name = .Bike.Fork_2.PSMAR32  &
   adams_id = 10054  &
   location = -2.525E-02, 2.525E-02, -0.16  &
   orientation = 180.0d, 90.0d, 180.0d
!
marker attributes  &
   marker_name = .Bike.Fork_2.PSMAR32  &
   visibility = off
!
part create rigid_body mass_properties  &
   part_name = .Bike.Fork_2  &
   mass = 3.11  &
   center_of_mass_marker = .Bike.Fork_2.cm  &
   inertia_marker = .Bike.Fork_2.cm_2  &
   ixx = 0.1284317561  &
   iyy = 0.1192866983  &
   izz = 1.24504669E-02  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
!-------------------------------- Frontwheel_1 --------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part create rigid_body name_and_position  &
   part_name = .Bike.Frontwheel_1  &
   adams_id = 6  &
   location = 1.314576281, -2.0256216E-03, -0.3551408584  &
   orientation = 267.92423118d, 59.88018465d, 90.65170942d
!
part create rigid_body initial_velocity  &
   part_name = .Bike.Frontwheel_1  &
   vx = 2.22  &
   wy = 6.37
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Frontwheel_1
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .Bike.Frontwheel_1.cm_2  &
   adams_id = 10066  &
   location = -8.1954865117E-10, -4.1625187471E-04, 6.4487526432E-11  &
   orientation = 89.34829058d, 59.88018465d, 272.07576882d
!
marker create  &
   marker_name = .Bike.Frontwheel_1.MARKER_12  &
   adams_id = 12  &
   location = -0.6541069682, 0.0, -0.1733502932  &
   orientation = 0.0d, 90.0d, 12.25986619d
!
marker create  &
   marker_name = .Bike.Frontwheel_1.MARKER_18  &
   adams_id = 18  &
   location = 0.0, 5.85E-02, 0.0  &
   orientation = 180.0d, 90.0d, -12.25986619d
!
marker create  &
   marker_name = .Bike.Frontwheel_1.Frontwheel_1_Origin  &
   adams_id = 10014  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Frontwheel_1.cm  &
   adams_id = 10015  &
   location = -7.960893336E-10, -4.162518763E-04, 1.202358021E-10  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .Bike.Frontwheel_1.PSMAR  &
   adams_id = 10055  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .Bike.Frontwheel_1.PSMAR  &
   visibility = off
!
part create rigid_body mass_properties  &
   part_name = .Bike.Frontwheel_1  &
   mass = 1.99  &
   center_of_mass_marker = .Bike.Frontwheel_1.cm  &
   inertia_marker = .Bike.Frontwheel_1.cm_2  &
   ixx = 0.1003509473  &
   iyy = 0.2002931253  &
   izz = 0.100350947  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
! ****** Graphics for current part ******
!
! ****** Graphics from Parasolid file ******
!
file parasolid read  &
   file_name = "Nonlinear_Torque_8km.xmt_txt"  &
   model_name = .Bike
!
geometry attributes  &
   geometry_name = .Bike.Ground_1.Ground_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Frame_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.SupportBar_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.ComponentMount_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.BrakeMotor_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Battery_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.U_Bolt_4_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.U_Bolt_3_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Motor_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.U_Bolt_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Bar_Shield_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Motor_Holder_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Motorf_ste2_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.U_Bolt_5_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Motorf_ste3_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frame_1.Cogwheel_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_holder_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_9_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_11_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_4_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.BrakeDisc_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_3_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_6_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_5_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_12_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_7_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_10_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_holder_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Magnet_8_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.BackWheelass_1.Backwheel_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Fork_2.Fork_2_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Fork_2.Fork_2_graphic_body2  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Fork_2.Handle_bar_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Fork_2.Cogwheel_1_graphic_body1  &
   color = WHITE
!
geometry attributes  &
   geometry_name = .Bike.Frontwheel_1.Frontwheel_1_graphic_body1  &
   color = WHITE
!
!---------------------------------- Contacts ----------------------------------!
!
!
contact create  &
   contact_name = .Bike.Ground_1_Backwheel_1  &
   adams_id = 2  &
   type = solid_to_solid  &
   i_geometry_name = .Bike.Ground_1.BOX_81  &
   j_geometry_name = .Bike.BackWheelass_1.Backwheel_1_graphic_body1  &
   stiffness = 1.0E+08  &
   damping = 1.0E+04  &
   exponent = 2.2  &
   dmax = 1.0E-04  &
   coulomb_friction = dynamics_only  &
   mu_static = 0.72  &
   mu_dynamic = 0.72  &
   stiction_transition_velocity = 0.2  &
   friction_transition_velocity = 1.0
!
contact create  &
   contact_name = .Bike.Ground_1_Frontwheel_1  &
   adams_id = 5  &
   type = solid_to_solid  &
   i_geometry_name = .Bike.Ground_1.BOX_81  &
   j_geometry_name = .Bike.Frontwheel_1.Frontwheel_1_graphic_body1  &
   stiffness = 1.0E+08  &
   damping = 1.0E+04  &
   exponent = 2.2  &
   dmax = 1.0E-04  &
   coulomb_friction = dynamics_only  &
   mu_static = 0.72  &
   mu_dynamic = 0.72  &
   stiction_transition_velocity = 0.2  &
   friction_transition_velocity = 1.0
!
!----------------------------------- Joints -----------------------------------!
!
!
constraint create joint planar  &
   joint_name = .Bike.Fork2Frame_Bottom  &
   adams_id = 1  &
   i_marker_name = .Bike.Frame_1.MARKER_13  &
   j_marker_name = .Bike.Fork_2.MARKER_14
!
constraint attributes  &
   constraint_name = .Bike.Fork2Frame_Bottom  &
   visibility = off  &
   name_visibility = off
!
constraint create joint planar  &
   joint_name = .Bike.Ground2Top  &
   adams_id = 2  &
   i_marker_name = .Bike.Ground_1.MARKER_7  &
   j_marker_name = .Bike.ground.MARKER_8
!
constraint attributes  &
   constraint_name = .Bike.Ground2Top  &
   visibility = off  &
   name_visibility = off
!
constraint create joint planar  &
   joint_name = .Bike.Coincident1  &
   adams_id = 3  &
   i_marker_name = .Bike.Frame_1.MARKER_1  &
   j_marker_name = .Bike.BackWheelass_1.MARKER_2
!
constraint attributes  &
   constraint_name = .Bike.Coincident1  &
   visibility = off  &
   name_visibility = off
!
constraint create joint cylindrical  &
   joint_name = .Bike.FrontWheel2Frame  &
   adams_id = 4  &
   i_marker_name = .Bike.Fork_2.MARKER_17  &
   j_marker_name = .Bike.Frontwheel_1.MARKER_18
!
constraint attributes  &
   constraint_name = .Bike.FrontWheel2Frame  &
   visibility = off  &
   name_visibility = off
!
constraint create joint planar  &
   joint_name = .Bike.FrontWheel2Fork  &
   adams_id = 5  &
   i_marker_name = .Bike.Fork_2.MARKER_11  &
   j_marker_name = .Bike.Frontwheel_1.MARKER_12
!
constraint attributes  &
   constraint_name = .Bike.FrontWheel2Fork  &
   visibility = off
!
constraint create joint planar  &
   joint_name = .Bike.Ground2Right  &
   adams_id = 6  &
   i_marker_name = .Bike.ground.MARKER_5  &
   j_marker_name = .Bike.Ground_1.MARKER_6
!
constraint attributes  &
   constraint_name = .Bike.Ground2Right  &
   visibility = off  &
   name_visibility = off
!
constraint create joint cylindrical  &
   joint_name = .Bike.Fork2FrameCylinder  &
   adams_id = 7  &
   i_marker_name = .Bike.Frame_1.MARKER_15  &
   j_marker_name = .Bike.Fork_2.MARKER_16
!
constraint attributes  &
   constraint_name = .Bike.Fork2FrameCylinder  &
   visibility = off  &
   name_visibility = off  &
   size_of_icons = 0.2
!
constraint create joint planar  &
   joint_name = .Bike.Ground2Front  &
   adams_id = 8  &
   i_marker_name = .Bike.Ground_1.MARKER_9  &
   j_marker_name = .Bike.ground.MARKER_10
!
constraint attributes  &
   constraint_name = .Bike.Ground2Front  &
   visibility = off  &
   name_visibility = off
!
constraint create joint cylindrical  &
   joint_name = .Bike.Concentric6  &
   adams_id = 9  &
   i_marker_name = .Bike.Frame_1.MARKER_3  &
   j_marker_name = .Bike.BackWheelass_1.MARKER_4
!
constraint attributes  &
   constraint_name = .Bike.Concentric6  &
   visibility = off  &
   name_visibility = off
!
!----------------------------------- Forces -----------------------------------!
!
!
force create direct single_component_force  &
   single_component_force_name = .Bike.SteerMotor  &
   adams_id = 1  &
   type_of_freedom = rotational  &
   i_marker_name = .Bike.Fork_2.MARKER_31  &
   j_marker_name = .Bike.Fork_2.MARKER_32  &
   action_only = on  &
   function = ""
!
force attributes  &
   force_name = .Bike.SteerMotor  &
   active = off  &
   size_of_icons = 0.2
!
force create direct single_component_force  &
   single_component_force_name = .Bike.Disturbance  &
   adams_id = 4  &
   type_of_freedom = translational  &
   i_marker_name = .Bike.Frame_1.MARKER_10098  &
   j_marker_name = .Bike.Frame_1.MARKER_10099  &
   action_only = on  &
   function = ""
!
force attributes  &
   force_name = .Bike.Disturbance  &
   size_of_icons = 0.2
!
!----------------------------- Simulation Scripts -----------------------------!
!
!
simulation script create  &
   sim_script_name = .Bike.Last_Sim  &
   commands =   &
              "simulation single_run transient type=auto_select initial_static=no end_time=1.0 step_size=5.0E-03 model_name=.Bike"
!
!-------------------------- Adams View UDE Instances --------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
undo begin_block suppress = yes
!
ude create instance  &
   instance_name = .Bike.Nonlinear_Torque_8km  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude create instance  &
   instance_name = .Bike.Nonlinear_Torque_12km  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude create instance  &
   instance_name = .Bike.Nonlinear_Torque_15km  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude create instance  &
   instance_name = .Bike.MotorTorquePlant  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
ude create instance  &
   instance_name = .Bike.TorqueMotor  &
   definition_name = .amachinery.parts.ac_motor_external  &
   location = 1.043687306, -9.390958639E-05, -0.9990830096  &
   orientation = 270.0, 162.12983873, 180.0
!
ude create instance  &
   instance_name = .Bike.TorqueTEST_plant  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.input_channels  &
   object_value =   &
      .Bike.TorqueMotor.var_motor_torque,  &
      .Bike.V_In,  &
      .Bike.FrameDisturbance
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.output_channels  &
   object_value =   &
      .Bike.LeanAng_In,  &
      .Bike.SteerAngle,  &
      .Bike.V_Out,  &
      .Bike.Dist,  &
      .Bike.DriftAngle
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.file_name  &
   string_value = "Nonlinear_Torque_8km"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.host  &
   string_value = "DESKTOP-F3FKN9V.mdh.se"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_8km.ude_group  &
   object_value = (NONE)
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_8km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.input_channels  &
   object_value =   &
      .Bike.TorqueMotor.var_motor_torque,  &
      .Bike.V_In,  &
      .Bike.FrameDisturbance
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.output_channels  &
   object_value =   &
      .Bike.LeanAng_In,  &
      .Bike.SteerAngle,  &
      .Bike.V_Out,  &
      .Bike.Dist,  &
      .Bike.DriftAngle
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.file_name  &
   string_value = "Nonlinear_Torque_12km"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.host  &
   string_value = "DESKTOP-F3FKN9V.mdh.se"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_12km.ude_group  &
   object_value = (NONE)
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_12km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.input_channels  &
   object_value =   &
      .Bike.TorqueMotor.var_motor_torque,  &
      .Bike.V_In,  &
      .Bike.FrameDisturbance
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.output_channels  &
   object_value =   &
      .Bike.LeanAng_In,  &
      .Bike.SteerAngle,  &
      .Bike.V_Out,  &
      .Bike.Dist,  &
      .Bike.DriftAngle
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.file_name  &
   string_value = "Nonlinear_Torque_15km"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.host  &
   string_value = "DESKTOP-F3FKN9V.mdh.se"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.Nonlinear_Torque_15km.ude_group  &
   object_value = (NONE)
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_15km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.input_channels  &
   object_value =   &
      .Bike.TorqueMotor.var_motor_torque,  &
      .Bike.V_In
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.output_channels  &
   object_value =   &
      .Bike.LeanAng_In,  &
      .Bike.SteerAngle,  &
      .Bike.V_Out,  &
      .Bike.Dist,  &
      .Bike.DriftAngle
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.file_name  &
   string_value = "MotorTorquePlant"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.target  &
   string_value = "MATLAB"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.host  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.MotorTorquePlant.ude_group  &
   object_value = (NONE)
!
ude modify instance  &
   instance_name = .Bike.MotorTorquePlant
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.TorqueMotor.method  &
   string_value = "external"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.motor_type  &
   string_value = "dc"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.external_method  &
   string_value = "Co_Simulation"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.input_output  &
   string_value = "standard"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.equation_name  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.library_name  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.plant_export  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.target_software  &
   string_value = "matlab"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.Pinput_array  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.Poutput_array  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.existing_control_plant  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.static_hold  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.GSE_success_flag  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.error_tolerance  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.error_scale  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.communication_interval  &
   real_value = 1.0E-02
!
variable modify  &
   variable_name = .Bike.TorqueMotor.visibility  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.toggle_initialize  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.plant_name  &
   object_value = .Bike.TorqueTEST_plant
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_length  &
   real_value = (0.1m)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_width  &
   real_value = (0.1m)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_length  &
   real_value = (0.1m)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_radius  &
   real_value = (2.5E-02m)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_mass  &
   real_value = (1.0kg)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Ixx  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Iyy  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Izz  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Ixy  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Izx  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_Iyz  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_density  &
   real_value = 7801.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_material  &
   string_value = ".materials.steel"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_mass  &
   real_value = (1.0kg)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Ixx  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Iyy  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Izz  &
   real_value = (1.0E-05(kg-m**2))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Ixy  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Izx  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_Iyz  &
   real_value = 0.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_density  &
   real_value = 7801.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_material  &
   string_value = ".materials.steel"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.multiplier_type  &
   string_value = "scale_factor"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.scale_factor  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.step_start_time
!
variable modify  &
   variable_name = .Bike.TorqueMotor.step_end_time
!
variable modify  &
   variable_name = .Bike.TorqueMotor.step_start_value
!
variable modify  &
   variable_name = .Bike.TorqueMotor.step_end_value
!
variable modify  &
   variable_name = .Bike.TorqueMotor.scale_function  &
   string_value = (NONE)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotation_direction  &
   string_value = "ccw"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_cw  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attachment_type  &
   string_value = "Fixed"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attachment_type  &
   string_value = "Fixed"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.detailed_geometry_flag  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_mass_option  &
   string_value = "mass"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_off_diagonal_flag  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_mass_option  &
   string_value = "mass"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_off_diagonal_flag  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.connection_name  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attachment  &
   string_value = ".Bike.Fork_2.TorqueMotor_rotor_attach_J"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attachment  &
   string_value = ".Bike.Frame_1.TorqueMotor_stator_attach_J"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.unit_conversion_torque  &
   real_value = (UNITS_CONVERSION_FACTOR("meter") * UNITS_CONVERSION_FACTOR("newton"))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.unit_conversion_length  &
   real_value = (UNITS_CONVERSION_FACTOR("meter"))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.unit_conversion_angle  &
   real_value = (UNITS_CONVERSION_FACTOR("radians"))
!
variable modify  &
   variable_name = .Bike.TorqueMotor.connection_type  &
   string_value = "new"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.motor_flip  &
   string_value = "default"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.motor_geometry_flip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.flip_motor  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.force_display  &
   string_value = "none"
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attach_radial_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attach_axial_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attach_bending_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attach_torsional_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.stator_attach_damping_ratio  &
   real_value = (1.0 * 1sec)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attach_radial_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attach_axial_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attach_bending_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attach_torsional_stiffness  &
   real_value = 1.0
!
variable modify  &
   variable_name = .Bike.TorqueMotor.rotor_attach_damping_ratio  &
   real_value = (1.0 * 1sec)
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_joi_I  &
   object_value = .Bike.Fork_2.TorqueMotor_rotor_attach_J
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_joi_J  &
   object_value = .Bike.Frame_1.TorqueMotor_stator_attach_J
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_sfo_I  &
   object_value = .Bike.Fork_2.TorqueMotor_rotor_attach_J
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_sfo_J  &
   object_value = .Bike.Frame_1.TorqueMotor_stator_attach_J
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_rotor_attach_J  &
   object_value = .Bike.Fork_2.TorqueMotor_rotor_attach_J
!
variable modify  &
   variable_name = .Bike.TorqueMotor.mar_stator_attach_J  &
   object_value = .Bike.Frame_1.TorqueMotor_stator_attach_J
!
ude modify instance  &
   instance_name = .Bike.TorqueMotor
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.input_channels  &
   object_value = .Bike.TorqueMotor.var_motor_torque
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.output_channels  &
   object_value =   &
      .Bike.TorqueMotor.var_angacc,  &
      .Bike.TorqueMotor.var_omega,  &
      .Bike.TorqueMotor.var_angdisp
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.file_name  &
   string_value = "TorqueMotor_plant"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.target  &
   string_value = "matlab"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.host  &
   string_value = ""
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.realtime  &
   string_value = "off"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .Bike.TorqueTEST_plant.ude_group  &
   object_value = (NONE)
!
ude modify instance  &
   instance_name = .Bike.TorqueTEST_plant
!
undo end_block
!
!------------------------------ Dynamic Graphics ------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
geometry create shape force  &
   force_name = .Bike.SFORCE_4_force_graphic_1  &
   adams_id = 96  &
   force_element_name = .Bike.Disturbance  &
   applied_at_marker_name = .Bike.Frame_1.MARKER_10098
!
geometry create shape force  &
   force_name = .Bike.SteerMotor_force_graphic_1  &
   adams_id = 74  &
   force_element_name = .Bike.SteerMotor  &
   applied_at_marker_name = .Bike.Fork_2.MARKER_31
!
geometry attributes  &
   geometry_name = .Bike.SteerMotor_force_graphic_1  &
   active = off
!
geometry create shape gcontact  &
   contact_force_name = .Bike.GCONTACT_77  &
   adams_id = 77  &
   contact_element_name = .Bike.Ground_1_Backwheel_1  &
   force_display = components
!
geometry attributes  &
   geometry_name = .Bike.GCONTACT_77  &
   color = RED
!
geometry create shape gcontact  &
   contact_force_name = .Bike.GCONTACT_80  &
   adams_id = 80  &
   contact_element_name = .Bike.Ground_1_Frontwheel_1  &
   force_display = components
!
geometry attributes  &
   geometry_name = .Bike.GCONTACT_80  &
   color = RED
!
!---------------------------------- Motions -----------------------------------!
!
!
constraint create motion_generator  &
   motion_name = .Bike.BackMotor_RotateZ  &
   adams_id = 1  &
   i_marker_name = .Bike.BackWheelass_1.MARKER_19  &
   j_marker_name = .Bike.ground.MARKER_20  &
   axis = b3  &
   time_derivative = velocity  &
   function = ""
!
constraint attributes  &
   constraint_name = .Bike.BackMotor_RotateZ  &
   size_of_icons = 0.2304
!
constraint create motion_generator  &
   motion_name = .Bike.SteeringMotor  &
   adams_id = 2  &
   i_marker_name = .Bike.Fork_2.MARKER_10064  &
   j_marker_name = .Bike.Frame_1.MARKER_10065  &
   axis = b3  &
   time_derivative = velocity  &
   function = ""
!
constraint attributes  &
   constraint_name = .Bike.SteeringMotor  &
   active = off  &
   name_visibility = off  &
   size_of_icons = 0.2
!
!---------------------------------- Accgrav -----------------------------------!
!
!
force create body gravitational  &
   gravity_field_name = ACC  &
   x_component_gravity = 0.0  &
   y_component_gravity = 0.0  &
   z_component_gravity = 9.82
!
!----------------------------- Analysis settings ------------------------------!
!
!
executive_control set numerical_integration_parameters  &
   model_name = Bike  &
   error_tolerance = 1.0E-04  &
   pattern_for_jacobian = yes, yes, yes, yes, yes, yes, yes, yes, yes, yes  &
   maxit_corrector_iterations = 25  &
   hinit_time_step = 1.0E-04  &
   hmin_time_step = 1.0E-07  &
   hmax_time_step = 1.0E-02
!
executive_control set equilibrium_parameters  &
   model_name = Bike  &
   dynamic = yes
!
executive_control set kinematics_parameters  &
   model_name = Bike  &
   hmax = 1.0E-02
!
output_control set output  &
   model_name = Bike  &
   separator = off
!
output_control set results  &
   model_name = Bike  &
   formatted = on
!
executive_control set preferences  &
   model_name = Bike  &
   contact_faceting_tolerance = 900.0
!
!---------------------------- Adams View Variables ----------------------------!
!
!
variable create  &
   variable_name = .Bike.Init_Vel  &
   units = "velocity"  &
   range = 0.0, 20.0  &
   use_allowed_values = no  &
   delta_type = relative  &
   real_value = 2.22
!
variable create  &
   variable_name = .Bike.Init_AngVel  &
   units = "angular_velocity"  &
   range = 0.0, 20.0  &
   use_allowed_values = no  &
   delta_type = relative  &
   real_value = 6.37
!
variable create  &
   variable_name = .Bike.DV_1  &
   units = "no_units"  &
   range = -90.0, 90.0  &
   use_range = no  &
   use_allowed_values = no  &
   delta_type = relative  &
   real_value = 0.0
!
!---------------------------- Adams View Functions ----------------------------!
!
!
function create  &
   function_name = .LEAN  &
   text_of_expression = "ACOS(DOT(LOC_Z_AXIS(.Bike.Frame_1.LeanAng_corr), LOC_Z_AXIS(.Bike.Ground_1.LeanAng_Ref)) / (NORM(LOC_Z_AXIS(.Bike.Frame_1.LeanAng_corr)) * NORM(LOC_Z_AXIS(.Bike.Ground_1.LeanAng_Ref))))"  &
   type = real
!
!---------------------------- Function definitions ----------------------------!
!
!
constraint modify motion_generator  &
   motion_name = .Bike.BackMotor_RotateZ  &
   function = "VARVAL(.Bike.V_In)"
!
constraint modify motion_generator  &
   motion_name = .Bike.SteeringMotor  &
   function = "0.0d * time"
!
data_element modify variable  &
   variable_name = .Bike.DriftAngle  &
   function = "AZ(.Bike.Frame_1.LeanAng_corr)*rtod"
!
data_element modify variable  &
   variable_name = .Bike.SteerAngle  &
   function = "AZ(.Bike.Fork_2.Fork_2_Origin, .Bike.Frame_1.SteerAngRef)*rtod"
!
data_element modify variable  &
   variable_name = .Bike.V_Out  &
   function = "WY(.Bike.BackWheelass_1.BackWheelass_1_Origin, .Bike.ground._Origin, .Bike.BackWheelass_1.BackWheelass_1_Origin)*(180/pi)"
!
data_element modify variable  &
   variable_name = .Bike.SteerTorque  &
   function = "0"
!
data_element modify variable  &
   variable_name = .Bike.V_In  &
   function = "0"
!
data_element modify variable  &
   variable_name = .Bike.Dist  &
   function = "DM(.Bike.Frame_1.Frame_1_Origin, .Bike.Ground_1.LeanAng_Ref)-0.6871712257"
!
data_element modify variable  &
   variable_name = .Bike.FrameDisturbance  &
   function = "0"
!
data_element modify variable  &
   variable_name = .Bike.LeanAng_In  &
   function = "AX(.Bike.Frame_1.LeanAng_corr)*rtod"
!
force modify direct single_component_force  &
   single_component_force_name = .Bike.SteerMotor  &
   function = "-VARVAL(.Bike.SteerTorque)"
!
force modify direct single_component_force  &
   single_component_force_name = .Bike.Disturbance  &
   function = "VARVAL(.Bike.FrameDisturbance)"
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_8km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_12km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.Nonlinear_Torque_15km
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.MotorTorquePlant
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.TorqueMotor
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .Bike.TorqueTEST_plant
!
!--------------------------- Expression definitions ---------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = Ground_1
!
part modify rigid_body initial_velocity  &
   part_name = .Bike.Frame_1  &
   vx = (.Bike.Init_Vel)
!
marker modify  &
   marker_name = .Bike.Frame_1.TorqueMotor_stator_attach_J  &
   location =   &
      (LOC_RELATIVE_TO({0.0, 0.0, 0.0}mm, .Bike.TorqueMotor))  &
   orientation =   &
      (ORI_RELATIVE_TO({0.0, 0.0, 0.0}deg, .Bike.TorqueMotor))  &
   relative_to = .Bike.Frame_1
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
geometry modify shape block  &
   block_name = .Bike.Ground_1.BOX_81  &
   diag_corner_coords =   &
      (150meter),  &
      (40meter),  &
      (5.0E-03meter)
!
part modify rigid_body initial_velocity  &
   part_name = .Bike.BackWheelass_1  &
   vx = (.Bike.Init_Vel)  &
   wy = (.Bike.Init_AngVel)
!
part modify rigid_body initial_velocity  &
   part_name = .Bike.Fork_2  &
   vx = (.Bike.Init_Vel)
!
marker modify  &
   marker_name = .Bike.Fork_2.TorqueMotor_rotor_attach_J  &
   location =   &
      (LOC_RELATIVE_TO({0.0, 0.0, 0.0}mm, .Bike.TorqueMotor))  &
   orientation =   &
      (ORI_RELATIVE_TO({0.0, 0.0, 0.0}deg, .Bike.TorqueMotor))  &
   relative_to = .Bike.Fork_2
!
defaults coordinate_system  &
   default_coordinate_system = .Bike.Ground_1
!
part modify rigid_body initial_velocity  &
   part_name = .Bike.Frontwheel_1  &
   vx = (.Bike.Init_Vel)  &
   wy = (.Bike.Init_AngVel)
!
contact modify  &
   contact_name = .Bike.Ground_1_Backwheel_1  &
   stiffness = (1 * 10**8(N/m))  &
   damping = (1 * 10**4(N*s/m))  &
   dmax = (1 * 10**-4(m))  &
   stiction_transition_velocity = (0.2(m/s))  &
   friction_transition_velocity = (1(m/s))
!
contact modify  &
   contact_name = .Bike.Ground_1_Frontwheel_1  &
   stiffness = (1 * 10**8( N/m ))  &
   damping = (1 * 10**4(N*s/m ))  &
   dmax = (1 * 10**-4( m ))  &
   stiction_transition_velocity = (0.2(m/s))  &
   friction_transition_velocity = (1(m/s))
!
geometry modify shape force  &
   force_name = .Bike.SteerMotor_force_graphic_1  &
   applied_at_marker_name = (.Bike.SteerMotor.i)
!
variable modify  &
   variable_name = .Bike.Init_Vel  &
   real_value = (2.22(M/S))
!
variable modify  &
   variable_name = .Bike.DV_1  &
   real_value = (ACOS(DOT(LOC_Z_AXIS(.Bike.Frame_1.LeanAng_corr), LOC_Z_AXIS(.Bike.Ground_1.LeanAng_Ref)) / (NORM(LOC_Z_AXIS(.Bike.Frame_1.LeanAng_corr)) * NORM(LOC_Z_AXIS(.Bike.Ground_1.LeanAng_Ref)))))
!
material modify  &
   material_name = .Bike.steel  &
   density = (7801.0(kg/meter**3))  &
   youngs_modulus = (2.07E+11(Newton/meter**2))
!
geometry modify shape force  &
   force_name = .Bike.SFORCE_4_force_graphic_1  &
   applied_at_marker_name = (.Bike.Disturbance.i)
!
model display  &
   model_name = Bike
