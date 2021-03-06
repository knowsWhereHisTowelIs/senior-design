/*
 * gm_mpu6050_interface_dt.h
 *
 * Trial License - for use to evaluate programs for possible purchase as
 * an end-user only.
 *
 * Code generation for model "gm_mpu6050_interface".
 *
<<<<<<< HEAD
 * Model version              : 1.170
 * Simulink Coder version : 8.12 (R2017a) 16-Feb-2017
 * C source code generated on : Wed Nov 29 14:17:28 2017
=======
 * Model version              : 1.279
 * Simulink Coder version : 8.12 (R2017a) 16-Feb-2017
 * C source code generated on : Fri Dec 01 18:35:53 2017
>>>>>>> 4c498d00033ba8e3c1028dad581483e8536e1362
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(zynq_AXIRead_gm_mpu6050_inter_T),
  sizeof(zynq_AXIWrite_gm_mpu6050_inte_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "zynq_AXIRead_gm_mpu6050_inter_T",
  "zynq_AXIWrite_gm_mpu6050_inte_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&gm_mpu6050_interface_B.AXI4Lite_Read_AccelX_DTC), 4, 0, 6 },

  { (char_T *)(&gm_mpu6050_interface_B.AXI4Lite_Read_deviceID_DTC), 3, 0, 2 },

  { (char_T *)(&gm_mpu6050_interface_B.AXI4Lite_Read_validout_DTC), 8, 0, 1 }
  ,

  { (char_T *)(&gm_mpu6050_interface_DW.obj), 14, 0, 9 },

<<<<<<< HEAD
  { (char_T *)(&gm_mpu6050_interface_DW.obj_aq), 15, 0, 2 },

  { (char_T *)(&gm_mpu6050_interface_DW.Scope_PWORK.LoggedData[0]), 11, 0, 15 }
=======
  { (char_T *)(&gm_mpu6050_interface_DW.obj_a), 15, 0, 1 },

  { (char_T *)(&gm_mpu6050_interface_DW.Scope_PWORK.LoggedData[0]), 11, 0, 14 }
>>>>>>> 4c498d00033ba8e3c1028dad581483e8536e1362
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  6U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
<<<<<<< HEAD
  { (char_T *)(&gm_mpu6050_interface_P.Constant2_Value), 3, 0, 2 },

  { (char_T *)(&gm_mpu6050_interface_P.Constant_Value), 8, 0, 2 }
=======
  { (char_T *)(&gm_mpu6050_interface_P.Constant2_Value), 3, 0, 1 }
>>>>>>> 4c498d00033ba8e3c1028dad581483e8536e1362
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
<<<<<<< HEAD
  2U,
=======
  1U,
>>>>>>> 4c498d00033ba8e3c1028dad581483e8536e1362
  rtPTransitions
};

/* [EOF] gm_mpu6050_interface_dt.h */
