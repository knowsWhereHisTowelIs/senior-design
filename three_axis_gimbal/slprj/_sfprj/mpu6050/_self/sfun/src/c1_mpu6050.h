#ifndef __c1_mpu6050_h__
#define __c1_mpu6050_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc1_mpu6050InstanceStruct
#define typedef_SFc1_mpu6050InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  uint8_T c1_SlvAddr;
  uint8_T c1_AccelXRegAddr;
  uint8_T c1_AccelYRegAddr;
  uint8_T c1_AccelZRegAddr;
  uint8_T c1_powerRegData;
  uint8_T c1_powerRegAddr;
  uint8_T c1_GyroXRegAddr;
  uint8_T c1_doSetSimStateSideEffects;
  const mxArray *c1_setSimStateSideEffectsInfo;
  void *c1_fEmlrtCtx;
  int32_T *c1_sfEvent;
  boolean_T *c1_doneDoubleBufferReInit;
  uint8_T *c1_is_active_c1_mpu6050;
  uint8_T *c1_is_c1_mpu6050;
  boolean_T *c1_enb;
  boolean_T *c1_rw;
  boolean_T *c1_mode;
  uint8_T *c1_slv_addr;
  uint8_T *c1_reg_addr;
  boolean_T *c1_reg_byte_mode;
  uint8_T *c1_data_out;
  boolean_T *c1_busy;
  boolean_T *c1_n_ack;
  boolean_T *c1_byte_mode;
  boolean_T *c1_reg_mode;
  uint32_T *c1_cnt;
  uint8_T *c1_data_in;
  boolean_T *c1_mstr_ack;
  int16_T *c1_AccelX;
  int16_T *c1_AccelY;
  int16_T *c1_AccelZ;
  boolean_T *c1_Valid_Out;
  uint8_T *c1_tempVal;
  uint8_T *c1_deviceId;
  uint8_T *c1_regdata;
  uint8_T *c1_userRegAddr;
  boolean_T *c1_configDevice;
  boolean_T *c1_selfInit;
  int16_T *c1_GyroX;
  int16_T *c1_GyroY;
  int16_T *c1_GyroZ;
  boolean_T *c1_tmp;
  boolean_T *c1_tmpConfig;
  boolean_T *c1_tmpCheckCng;
  boolean_T *c1_tmpReadGyro;
  boolean_T *c1_tmpReadAccel;
  boolean_T *c1_tmpValid;
  boolean_T *c1_tmpReadDevice;
  boolean_T *c1_tmpHere;
  uint8_T *c1_tmpData;
} SFc1_mpu6050InstanceStruct;

#endif                                 /*typedef_SFc1_mpu6050InstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c1_mpu6050_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c1_mpu6050_get_check_sum(mxArray *plhs[]);
extern void c1_mpu6050_method_dispatcher(SimStruct *S, int_T method, void *data);

#endif
