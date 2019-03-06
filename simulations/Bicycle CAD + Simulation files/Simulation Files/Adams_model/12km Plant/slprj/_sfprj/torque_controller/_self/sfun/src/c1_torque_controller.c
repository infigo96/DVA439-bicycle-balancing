/* Include files */

#include "torque_controller_sfun.h"
#include "c1_torque_controller.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "torque_controller_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(S);
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization);
static void chart_debug_initialize_data_addresses(SimStruct *S);
static const mxArray* sf_opaque_get_hover_data_for_msg(void *chartInstance,
  int32_T msgSSID);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c1_debug_family_names[4] = { "s", "nargin", "nargout", "y" };

/* Function Declarations */
static void initialize_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void initialize_params_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance);
static void enable_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void disable_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void c1_update_debugger_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance);
static void set_sim_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance, const mxArray *c1_st);
static void finalize_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void sf_gateway_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void mdl_start_c1_torque_controller(SFc1_torque_controllerInstanceStruct *
  chartInstance);
static void initSimStructsc1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static void c1_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  c1_s1eTpAM3l49H1qmKQgaS0pB *c1_b_y);
static uint32_T c1_b_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  uint32_T c1_b_y[625]);
static void c1_d_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  uint32_T c1_b_y[2]);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static real_T c1_e_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_nargin, const char_T *c1_identifier);
static real_T c1_f_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static void c1_rng(SFc1_torque_controllerInstanceStruct *chartInstance,
                   c1_s1eTpAM3l49H1qmKQgaS0pB *c1_settings);
static real_T c1_now(SFc1_torque_controllerInstanceStruct *chartInstance);
static real_T c1_mod(SFc1_torque_controllerInstanceStruct *chartInstance, real_T
                     c1_x);
static void c1_error(SFc1_torque_controllerInstanceStruct *chartInstance);
static real_T c1_rand(SFc1_torque_controllerInstanceStruct *chartInstance);
static void c1_eml_rand_mt19937ar(SFc1_torque_controllerInstanceStruct
  *chartInstance, uint32_T c1_e_state[625], uint32_T c1_f_state[625], real_T
  *c1_r);
static void c1_b_error(SFc1_torque_controllerInstanceStruct *chartInstance);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_g_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint32_T c1_h_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_c_method, const char_T *c1_identifier,
  boolean_T *c1_svPtr);
static uint32_T c1_i_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr);
static void c1_j_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_e_state, const char_T *c1_identifier,
  boolean_T *c1_svPtr, uint32_T c1_b_y[625]);
static void c1_k_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr, uint32_T c1_b_y[625]);
static void c1_l_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_e_state, const char_T *c1_identifier,
  boolean_T *c1_svPtr, uint32_T c1_b_y[2]);
static void c1_m_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr, uint32_T c1_b_y[2]);
static uint8_T c1_n_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_torque_controller, const
  char_T *c1_identifier);
static uint8_T c1_o_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static real_T c1_b_eml_rand_mt19937ar(SFc1_torque_controllerInstanceStruct
  *chartInstance, uint32_T c1_e_state[625]);
static void init_dsm_address_info(SFc1_torque_controllerInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc1_torque_controllerInstanceStruct
  *chartInstance);

/* Function Definitions */
static void initialize_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc1_torque_controller(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  sim_mode_is_external(chartInstance->S);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_seed_not_empty = false;
  chartInstance->c1_method_not_empty = false;
  chartInstance->c1_b_method_not_empty = false;
  chartInstance->c1_state_not_empty = false;
  chartInstance->c1_b_state_not_empty = false;
  chartInstance->c1_c_state_not_empty = false;
  chartInstance->c1_d_state_not_empty = false;
  chartInstance->c1_is_active_c1_torque_controller = 0U;
  setLegacyDebuggerFlagForRuntime(chartInstance->S, true);
}

static void initialize_params_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_b_y = NULL;
  real_T c1_hoistedGlobal;
  const mxArray *c1_c_y = NULL;
  uint32_T c1_b_hoistedGlobal;
  const mxArray *c1_d_y = NULL;
  uint32_T c1_c_hoistedGlobal;
  const mxArray *c1_e_y = NULL;
  uint32_T c1_d_hoistedGlobal;
  const mxArray *c1_f_y = NULL;
  uint32_T c1_e_hoistedGlobal;
  const mxArray *c1_g_y = NULL;
  int32_T c1_i0;
  const mxArray *c1_h_y = NULL;
  uint32_T c1_f_hoistedGlobal[625];
  int32_T c1_i1;
  const mxArray *c1_i_y = NULL;
  uint32_T c1_g_hoistedGlobal[2];
  int32_T c1_i2;
  const mxArray *c1_j_y = NULL;
  uint8_T c1_h_hoistedGlobal;
  const mxArray *c1_k_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_createcellmatrix(9, 1), false);
  c1_hoistedGlobal = *chartInstance->c1_y;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_hoistedGlobal, 0, 0U, 0U, 0U, 0),
                false);
  sf_mex_setcell(c1_b_y, 0, c1_c_y);
  c1_b_hoistedGlobal = chartInstance->c1_method;
  c1_d_y = NULL;
  if (!chartInstance->c1_method_not_empty) {
    sf_mex_assign(&c1_d_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_b_hoistedGlobal, 7, 0U, 0U, 0U,
      0), false);
  }

  sf_mex_setcell(c1_b_y, 1, c1_d_y);
  c1_c_hoistedGlobal = chartInstance->c1_b_method;
  c1_e_y = NULL;
  if (!chartInstance->c1_method_not_empty) {
    sf_mex_assign(&c1_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_e_y, sf_mex_create("y", &c1_c_hoistedGlobal, 7, 0U, 0U, 0U,
      0), false);
  }

  sf_mex_setcell(c1_b_y, 2, c1_e_y);
  c1_d_hoistedGlobal = chartInstance->c1_seed;
  c1_f_y = NULL;
  if (!chartInstance->c1_method_not_empty) {
    sf_mex_assign(&c1_f_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_f_y, sf_mex_create("y", &c1_d_hoistedGlobal, 7, 0U, 0U, 0U,
      0), false);
  }

  sf_mex_setcell(c1_b_y, 3, c1_f_y);
  c1_e_hoistedGlobal = chartInstance->c1_c_state;
  c1_g_y = NULL;
  if (!chartInstance->c1_method_not_empty) {
    sf_mex_assign(&c1_g_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_g_y, sf_mex_create("y", &c1_e_hoistedGlobal, 7, 0U, 0U, 0U,
      0), false);
  }

  sf_mex_setcell(c1_b_y, 4, c1_g_y);
  for (c1_i0 = 0; c1_i0 < 625; c1_i0++) {
    c1_f_hoistedGlobal[c1_i0] = chartInstance->c1_b_state[c1_i0];
  }

  c1_h_y = NULL;
  if (!chartInstance->c1_b_state_not_empty) {
    sf_mex_assign(&c1_h_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_h_y, sf_mex_create("y", c1_f_hoistedGlobal, 7, 0U, 1U, 0U,
      1, 625), false);
  }

  sf_mex_setcell(c1_b_y, 5, c1_h_y);
  for (c1_i1 = 0; c1_i1 < 2; c1_i1++) {
    c1_g_hoistedGlobal[c1_i1] = chartInstance->c1_d_state[c1_i1];
  }

  c1_i_y = NULL;
  if (!chartInstance->c1_d_state_not_empty) {
    sf_mex_assign(&c1_i_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_i_y, sf_mex_create("y", c1_g_hoistedGlobal, 7, 0U, 1U, 0U,
      1, 2), false);
  }

  sf_mex_setcell(c1_b_y, 6, c1_i_y);
  for (c1_i2 = 0; c1_i2 < 2; c1_i2++) {
    c1_g_hoistedGlobal[c1_i2] = chartInstance->c1_state[c1_i2];
  }

  c1_j_y = NULL;
  if (!chartInstance->c1_d_state_not_empty) {
    sf_mex_assign(&c1_j_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    sf_mex_assign(&c1_j_y, sf_mex_create("y", c1_g_hoistedGlobal, 7, 0U, 1U, 0U,
      1, 2), false);
  }

  sf_mex_setcell(c1_b_y, 7, c1_j_y);
  c1_h_hoistedGlobal = chartInstance->c1_is_active_c1_torque_controller;
  c1_k_y = NULL;
  sf_mex_assign(&c1_k_y, sf_mex_create("y", &c1_h_hoistedGlobal, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c1_b_y, 8, c1_k_y);
  sf_mex_assign(&c1_st, c1_b_y, false);
  return c1_st;
}

static void set_sim_state_c1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance, const mxArray *c1_st)
{
  const mxArray *c1_u;
  uint32_T c1_uv0[625];
  int32_T c1_i3;
  uint32_T c1_uv1[2];
  int32_T c1_i4;
  uint32_T c1_uv2[2];
  int32_T c1_i5;
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_u = sf_mex_dup(c1_st);
  *chartInstance->c1_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 0)), "y");
  chartInstance->c1_method = c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 1)), "method", &chartInstance->c1_method_not_empty);
  chartInstance->c1_b_method = c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 2)), "method", &chartInstance->c1_b_method_not_empty);
  chartInstance->c1_seed = c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 3)), "seed", &chartInstance->c1_seed_not_empty);
  chartInstance->c1_c_state = c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c1_u, 4)), "state", &chartInstance->c1_c_state_not_empty);
  c1_j_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 5)),
                        "state", &chartInstance->c1_b_state_not_empty, c1_uv0);
  for (c1_i3 = 0; c1_i3 < 625; c1_i3++) {
    chartInstance->c1_b_state[c1_i3] = c1_uv0[c1_i3];
  }

  c1_l_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 6)),
                        "state", &chartInstance->c1_d_state_not_empty, c1_uv1);
  for (c1_i4 = 0; c1_i4 < 2; c1_i4++) {
    chartInstance->c1_d_state[c1_i4] = c1_uv1[c1_i4];
  }

  c1_l_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 7)),
                        "state", &chartInstance->c1_state_not_empty, c1_uv2);
  for (c1_i5 = 0; c1_i5 < 2; c1_i5++) {
    chartInstance->c1_state[c1_i5] = c1_uv2[c1_i5];
  }

  chartInstance->c1_is_active_c1_torque_controller = c1_n_emlrt_marshallIn
    (chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 8)),
     "is_active_c1_torque_controller");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_torque_controller(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  sfListenerLightTerminate(chartInstance->c1_RuntimeVar);
}

static void sf_gateway_c1_torque_controller(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  uint32_T c1_debug_family_var_map[4];
  c1_s1eTpAM3l49H1qmKQgaS0pB c1_s;
  real_T c1_nargin = 0.0;
  real_T c1_nargout = 1.0;
  real_T c1_b_y;
  c1_s1eTpAM3l49H1qmKQgaS0pB c1_r0;
  const mxArray *c1_c_y = NULL;
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0, chartInstance->c1_sfEvent);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 4U, 4U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_s, 0U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 1U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 2U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_b_y, 3U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 3);
  c1_rng(chartInstance, &c1_r0);
  c1_s = c1_r0;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
  c1_b_y = c1_rand(chartInstance);
  sf_mex_printf("%s =\\n", "y");
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_b_y, 0, 0U, 0U, 0U, 0), false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "disp", 0U, 1U, 14, c1_c_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 5);
  if (CV_EML_IF(0, 1, 0, CV_RELATIONAL_EVAL(4U, 0U, 0, c1_b_y, 0.0, -1, 0U,
        c1_b_y == 0.0))) {
    _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 6);
    c1_b_y = -1.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -6);
  _SFD_SYMBOL_SCOPE_POP();
  *chartInstance->c1_y = c1_b_y;
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_y, 0U);
}

static void mdl_start_c1_torque_controller(SFc1_torque_controllerInstanceStruct *
  chartInstance)
{
  chartInstance->c1_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
}

static void initSimStructsc1_torque_controller
  (SFc1_torque_controllerInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)(c1_machineNumber);
  (void)(c1_chartNumber);
  (void)(c1_instanceNumber);
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  c1_s1eTpAM3l49H1qmKQgaS0pB c1_u;
  const mxArray *c1_b_y = NULL;
  static const char * c1_sv0[4] = { "Method", "Seed", "State",
    "LegacyRandnState" };

  uint32_T c1_b_u;
  const mxArray *c1_c_y = NULL;
  uint32_T c1_c_u;
  const mxArray *c1_d_y = NULL;
  int32_T c1_i6;
  const mxArray *c1_e_y = NULL;
  uint32_T c1_d_u[625];
  int32_T c1_i7;
  const mxArray *c1_f_y = NULL;
  uint32_T c1_e_u[2];
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(c1_s1eTpAM3l49H1qmKQgaS0pB *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_createstruct("structure", 4, c1_sv0, 2, 1, 1),
                false);
  c1_b_u = c1_u.Method;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_b_u, 7, 0U, 0U, 0U, 0), false);
  sf_mex_setfieldbynum(c1_b_y, 0, "Method", c1_c_y, 0);
  c1_c_u = c1_u.Seed;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_c_u, 7, 0U, 0U, 0U, 0), false);
  sf_mex_setfieldbynum(c1_b_y, 0, "Seed", c1_d_y, 1);
  for (c1_i6 = 0; c1_i6 < 625; c1_i6++) {
    c1_d_u[c1_i6] = c1_u.State[c1_i6];
  }

  c1_e_y = NULL;
  sf_mex_assign(&c1_e_y, sf_mex_create("y", c1_d_u, 7, 0U, 1U, 0U, 1, 625),
                false);
  sf_mex_setfieldbynum(c1_b_y, 0, "State", c1_e_y, 2);
  for (c1_i7 = 0; c1_i7 < 2; c1_i7++) {
    c1_e_u[c1_i7] = c1_u.LegacyRandnState[c1_i7];
  }

  c1_f_y = NULL;
  sf_mex_assign(&c1_f_y, sf_mex_create("y", c1_e_u, 7, 0U, 1U, 0U, 1, 2), false);
  sf_mex_setfieldbynum(c1_b_y, 0, "LegacyRandnState", c1_f_y, 3);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static void c1_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  c1_s1eTpAM3l49H1qmKQgaS0pB *c1_b_y)
{
  emlrtMsgIdentifier c1_thisId;
  static const char * c1_fieldNames[4] = { "Method", "Seed", "State",
    "LegacyRandnState" };

  c1_thisId.fParent = c1_parentId;
  c1_thisId.bParentIsCell = false;
  sf_mex_check_struct(c1_parentId, c1_u, 4, c1_fieldNames, 0U, NULL);
  c1_thisId.fIdentifier = "Method";
  c1_b_y->Method = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getfield(c1_u, "Method", "Method", 0)), &c1_thisId);
  c1_thisId.fIdentifier = "Seed";
  c1_b_y->Seed = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getfield
    (c1_u, "Seed", "Seed", 0)), &c1_thisId);
  c1_thisId.fIdentifier = "State";
  c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getfield(c1_u, "State",
    "State", 0)), &c1_thisId, c1_b_y->State);
  c1_thisId.fIdentifier = "LegacyRandnState";
  c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getfield(c1_u,
    "LegacyRandnState", "LegacyRandnState", 0)), &c1_thisId,
                        c1_b_y->LegacyRandnState);
  sf_mex_destroy(&c1_u);
}

static uint32_T c1_b_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint32_T c1_b_y;
  uint32_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 7, 0U, 0, 0U, 0);
  c1_b_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_c_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  uint32_T c1_b_y[625])
{
  uint32_T c1_uv3[625];
  int32_T c1_i8;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_uv3, 1, 7, 0U, 1, 0U, 1, 625);
  for (c1_i8 = 0; c1_i8 < 625; c1_i8++) {
    c1_b_y[c1_i8] = c1_uv3[c1_i8];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_d_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  uint32_T c1_b_y[2])
{
  uint32_T c1_uv4[2];
  int32_T c1_i9;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_uv4, 1, 7, 0U, 1, 0U, 1, 2);
  for (c1_i9 = 0; c1_i9 < 2; c1_i9++) {
    c1_b_y[c1_i9] = c1_uv4[c1_i9];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_s;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  c1_s1eTpAM3l49H1qmKQgaS0pB c1_b_y;
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_s = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_s), &c1_thisId, &c1_b_y);
  sf_mex_destroy(&c1_s);
  *(c1_s1eTpAM3l49H1qmKQgaS0pB *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  real_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_e_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_nargin, const char_T *c1_identifier)
{
  real_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargin),
    &c1_thisId);
  sf_mex_destroy(&c1_nargin);
  return c1_b_y;
}

static real_T c1_f_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_b_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_b_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_nargin;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_b_y;
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_nargin = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargin),
    &c1_thisId);
  sf_mex_destroy(&c1_nargin);
  *(real_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray *sf_c1_torque_controller_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c1_nameCaptureInfo;
}

static void c1_rng(SFc1_torque_controllerInstanceStruct *chartInstance,
                   c1_s1eTpAM3l49H1qmKQgaS0pB *c1_settings)
{
  uint32_T c1_c_method;
  uint32_T c1_randn_method;
  int32_T c1_i10;
  uint32_T c1_varargin_1;
  uint32_T c1_tmethod;
  uint32_T c1_b_varargin_1;
  uint32_T c1_a;
  uint32_T c1_b_a;
  int32_T c1_i11;
  int32_T c1_i12;
  uint32_T c1_legacy_randn_state[2];
  int32_T c1_i13;
  int32_T c1_i14;
  int32_T c1_i15;
  uint32_T c1_e_state[625];
  uint32_T c1_r;
  int32_T c1_i16;
  int32_T c1_i17;
  uint32_T c1_b_r;
  int32_T c1_mti;
  int32_T c1_i18;
  real_T c1_b_mti;
  real_T c1_d1;
  int32_T c1_i19;
  uint32_T c1_u1;
  real_T c1_x;
  real_T c1_b_x;
  real_T c1_s;
  time_t c1_eTime;
  int32_T c1_prevEpochTime;
  time_t c1_b_eTime;
  int32_T c1_t;
  real_T c1_c_x;
  real_T c1_d2;
  real_T c1_d_x;
  real_T c1_s0;
  uint32_T c1_u2;
  uint32_T c1_method2;
  uint32_T c1_hoistedGlobal;
  uint32_T c1_b_hoistedGlobal;
  uint32_T c1_c_varargin_1;
  uint32_T c1_c_hoistedGlobal;
  uint32_T c1_d_varargin_1;
  uint32_T c1_e_varargin_1;
  int32_T c1_i20;
  int32_T c1_i21;
  uint32_T c1_arg3;
  uint32_T c1_b_arg3;
  uint32_T c1_b_seed;
  uint32_T c1_c_arg3;
  uint32_T c1_b_s;
  uint32_T c1_c_r;
  uint32_T c1_d_r;
  uint32_T c1_c_seed;
  uint32_T c1_e_r;
  int32_T c1_c_mti;
  int32_T c1_d_mti;
  uint32_T c1_b_t;
  real_T c1_e_mti;
  real_T c1_f_mti;
  real_T c1_d3;
  real_T c1_d4;
  uint32_T c1_u3;
  uint32_T c1_u4;
  int32_T exitg1;
  if (!chartInstance->c1_seed_not_empty) {
    chartInstance->c1_seed = 0U;
    chartInstance->c1_seed_not_empty = true;
  }

  if (!chartInstance->c1_method_not_empty) {
    chartInstance->c1_method = 7U;
    chartInstance->c1_method_not_empty = true;
  }

  c1_c_method = chartInstance->c1_method;
  if (!chartInstance->c1_b_method_not_empty) {
    chartInstance->c1_b_method = 0U;
    chartInstance->c1_b_method_not_empty = true;
    for (c1_i10 = 0; c1_i10 < 2; c1_i10++) {
      chartInstance->c1_state[c1_i10] = 362436069U + (uint32_T)(-362436069 *
        c1_i10);
    }

    if ((real_T)chartInstance->c1_state[1] == 0.0) {
      chartInstance->c1_state[1] = 521288629U;
    }

    chartInstance->c1_state_not_empty = true;
  }

  c1_randn_method = chartInstance->c1_b_method;
  if (c1_randn_method == 4U) {
    c1_varargin_1 = c1_c_method;
    c1_a = c1_varargin_1;
    c1_tmethod = c1_a | 16384U;
  } else if (c1_randn_method == 5U) {
    c1_b_varargin_1 = c1_c_method;
    c1_b_a = c1_b_varargin_1;
    c1_tmethod = c1_b_a | 32768U;
  } else {
    c1_tmethod = c1_c_method;
  }

  if (!chartInstance->c1_b_method_not_empty) {
    chartInstance->c1_b_method = 0U;
    chartInstance->c1_b_method_not_empty = true;
    for (c1_i12 = 0; c1_i12 < 2; c1_i12++) {
      chartInstance->c1_state[c1_i12] = 362436069U + (uint32_T)(-362436069 *
        c1_i12);
    }

    if ((real_T)chartInstance->c1_state[1] == 0.0) {
      chartInstance->c1_state[1] = 521288629U;
    }

    chartInstance->c1_state_not_empty = true;
  }

  for (c1_i11 = 0; c1_i11 < 2; c1_i11++) {
    c1_legacy_randn_state[c1_i11] = chartInstance->c1_state[c1_i11];
  }

  if (c1_c_method == 7U) {
    if (!chartInstance->c1_b_state_not_empty) {
      for (c1_i14 = 0; c1_i14 < 625; c1_i14++) {
        chartInstance->c1_b_state[c1_i14] = 0U;
      }

      c1_r = 5489U;
      chartInstance->c1_b_state[0] = 5489U;
      for (c1_mti = 0; c1_mti < 623; c1_mti++) {
        c1_b_mti = 2.0 + (real_T)c1_mti;
        c1_d1 = muDoubleScalarRound(c1_b_mti - 1.0);
        if (c1_d1 < 4.294967296E+9) {
          if (c1_d1 >= 0.0) {
            c1_u1 = (uint32_T)c1_d1;
          } else {
            c1_u1 = 0U;
            _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
          }
        } else if (c1_d1 >= 4.294967296E+9) {
          c1_u1 = MAX_uint32_T;
          _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
        } else {
          c1_u1 = 0U;
        }

        c1_r = (c1_r ^ c1_r >> 30U) * 1812433253U + c1_u1;
        chartInstance->c1_b_state[(int32_T)c1_b_mti - 1] = c1_r;
      }

      chartInstance->c1_b_state[624] = 624U;
      chartInstance->c1_b_state_not_empty = true;
    }

    for (c1_i15 = 0; c1_i15 < 625; c1_i15++) {
      c1_e_state[c1_i15] = chartInstance->c1_b_state[c1_i15];
    }
  } else {
    for (c1_i13 = 0; c1_i13 < 625; c1_i13++) {
      c1_e_state[c1_i13] = 0U;
    }

    if (c1_c_method == 4U) {
      if (!chartInstance->c1_c_state_not_empty) {
        chartInstance->c1_c_state = 1144108930U;
        chartInstance->c1_c_state_not_empty = true;
      }

      c1_b_r = chartInstance->c1_c_state;
      c1_e_state[0] = c1_b_r;
    } else {
      if (!chartInstance->c1_d_state_not_empty) {
        for (c1_i16 = 0; c1_i16 < 2; c1_i16++) {
          chartInstance->c1_d_state[c1_i16] = 362436069U + 158852560U *
            (uint32_T)c1_i16;
        }

        chartInstance->c1_d_state_not_empty = true;
      }

      for (c1_i17 = 0; c1_i17 < 2; c1_i17++) {
        c1_e_state[c1_i17] = chartInstance->c1_d_state[c1_i17];
      }
    }
  }

  c1_settings->Method = c1_tmethod;
  c1_settings->Seed = chartInstance->c1_seed;
  for (c1_i18 = 0; c1_i18 < 625; c1_i18++) {
    c1_settings->State[c1_i18] = c1_e_state[c1_i18];
  }

  for (c1_i19 = 0; c1_i19 < 2; c1_i19++) {
    c1_settings->LegacyRandnState[c1_i19] = c1_legacy_randn_state[c1_i19];
  }

  c1_x = c1_now(chartInstance) * 8.64E+6;
  c1_b_x = c1_x;
  c1_b_x = muDoubleScalarFloor(c1_b_x);
  c1_s = c1_mod(chartInstance, c1_b_x);
  c1_eTime = time(NULL);
  c1_prevEpochTime = (int32_T)c1_eTime + 1;
  do {
    exitg1 = 0;
    c1_b_eTime = time(NULL);
    c1_t = (int32_T)c1_b_eTime;
    if (c1_t <= c1_prevEpochTime) {
      c1_c_x = c1_now(chartInstance) * 8.64E+6;
      c1_d_x = c1_c_x;
      c1_d_x = muDoubleScalarFloor(c1_d_x);
      c1_s0 = c1_mod(chartInstance, c1_d_x);
      if (c1_s != c1_s0) {
        exitg1 = 1;
      }
    } else {
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  c1_d2 = muDoubleScalarRound(c1_s);
  if (c1_d2 < 4.294967296E+9) {
    if (c1_d2 >= 0.0) {
      c1_u2 = (uint32_T)c1_d2;
    } else {
      c1_u2 = 0U;
      _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
    }
  } else if (c1_d2 >= 4.294967296E+9) {
    c1_u2 = MAX_uint32_T;
    _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
  } else {
    c1_u2 = 0U;
  }

  chartInstance->c1_seed = c1_u2;
  if (!chartInstance->c1_method_not_empty) {
    chartInstance->c1_method = 7U;
    chartInstance->c1_method_not_empty = true;
  }

  c1_method2 = chartInstance->c1_method;
  if (c1_method2 == 7U) {
    c1_hoistedGlobal = chartInstance->c1_seed;
    c1_c_varargin_1 = c1_hoistedGlobal;
    if (!chartInstance->c1_b_state_not_empty) {
      for (c1_i20 = 0; c1_i20 < 625; c1_i20++) {
        chartInstance->c1_b_state[c1_i20] = 0U;
      }

      c1_d_r = 5489U;
      chartInstance->c1_b_state[0] = 5489U;
      for (c1_d_mti = 0; c1_d_mti < 623; c1_d_mti++) {
        c1_f_mti = 2.0 + (real_T)c1_d_mti;
        c1_d4 = muDoubleScalarRound(c1_f_mti - 1.0);
        if (c1_d4 < 4.294967296E+9) {
          if (c1_d4 >= 0.0) {
            c1_u4 = (uint32_T)c1_d4;
          } else {
            c1_u4 = 0U;
            _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
          }
        } else if (c1_d4 >= 4.294967296E+9) {
          c1_u4 = MAX_uint32_T;
          _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
        } else {
          c1_u4 = 0U;
        }

        c1_d_r = (c1_d_r ^ c1_d_r >> 30U) * 1812433253U + c1_u4;
        chartInstance->c1_b_state[(int32_T)c1_f_mti - 1] = c1_d_r;
      }

      chartInstance->c1_b_state[624] = 624U;
      chartInstance->c1_b_state_not_empty = true;
    }

    c1_arg3 = c1_c_varargin_1;
    c1_b_seed = c1_arg3;
    c1_c_r = c1_b_seed;
    chartInstance->c1_b_state[0] = c1_b_seed;
    for (c1_c_mti = 0; c1_c_mti < 623; c1_c_mti++) {
      c1_e_mti = 2.0 + (real_T)c1_c_mti;
      c1_d3 = muDoubleScalarRound(c1_e_mti - 1.0);
      if (c1_d3 < 4.294967296E+9) {
        if (c1_d3 >= 0.0) {
          c1_u3 = (uint32_T)c1_d3;
        } else {
          c1_u3 = 0U;
          _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
        }
      } else if (c1_d3 >= 4.294967296E+9) {
        c1_u3 = MAX_uint32_T;
        _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
      } else {
        c1_u3 = 0U;
      }

      c1_c_r = (c1_c_r ^ c1_c_r >> 30U) * 1812433253U + c1_u3;
      chartInstance->c1_b_state[(int32_T)c1_e_mti - 1] = c1_c_r;
    }

    chartInstance->c1_b_state[624] = 624U;
  } else if (c1_method2 == 5U) {
    c1_b_hoistedGlobal = chartInstance->c1_seed;
    c1_d_varargin_1 = c1_b_hoistedGlobal;
    if (!chartInstance->c1_d_state_not_empty) {
      for (c1_i21 = 0; c1_i21 < 2; c1_i21++) {
        chartInstance->c1_d_state[c1_i21] = 362436069U + 158852560U * (uint32_T)
          c1_i21;
      }

      chartInstance->c1_d_state_not_empty = true;
    }

    c1_b_arg3 = c1_d_varargin_1;
    c1_b_s = c1_b_arg3;
    chartInstance->c1_d_state[0] = 362436069U;
    chartInstance->c1_d_state[1] = c1_b_s;
    if ((real_T)chartInstance->c1_d_state[1] == 0.0) {
      chartInstance->c1_d_state[1] = 521288629U;
    }
  } else if (c1_method2 == 4U) {
    c1_c_hoistedGlobal = chartInstance->c1_seed;
    c1_e_varargin_1 = c1_c_hoistedGlobal;
    if (!chartInstance->c1_c_state_not_empty) {
      chartInstance->c1_c_state = 1144108930U;
      chartInstance->c1_c_state_not_empty = true;
    }

    c1_c_arg3 = c1_e_varargin_1;
    c1_c_seed = c1_c_arg3;
    c1_e_r = c1_c_seed >> 16U;
    c1_b_t = c1_c_seed & 32768U;
    chartInstance->c1_c_state = c1_e_r << 16U;
    chartInstance->c1_c_state = c1_c_seed - chartInstance->c1_c_state;
    chartInstance->c1_c_state -= c1_b_t;
    chartInstance->c1_c_state <<= 16U;
    chartInstance->c1_c_state += c1_b_t;
    chartInstance->c1_c_state += c1_e_r;
    if ((real_T)chartInstance->c1_c_state < 1.0) {
      chartInstance->c1_c_state = 1144108930U;
    } else {
      if (chartInstance->c1_c_state > 2147483646U) {
        chartInstance->c1_c_state = 2147483646U;
      }
    }
  } else {
    c1_error(chartInstance);
  }
}

static real_T c1_now(SFc1_torque_controllerInstanceStruct *chartInstance)
{
  real_T c1_cDaysMonthWise[12];
  time_t c1_rawtime;
  struct tm c1_timeinfo;
  c1_sxaDueAh1f53T9ESYg9Uc4E c1_timeinfoDouble;
  real_T c1_x;
  real_T c1_b_x;
  real_T c1_c_x;
  real_T c1_d_x;
  real_T c1_e_x;
  real_T c1_f_x;
  real_T c1_dDateNum;
  real_T c1_g_x;
  real_T c1_h_x;
  real_T c1_i_x;
  real_T c1_j_x;
  real_T c1_k_x;
  real_T c1_l_x;
  boolean_T c1_b;
  boolean_T c1_b0;
  real_T c1_m_x;
  boolean_T c1_b_b;
  boolean_T c1_b1;
  boolean_T c1_c_b;
  real_T c1_r;
  boolean_T c1_rEQ0;
  real_T c1_n_x;
  real_T c1_o_x;
  real_T c1_p_x;
  real_T c1_q_x;
  real_T c1_r_x;
  real_T c1_s_x;
  real_T c1_t_x;
  real_T c1_u_x;
  real_T c1_v_x;
  real_T c1_w_x;
  real_T c1_x_x;
  real_T c1_y_x;
  boolean_T c1_d_b;
  boolean_T c1_e_b;
  boolean_T c1_b2;
  boolean_T c1_b3;
  real_T c1_ab_x;
  real_T c1_bb_x;
  boolean_T c1_f_b;
  boolean_T c1_g_b;
  boolean_T c1_b4;
  boolean_T c1_b5;
  boolean_T c1_h_b;
  boolean_T c1_i_b;
  real_T c1_b_r;
  real_T c1_c_r;
  boolean_T c1_b_rEQ0;
  boolean_T c1_c_rEQ0;
  boolean_T guard1 = false;
  (void)chartInstance;
  c1_cDaysMonthWise[0] = 0.0;
  c1_cDaysMonthWise[1] = 31.0;
  c1_cDaysMonthWise[2] = 59.0;
  c1_cDaysMonthWise[3] = 90.0;
  c1_cDaysMonthWise[4] = 120.0;
  c1_cDaysMonthWise[5] = 151.0;
  c1_cDaysMonthWise[6] = 181.0;
  c1_cDaysMonthWise[7] = 212.0;
  c1_cDaysMonthWise[8] = 243.0;
  c1_cDaysMonthWise[9] = 273.0;
  c1_cDaysMonthWise[10] = 304.0;
  c1_cDaysMonthWise[11] = 334.0;
  time(&c1_rawtime);
  c1_timeinfo = *localtime(&c1_rawtime);
  c1_timeinfo.tm_year += 1900;
  c1_timeinfo.tm_mon++;
  c1_timeinfoDouble.tm_min = (real_T)c1_timeinfo.tm_min;
  c1_timeinfoDouble.tm_sec = (real_T)c1_timeinfo.tm_sec;
  c1_timeinfoDouble.tm_hour = (real_T)c1_timeinfo.tm_hour;
  c1_timeinfoDouble.tm_mday = (real_T)c1_timeinfo.tm_mday;
  c1_timeinfoDouble.tm_mon = (real_T)c1_timeinfo.tm_mon;
  c1_timeinfoDouble.tm_year = (real_T)c1_timeinfo.tm_year;
  c1_x = c1_timeinfoDouble.tm_year / 4.0;
  c1_b_x = c1_x;
  c1_b_x = muDoubleScalarCeil(c1_b_x);
  c1_c_x = c1_timeinfoDouble.tm_year / 100.0;
  c1_d_x = c1_c_x;
  c1_d_x = muDoubleScalarCeil(c1_d_x);
  c1_e_x = c1_timeinfoDouble.tm_year / 400.0;
  c1_f_x = c1_e_x;
  c1_f_x = muDoubleScalarCeil(c1_f_x);
  c1_dDateNum = ((((365.0 * c1_timeinfoDouble.tm_year + c1_b_x) - c1_d_x) +
                  c1_f_x) + c1_cDaysMonthWise[(int32_T)c1_timeinfoDouble.tm_mon
                 - 1]) + c1_timeinfoDouble.tm_mday;
  if (c1_timeinfoDouble.tm_mon > 2.0) {
    c1_g_x = c1_timeinfoDouble.tm_year;
    c1_h_x = c1_g_x;
    c1_i_x = c1_h_x;
    c1_j_x = c1_i_x;
    c1_k_x = c1_j_x;
    c1_l_x = c1_k_x;
    c1_b = muDoubleScalarIsInf(c1_l_x);
    c1_b0 = !c1_b;
    c1_m_x = c1_k_x;
    c1_b_b = muDoubleScalarIsNaN(c1_m_x);
    c1_b1 = !c1_b_b;
    c1_c_b = (c1_b0 && c1_b1);
    if (c1_c_b) {
      if (c1_j_x == 0.0) {
        c1_r = 0.0;
      } else {
        c1_r = muDoubleScalarRem(c1_j_x, 4.0);
        c1_rEQ0 = (c1_r == 0.0);
        if (c1_rEQ0) {
          c1_r = 0.0;
        } else {
          if (c1_j_x < 0.0) {
            c1_r += 4.0;
          }
        }
      }
    } else {
      c1_r = rtNaN;
    }

    guard1 = false;
    if (c1_r == 0.0) {
      c1_n_x = c1_timeinfoDouble.tm_year;
      c1_p_x = c1_n_x;
      c1_r_x = c1_p_x;
      c1_t_x = c1_r_x;
      c1_v_x = c1_t_x;
      c1_x_x = c1_v_x;
      c1_d_b = muDoubleScalarIsInf(c1_x_x);
      c1_b2 = !c1_d_b;
      c1_ab_x = c1_v_x;
      c1_f_b = muDoubleScalarIsNaN(c1_ab_x);
      c1_b4 = !c1_f_b;
      c1_h_b = (c1_b2 && c1_b4);
      if (c1_h_b) {
        if (c1_t_x == 0.0) {
          c1_b_r = 0.0;
        } else {
          c1_b_r = muDoubleScalarRem(c1_t_x, 100.0);
          c1_b_rEQ0 = (c1_b_r == 0.0);
          if (c1_b_rEQ0) {
            c1_b_r = 0.0;
          } else {
            if (c1_t_x < 0.0) {
              c1_b_r += 100.0;
            }
          }
        }
      } else {
        c1_b_r = rtNaN;
      }

      if (c1_b_r == 0.0) {
        c1_dDateNum++;
      } else {
        guard1 = true;
      }
    } else {
      guard1 = true;
    }

    if (guard1) {
      c1_o_x = c1_timeinfoDouble.tm_year;
      c1_q_x = c1_o_x;
      c1_s_x = c1_q_x;
      c1_u_x = c1_s_x;
      c1_w_x = c1_u_x;
      c1_y_x = c1_w_x;
      c1_e_b = muDoubleScalarIsInf(c1_y_x);
      c1_b3 = !c1_e_b;
      c1_bb_x = c1_w_x;
      c1_g_b = muDoubleScalarIsNaN(c1_bb_x);
      c1_b5 = !c1_g_b;
      c1_i_b = (c1_b3 && c1_b5);
      if (c1_i_b) {
        if (c1_u_x == 0.0) {
          c1_c_r = 0.0;
        } else {
          c1_c_r = muDoubleScalarRem(c1_u_x, 400.0);
          c1_c_rEQ0 = (c1_c_r == 0.0);
          if (c1_c_rEQ0) {
            c1_c_r = 0.0;
          } else {
            if (c1_u_x < 0.0) {
              c1_c_r += 400.0;
            }
          }
        }
      } else {
        c1_c_r = rtNaN;
      }

      if (c1_c_r == 0.0) {
        c1_dDateNum++;
      }
    }
  }

  c1_dDateNum += ((c1_timeinfoDouble.tm_hour * 3600.0 + c1_timeinfoDouble.tm_min
                   * 60.0) + c1_timeinfoDouble.tm_sec) / 86400.0;
  return c1_dDateNum;
}

static real_T c1_mod(SFc1_torque_controllerInstanceStruct *chartInstance, real_T
                     c1_x)
{
  real_T c1_r;
  real_T c1_b_x;
  real_T c1_c_x;
  real_T c1_d_x;
  real_T c1_e_x;
  real_T c1_f_x;
  boolean_T c1_b;
  boolean_T c1_b6;
  real_T c1_g_x;
  boolean_T c1_b_b;
  boolean_T c1_b7;
  boolean_T c1_c_b;
  boolean_T c1_rEQ0;
  (void)chartInstance;
  c1_b_x = c1_x;
  c1_c_x = c1_b_x;
  c1_d_x = c1_c_x;
  c1_e_x = c1_d_x;
  c1_f_x = c1_e_x;
  c1_b = muDoubleScalarIsInf(c1_f_x);
  c1_b6 = !c1_b;
  c1_g_x = c1_e_x;
  c1_b_b = muDoubleScalarIsNaN(c1_g_x);
  c1_b7 = !c1_b_b;
  c1_c_b = (c1_b6 && c1_b7);
  if (c1_c_b) {
    if (c1_d_x == 0.0) {
      c1_r = 0.0;
    } else {
      c1_r = muDoubleScalarRem(c1_d_x, 2.147483647E+9);
      c1_rEQ0 = (c1_r == 0.0);
      if (c1_rEQ0) {
        c1_r = 0.0;
      } else {
        if (c1_d_x < 0.0) {
          c1_r += 2.147483647E+9;
        }
      }
    }
  } else {
    c1_r = rtNaN;
  }

  return c1_r;
}

static void c1_error(SFc1_torque_controllerInstanceStruct *chartInstance)
{
  const mxArray *c1_b_y = NULL;
  static char_T c1_cv0[22] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'r', 'n', 'g',
    ':', 'b', 'a', 'd', 'S', 'e', 't', 't', 'i', 'n', 'g', 's' };

  const mxArray *c1_c_y = NULL;
  (void)chartInstance;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_cv0, 10, 0U, 1U, 0U, 2, 1, 22),
                false);
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_cv0, 10, 0U, 1U, 0U, 2, 1, 22),
                false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "error", 0U, 2U, 14, c1_b_y, 14,
                    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "getString",
    1U, 1U, 14, sf_mex_call_debug(sfGlobalDebugInstanceStruct, "message", 1U, 1U,
    14, c1_c_y)));
}

static real_T c1_rand(SFc1_torque_controllerInstanceStruct *chartInstance)
{
  real_T c1_r;
  int32_T c1_i22;
  int32_T c1_i23;
  uint32_T c1_hoistedGlobal;
  real_T c1_d5;
  uint32_T c1_icng;
  uint32_T c1_e_state;
  uint32_T c1_jsr;
  uint32_T c1_f_state;
  uint32_T c1_b_r;
  uint32_T c1_u5;
  uint32_T c1_s;
  uint32_T c1_u6;
  uint32_T c1_hi;
  int32_T c1_mti;
  uint32_T c1_lo;
  uint32_T c1_test1;
  uint32_T c1_test2;
  real_T c1_b_mti;
  uint32_T c1_a;
  real_T c1_d6;
  uint32_T c1_ui;
  uint32_T c1_b;
  uint32_T c1_g_state;
  uint32_T c1_u7;
  real_T c1_c_r;
  real_T c1_d7;
  real_T c1_d_r;
  real_T c1_d8;
  if (!chartInstance->c1_method_not_empty) {
    chartInstance->c1_method = 7U;
    chartInstance->c1_method_not_empty = true;
  }

  if (chartInstance->c1_method == 4U) {
    if (!chartInstance->c1_c_state_not_empty) {
      chartInstance->c1_c_state = 1144108930U;
      chartInstance->c1_c_state_not_empty = true;
    }

    c1_hoistedGlobal = chartInstance->c1_c_state;
    c1_e_state = c1_hoistedGlobal;
    c1_f_state = c1_e_state;
    c1_s = c1_f_state;
    c1_hi = c1_s / 127773U;
    c1_lo = c1_s - c1_hi * 127773U;
    c1_test1 = 16807U * c1_lo;
    c1_test2 = 2836U * c1_hi;
    c1_a = c1_test1;
    c1_b = c1_test2;
    if (c1_a < c1_b) {
      c1_g_state = c1_b - c1_a;
      c1_g_state = ~c1_g_state;
      c1_g_state &= 2147483647U;
    } else {
      c1_g_state = c1_a - c1_b;
    }

    c1_d_r = (real_T)c1_g_state * 4.6566128752457969E-10;
    c1_f_state = c1_g_state;
    c1_d8 = c1_d_r;
    chartInstance->c1_c_state = c1_f_state;
    c1_r = c1_d8;
  } else if (chartInstance->c1_method == 5U) {
    if (!chartInstance->c1_d_state_not_empty) {
      for (c1_i23 = 0; c1_i23 < 2; c1_i23++) {
        chartInstance->c1_d_state[c1_i23] = 362436069U + 158852560U * (uint32_T)
          c1_i23;
      }

      chartInstance->c1_d_state_not_empty = true;
    }

    c1_icng = chartInstance->c1_d_state[0];
    c1_jsr = chartInstance->c1_d_state[1];
    c1_u5 = c1_jsr;
    c1_u6 = c1_icng;
    c1_u6 = 69069U * c1_u6 + 1234567U;
    c1_u5 ^= c1_u5 << 13;
    c1_u5 ^= c1_u5 >> 17;
    c1_u5 ^= c1_u5 << 5;
    c1_ui = c1_u6 + c1_u5;
    chartInstance->c1_d_state[0] = c1_u6;
    chartInstance->c1_d_state[1] = c1_u5;
    c1_c_r = (real_T)c1_ui * 2.328306436538696E-10;
    c1_d7 = c1_c_r;
    c1_r = c1_d7;
  } else {
    if (!chartInstance->c1_b_state_not_empty) {
      for (c1_i22 = 0; c1_i22 < 625; c1_i22++) {
        chartInstance->c1_b_state[c1_i22] = 0U;
      }

      c1_b_r = 5489U;
      chartInstance->c1_b_state[0] = 5489U;
      for (c1_mti = 0; c1_mti < 623; c1_mti++) {
        c1_b_mti = 2.0 + (real_T)c1_mti;
        c1_d6 = muDoubleScalarRound(c1_b_mti - 1.0);
        if (c1_d6 < 4.294967296E+9) {
          if (c1_d6 >= 0.0) {
            c1_u7 = (uint32_T)c1_d6;
          } else {
            c1_u7 = 0U;
            _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
          }
        } else if (c1_d6 >= 4.294967296E+9) {
          c1_u7 = MAX_uint32_T;
          _SFD_OVERFLOW_DETECTION(SFDB_SATURATE, 1U, 0U, 0U);
        } else {
          c1_u7 = 0U;
        }

        c1_b_r = (c1_b_r ^ c1_b_r >> 30U) * 1812433253U + c1_u7;
        chartInstance->c1_b_state[(int32_T)c1_b_mti - 1] = c1_b_r;
      }

      chartInstance->c1_b_state[624] = 624U;
      chartInstance->c1_b_state_not_empty = true;
    }

    c1_d5 = c1_b_eml_rand_mt19937ar(chartInstance, chartInstance->c1_b_state);
    c1_r = c1_d5;
  }

  return c1_r;
}

static void c1_eml_rand_mt19937ar(SFc1_torque_controllerInstanceStruct
  *chartInstance, uint32_T c1_e_state[625], uint32_T c1_f_state[625], real_T
  *c1_r)
{
  int32_T c1_i24;
  for (c1_i24 = 0; c1_i24 < 625; c1_i24++) {
    c1_f_state[c1_i24] = c1_e_state[c1_i24];
  }

  *c1_r = c1_b_eml_rand_mt19937ar(chartInstance, c1_f_state);
}

static void c1_b_error(SFc1_torque_controllerInstanceStruct *chartInstance)
{
  const mxArray *c1_b_y = NULL;
  static char_T c1_cv1[37] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T', 'L',
    'A', 'B', ':', 'r', 'a', 'n', 'd', '_', 'i', 'n', 'v', 'a', 'l', 'i', 'd',
    'T', 'w', 'i', 's', 't', 'e', 'r', 'S', 't', 'a', 't', 'e' };

  const mxArray *c1_c_y = NULL;
  (void)chartInstance;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_cv1, 10, 0U, 1U, 0U, 2, 1, 37),
                false);
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_cv1, 10, 0U, 1U, 0U, 2, 1, 37),
                false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "error", 0U, 2U, 14, c1_b_y, 14,
                    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "getString",
    1U, 1U, 14, sf_mex_call_debug(sfGlobalDebugInstanceStruct, "message", 1U, 1U,
    14, c1_c_y)));
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData;
  int32_T c1_u;
  const mxArray *c1_b_y = NULL;
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_b_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_g_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_b_y;
  int32_T c1_i25;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i25, 1, 6, 0U, 0, 0U, 0);
  c1_b_y = c1_i25;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_b_y;
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_g_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_b_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint32_T c1_h_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_c_method, const char_T *c1_identifier,
  boolean_T *c1_svPtr)
{
  uint32_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_i_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_c_method),
    &c1_thisId, c1_svPtr);
  sf_mex_destroy(&c1_c_method);
  return c1_b_y;
}

static uint32_T c1_i_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr)
{
  uint32_T c1_b_y;
  uint32_T c1_u8;
  (void)chartInstance;
  if (mxIsEmpty(c1_u)) {
    *c1_svPtr = false;
  } else {
    *c1_svPtr = true;
    sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u8, 1, 7, 0U, 0, 0U, 0);
    c1_b_y = c1_u8;
  }

  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static void c1_j_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_e_state, const char_T *c1_identifier,
  boolean_T *c1_svPtr, uint32_T c1_b_y[625])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_k_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_e_state), &c1_thisId,
                        c1_svPtr, c1_b_y);
  sf_mex_destroy(&c1_e_state);
}

static void c1_k_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr, uint32_T c1_b_y[625])
{
  uint32_T c1_uv5[625];
  int32_T c1_i26;
  (void)chartInstance;
  if (mxIsEmpty(c1_u)) {
    *c1_svPtr = false;
  } else {
    *c1_svPtr = true;
    sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_uv5, 1, 7, 0U, 1, 0U, 1, 625);
    for (c1_i26 = 0; c1_i26 < 625; c1_i26++) {
      c1_b_y[c1_i26] = c1_uv5[c1_i26];
    }
  }

  sf_mex_destroy(&c1_u);
}

static void c1_l_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_e_state, const char_T *c1_identifier,
  boolean_T *c1_svPtr, uint32_T c1_b_y[2])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_m_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_e_state), &c1_thisId,
                        c1_svPtr, c1_b_y);
  sf_mex_destroy(&c1_e_state);
}

static void c1_m_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId,
  boolean_T *c1_svPtr, uint32_T c1_b_y[2])
{
  uint32_T c1_uv6[2];
  int32_T c1_i27;
  (void)chartInstance;
  if (mxIsEmpty(c1_u)) {
    *c1_svPtr = false;
  } else {
    *c1_svPtr = true;
    sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_uv6, 1, 7, 0U, 1, 0U, 1, 2);
    for (c1_i27 = 0; c1_i27 < 2; c1_i27++) {
      c1_b_y[c1_i27] = c1_uv6[c1_i27];
    }
  }

  sf_mex_destroy(&c1_u);
}

static uint8_T c1_n_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_b_is_active_c1_torque_controller, const
  char_T *c1_identifier)
{
  uint8_T c1_b_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = (const char *)c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_b_y = c1_o_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_torque_controller), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_torque_controller);
  return c1_b_y;
}

static uint8_T c1_o_emlrt_marshallIn(SFc1_torque_controllerInstanceStruct
  *chartInstance, const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_b_y;
  uint8_T c1_u9;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u9, 1, 3, 0U, 0, 0U, 0);
  c1_b_y = c1_u9;
  sf_mex_destroy(&c1_u);
  return c1_b_y;
}

static real_T c1_b_eml_rand_mt19937ar(SFc1_torque_controllerInstanceStruct
  *chartInstance, uint32_T c1_e_state[625])
{
  int32_T c1_j;
  uint32_T c1_u[2];
  real_T c1_b_j;
  uint32_T c1_mti;
  real_T c1_b_r;
  int32_T c1_kk;
  uint32_T c1_b_y;
  boolean_T c1_isvalid;
  int32_T c1_b_kk;
  real_T c1_c_kk;
  boolean_T c1_b_isvalid;
  uint32_T c1_c_y;
  uint32_T c1_d_y;
  uint32_T c1_e_y;
  int32_T c1_k;
  uint32_T c1_f_y;
  uint32_T c1_g_y;
  uint32_T c1_h_y;
  int32_T c1_a;
  int32_T exitg1;
  boolean_T exitg2;

  /* ========================= COPYRIGHT NOTICE ============================ */
  /*  This is a uniform (0,1) pseudorandom number generator based on:        */
  /*                                                                         */
  /*  A C-program for MT19937, with initialization improved 2002/1/26.       */
  /*  Coded by Takuji Nishimura and Makoto Matsumoto.                        */
  /*                                                                         */
  /*  Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura,      */
  /*  All rights reserved.                                                   */
  /*                                                                         */
  /*  Redistribution and use in source and binary forms, with or without     */
  /*  modification, are permitted provided that the following conditions     */
  /*  are met:                                                               */
  /*                                                                         */
  /*    1. Redistributions of source code must retain the above copyright    */
  /*       notice, this list of conditions and the following disclaimer.     */
  /*                                                                         */
  /*    2. Redistributions in binary form must reproduce the above copyright */
  /*       notice, this list of conditions and the following disclaimer      */
  /*       in the documentation and/or other materials provided with the     */
  /*       distribution.                                                     */
  /*                                                                         */
  /*    3. The names of its contributors may not be used to endorse or       */
  /*       promote products derived from this software without specific      */
  /*       prior written permission.                                         */
  /*                                                                         */
  /*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    */
  /*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      */
  /*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  */
  /*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT  */
  /*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  */
  /*  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       */
  /*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  */
  /*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  */
  /*  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    */
  /*  (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE */
  /*  OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  */
  /*                                                                         */
  /* =============================   END   ================================= */
  do {
    exitg1 = 0;
    for (c1_j = 0; c1_j < 2; c1_j++) {
      c1_b_j = 1.0 + (real_T)c1_j;
      c1_mti = c1_e_state[624] + 1U;
      if ((real_T)c1_mti >= 625.0) {
        for (c1_kk = 0; c1_kk < 227; c1_kk++) {
          c1_c_kk = 1.0 + (real_T)c1_kk;
          c1_b_y = (c1_e_state[(int32_T)c1_c_kk - 1] & 2147483648U) |
            (c1_e_state[(int32_T)(c1_c_kk + 1.0) - 1] & 2147483647U);
          c1_c_y = c1_b_y;
          c1_d_y = c1_c_y;
          if ((c1_d_y & 1U) == 0U) {
            c1_d_y >>= 1U;
          } else {
            c1_d_y = c1_d_y >> 1U ^ 2567483615U;
          }

          c1_e_state[(int32_T)c1_c_kk - 1] = c1_e_state[(int32_T)(c1_c_kk +
            397.0) - 1] ^ c1_d_y;
        }

        for (c1_b_kk = 0; c1_b_kk < 396; c1_b_kk++) {
          c1_c_kk = 228.0 + (real_T)c1_b_kk;
          c1_b_y = (c1_e_state[(int32_T)c1_c_kk - 1] & 2147483648U) |
            (c1_e_state[(int32_T)(c1_c_kk + 1.0) - 1] & 2147483647U);
          c1_g_y = c1_b_y;
          c1_h_y = c1_g_y;
          if ((c1_h_y & 1U) == 0U) {
            c1_h_y >>= 1U;
          } else {
            c1_h_y = c1_h_y >> 1U ^ 2567483615U;
          }

          c1_e_state[(int32_T)c1_c_kk - 1] = c1_e_state[(int32_T)((c1_c_kk + 1.0)
            - 228.0) - 1] ^ c1_h_y;
        }

        c1_b_y = (c1_e_state[623] & 2147483648U) | (c1_e_state[0] & 2147483647U);
        c1_e_y = c1_b_y;
        c1_f_y = c1_e_y;
        if ((c1_f_y & 1U) == 0U) {
          c1_f_y >>= 1U;
        } else {
          c1_f_y = c1_f_y >> 1U ^ 2567483615U;
        }

        c1_e_state[623] = c1_e_state[396] ^ c1_f_y;
        c1_mti = 1U;
      }

      c1_b_y = c1_e_state[(int32_T)c1_mti - 1];
      c1_e_state[624] = c1_mti;
      c1_b_y ^= c1_b_y >> 11U;
      c1_b_y ^= c1_b_y << 7U & 2636928640U;
      c1_b_y ^= c1_b_y << 15U & 4022730752U;
      c1_b_y ^= c1_b_y >> 18U;
      c1_u[(int32_T)c1_b_j - 1] = c1_b_y;
    }

    c1_u[0] >>= 5U;
    c1_u[1] >>= 6U;
    c1_b_r = 1.1102230246251565E-16 * ((real_T)c1_u[0] * 6.7108864E+7 + (real_T)
      c1_u[1]);
    if (c1_b_r == 0.0) {
      if (((real_T)c1_e_state[624] >= 1.0) && ((real_T)c1_e_state[624] < 625.0))
      {
        c1_isvalid = true;
      } else {
        c1_isvalid = false;
      }

      c1_b_isvalid = c1_isvalid;
      if (c1_isvalid) {
        c1_b_isvalid = false;
        c1_k = 0;
        exitg2 = false;
        while ((!exitg2) && (c1_k + 1 < 625)) {
          if ((real_T)c1_e_state[c1_k] == 0.0) {
            c1_a = c1_k + 1;
            c1_k = c1_a;
          } else {
            c1_b_isvalid = true;
            exitg2 = true;
          }
        }
      }

      if (!c1_b_isvalid) {
        c1_b_error(chartInstance);
      }
    } else {
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  return c1_b_r;
}

static void init_dsm_address_info(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc1_torque_controllerInstanceStruct
  *chartInstance)
{
  chartInstance->c1_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c1_y = (real_T *)ssGetOutputPortSignal_wrapper(chartInstance->S,
    1);
}

/* SFunction Glue Code */
void sf_c1_torque_controller_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1855545492U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1467131619U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1843634273U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3784350896U);
}

mxArray* sf_c1_torque_controller_get_post_codegen_info(void);
mxArray *sf_c1_torque_controller_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("gKbfiEJy7lqhRmGM3PcD4G");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo = sf_c1_torque_controller_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_torque_controller_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_torque_controller_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("late");
  mxArray *fallbackReason = mxCreateString("ir_function_calls");
  mxArray *hiddenFallbackType = mxCreateString("");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("time");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c1_torque_controller_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c1_torque_controller_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c1_torque_controller(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x9'type','srcId','name','auxInfo'{{M[1],M[5],T\"y\",},{M[4],M[0],T\"method\",S'l','i','p'{{M1x2[523 529],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_rand.m\"}}},{M[4],M[0],T\"method\",S'l','i','p'{{M1x2[683 689],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_randn.m\"}}},{M[4],M[0],T\"seed\",S'l','i','p'{{M1x2[1082 1086],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\rng.m\"}}},{M[4],M[0],T\"state\",S'l','i','p'{{M1x2[165 170],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_rand_mcg16807_stateful.m\"}}},{M[4],M[0],T\"state\",S'l','i','p'{{M1x2[166 171],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_rand_mt19937ar_stateful.m\"}}},{M[4],M[0],T\"state\",S'l','i','p'{{M1x2[165 170],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_rand_shr3cong_stateful.m\"}}},{M[4],M[0],T\"state\",S'l','i','p'{{M1x2[690 695],M[1],T\"C:\\Program Files\\MATLAB\\R2018b\\toolbox\\eml\\lib\\matlab\\randfun\\private\\eml_randn.m\"}}},{M[8],M[0],T\"is_active_c1_torque_controller\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 9, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_torque_controller_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_torque_controllerInstanceStruct *chartInstance =
      (SFc1_torque_controllerInstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _torque_controllerMachineNumber_,
           1,
           1,
           1,
           0,
           1,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_torque_controllerMachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_torque_controllerMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _torque_controllerMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,2,0,1,"y");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,1,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,77);
        _SFD_CV_INIT_EML_IF(0,1,0,50,59,-1,76);
        _SFD_CV_INIT_EML_RELATIONAL(0,1,0,53,59,-1,0);
        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_b_sf_marshallOut,(MexInFcnForType)c1_b_sf_marshallIn);
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _torque_controllerMachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_torque_controllerInstanceStruct *chartInstance =
      (SFc1_torque_controllerInstanceStruct *)sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, chartInstance->c1_y);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sesMp8xjYyFlMeUPaJWexWB";
}

static void sf_opaque_initialize_c1_torque_controller(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar)->S,0);
  initialize_params_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
  initialize_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c1_torque_controller(void *chartInstanceVar)
{
  enable_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c1_torque_controller(void *chartInstanceVar)
{
  disable_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c1_torque_controller(void *chartInstanceVar)
{
  sf_gateway_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c1_torque_controller(SimStruct* S)
{
  return get_sim_state_c1_torque_controller
    ((SFc1_torque_controllerInstanceStruct *)sf_get_chart_instance_ptr(S));/* raw sim ctx */
}

static void sf_opaque_set_sim_state_c1_torque_controller(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_terminate_c1_torque_controller(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_torque_controllerInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_torque_controller_optimization_info();
    }

    finalize_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
      chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_torque_controller((SFc1_torque_controllerInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_torque_controller(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_torque_controller((SFc1_torque_controllerInstanceStruct*)
      sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c1_torque_controller(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssSetInputPortDirectFeedThrough(S, 0, 1);
  ssSetStatesModifiedOnlyInUpdate(S, 0);
  ssSetBlockIsPurelyCombinatorial_wrapper(S, 0);
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_torque_controller_optimization_info
      (sim_mode_is_rtw_gen(S), sim_mode_is_modelref_sim(S), sim_mode_is_external
       (S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetSupportedForRowMajorCodeGen(S, 1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,1,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 1);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,1,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=1; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    sf_register_codegen_names_for_scoped_functions_defined_by_chart(S);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(2230303611U));
  ssSetChecksum1(S,(2613466032U));
  ssSetChecksum2(S,(3315598123U));
  ssSetChecksum3(S,(168746730U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_torque_controller(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_torque_controller(SimStruct *S)
{
  SFc1_torque_controllerInstanceStruct *chartInstance;
  chartInstance = (SFc1_torque_controllerInstanceStruct *)utMalloc(sizeof
    (SFc1_torque_controllerInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc1_torque_controllerInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_torque_controller;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_torque_controller;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c1_torque_controller;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c1_torque_controller;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c1_torque_controller;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_torque_controller;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_torque_controller;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_torque_controller;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_torque_controller;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_torque_controller;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_torque_controller;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  chartInstance->chartInfo.dispatchToExportedFcn = NULL;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0, NULL, NULL);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  chart_debug_initialization(S,1);
  mdl_start_c1_torque_controller(chartInstance);
}

void c1_torque_controller_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_torque_controller(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_torque_controller(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_torque_controller(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_torque_controller_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
