#ifndef __c1_torque_controller_h__
#define __c1_torque_controller_h__

/* Type Definitions */
#ifndef struct_tag_s1eTpAM3l49H1qmKQgaS0pB
#define struct_tag_s1eTpAM3l49H1qmKQgaS0pB

struct tag_s1eTpAM3l49H1qmKQgaS0pB
{
  uint32_T Method;
  uint32_T Seed;
  uint32_T State[625];
  uint32_T LegacyRandnState[2];
};

#endif                                 /*struct_tag_s1eTpAM3l49H1qmKQgaS0pB*/

#ifndef typedef_c1_s1eTpAM3l49H1qmKQgaS0pB
#define typedef_c1_s1eTpAM3l49H1qmKQgaS0pB

typedef struct tag_s1eTpAM3l49H1qmKQgaS0pB c1_s1eTpAM3l49H1qmKQgaS0pB;

#endif                                 /*typedef_c1_s1eTpAM3l49H1qmKQgaS0pB*/

#include <time.h>
#ifndef struct_tag_sxaDueAh1f53T9ESYg9Uc4E
#define struct_tag_sxaDueAh1f53T9ESYg9Uc4E

struct tag_sxaDueAh1f53T9ESYg9Uc4E
{
  real_T tm_min;
  real_T tm_sec;
  real_T tm_hour;
  real_T tm_mday;
  real_T tm_mon;
  real_T tm_year;
};

#endif                                 /*struct_tag_sxaDueAh1f53T9ESYg9Uc4E*/

#ifndef typedef_c1_sxaDueAh1f53T9ESYg9Uc4E
#define typedef_c1_sxaDueAh1f53T9ESYg9Uc4E

typedef struct tag_sxaDueAh1f53T9ESYg9Uc4E c1_sxaDueAh1f53T9ESYg9Uc4E;

#endif                                 /*typedef_c1_sxaDueAh1f53T9ESYg9Uc4E*/

#ifndef typedef_SFc1_torque_controllerInstanceStruct
#define typedef_SFc1_torque_controllerInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c1_sfEvent;
  boolean_T c1_doneDoubleBufferReInit;
  uint8_T c1_is_active_c1_torque_controller;
  void *c1_RuntimeVar;
  uint32_T c1_seed;
  boolean_T c1_seed_not_empty;
  uint32_T c1_method;
  boolean_T c1_method_not_empty;
  uint32_T c1_b_method;
  boolean_T c1_b_method_not_empty;
  uint32_T c1_state[2];
  boolean_T c1_state_not_empty;
  uint32_T c1_b_state[625];
  boolean_T c1_b_state_not_empty;
  uint32_T c1_c_state;
  boolean_T c1_c_state_not_empty;
  uint32_T c1_d_state[2];
  boolean_T c1_d_state_not_empty;
  uint32_T c1_mlFcnLineNumber;
  void *c1_fEmlrtCtx;
  real_T *c1_y;
} SFc1_torque_controllerInstanceStruct;

#endif                                 /*typedef_SFc1_torque_controllerInstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c1_torque_controller_get_eml_resolved_functions_info
  (void);

/* Function Definitions */
extern void sf_c1_torque_controller_get_check_sum(mxArray *plhs[]);
extern void c1_torque_controller_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
