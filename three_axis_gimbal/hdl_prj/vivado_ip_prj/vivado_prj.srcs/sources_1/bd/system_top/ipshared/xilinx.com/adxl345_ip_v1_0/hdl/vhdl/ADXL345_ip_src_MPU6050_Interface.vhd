-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\mpu6050\ADXL345_ip_src_MPU6050_Interface.vhd
-- Created: 2017-12-01 17:05:04
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ADXL345_ip_src_MPU6050_Interface
-- Source Path: mpu6050/I2C_MPU6050_IP/MPU6050_Interface
-- Hierarchy Level: 1
-- 
-- I2C Configuration for MPU6050
-- 0x3B 59 ACCEL_XOUT[15:8] 
-- 0x3C 60 ACCEL_XOUT[7:0] 
-- 0x3D 61 ACCEL_YOUT[15:8] 
-- 0x3E 62 ACCEL_YOUT[7:0] 
-- 0x3F 63 ACCEL_ZOUT[15:8] 
-- 0x40 64 ACCEL_ZOUT[7:0]
-- 
-- 0x43 67 GYRO_XOUT[15:8] 
-- 0x44 68 GYRO_XOUT[7:0] 
-- 0x45 69 GYRO_YOUT[15:8] 
-- 0x46 70 GYRO_YOUT[7:0] 
-- 0x47 71 GYRO_ZOUT[15:8] 
-- 0x48 72 GYRO_ZOUT[7:0]
-- 
-- 0x6B 107 PWR_MGMT_1
-- 0x6C 108 PWR_MGMT_2
-- 
-- DEVID is an example of
-- doing a 1-byte READ
-- 0x75 117 - WHO_AM_I[6:1]
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ADXL345_ip_src_I2C_MPU6050_IP_pkg.ALL;

ENTITY ADXL345_ip_src_MPU6050_Interface IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        busy                              :   IN    std_logic;
        n_ack                             :   IN    std_logic;
        byte_mode                         :   IN    std_logic;
        reg_mode                          :   IN    std_logic;
        data_in                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        mstr_ack                          :   IN    std_logic;
        userRegAddr                       :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        configDevice                      :   IN    std_logic;
        enb_1                             :   OUT   std_logic;
        rw                                :   OUT   std_logic;
        mode                              :   OUT   std_logic;
        slv_addr                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        reg_addr                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        reg_byte_mode                     :   OUT   std_logic;
        data_out                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        AccelX                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        AccelY                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        AccelZ                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        Valid_Out                         :   OUT   std_logic;
        deviceId                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        regdata                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        GyroX                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        GyroY                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        GyroZ                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        tmp                               :   OUT   std_logic;
        tmpConfig                         :   OUT   std_logic;
        tmpCheckCng                       :   OUT   std_logic;
        tmpReadGyro                       :   OUT   std_logic;
        tmpReadAccel                      :   OUT   std_logic;
        tmpValid                          :   OUT   std_logic;
        tmpReadDevice                     :   OUT   std_logic;
        tmpHere                           :   OUT   std_logic
        );
END ADXL345_ip_src_MPU6050_Interface;


ARCHITECTURE rtl OF ADXL345_ip_src_MPU6050_Interface IS

  -- Constants
  CONSTANT b_SlvAddr                      : unsigned(7 DOWNTO 0) := 
    to_unsigned(16#68#, 8);  -- uint8
  CONSTANT b_AccelXRegAddr                : unsigned(7 DOWNTO 0) := 
    to_unsigned(16#3B#, 8);  -- uint8
  CONSTANT b_GyroXRegAddr                 : unsigned(7 DOWNTO 0) := 
    to_unsigned(16#43#, 8);  -- uint8

  -- Signals
  SIGNAL data_in_unsigned                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL userRegAddr_unsigned             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL is_MPU6050_Interface             : T_state_type_is_MPU6050_Interface;  -- uint8
  SIGNAL cnt                              : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL tempVal                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL selfInit                         : std_logic;
  SIGNAL enb_2                            : std_logic;
  SIGNAL slv_addr_tmp                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reg_addr_tmp                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_out_tmp                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL AccelX_tmp                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelY_tmp                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelZ_tmp                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL deviceId_tmp                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL regdata_tmp                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL GyroX_tmp                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroY_tmp                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroZ_tmp                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL enb_reg                          : std_logic;
  SIGNAL rw_reg                           : std_logic;
  SIGNAL mode_reg                         : std_logic;
  SIGNAL slv_addr_reg                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reg_addr_reg                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reg_byte_mode_reg                : std_logic;
  SIGNAL data_out_reg                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL AccelX_reg                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelY_reg                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelZ_reg                       : signed(15 DOWNTO 0);  -- int16
  SIGNAL Valid_Out_reg                    : std_logic;
  SIGNAL deviceId_reg                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL regdata_reg                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL GyroX_reg                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroY_reg                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroZ_reg                        : signed(15 DOWNTO 0);  -- int16
  SIGNAL tmp_reg                          : std_logic;
  SIGNAL tmpConfig_reg                    : std_logic;
  SIGNAL tmpCheckCng_reg                  : std_logic;
  SIGNAL tmpReadGyro_reg                  : std_logic;
  SIGNAL tmpReadAccel_reg                 : std_logic;
  SIGNAL tmpValid_reg                     : std_logic;
  SIGNAL tmpReadDevice_reg                : std_logic;
  SIGNAL tmpHere_reg                      : std_logic;
  SIGNAL is_MPU6050_Interface_next        : T_state_type_is_MPU6050_Interface;  -- enum type state_type_is_MPU6050_Interface (47 enums)
  SIGNAL cnt_next                         : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL tempVal_next                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL selfInit_next                    : std_logic;
  SIGNAL enb_reg_next                     : std_logic;
  SIGNAL rw_reg_next                      : std_logic;
  SIGNAL mode_reg_next                    : std_logic;
  SIGNAL slv_addr_reg_next                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reg_addr_reg_next                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL reg_byte_mode_reg_next           : std_logic;
  SIGNAL data_out_reg_next                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL AccelX_reg_next                  : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelY_reg_next                  : signed(15 DOWNTO 0);  -- int16
  SIGNAL AccelZ_reg_next                  : signed(15 DOWNTO 0);  -- int16
  SIGNAL Valid_Out_reg_next               : std_logic;
  SIGNAL deviceId_reg_next                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL regdata_reg_next                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL GyroX_reg_next                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroY_reg_next                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL GyroZ_reg_next                   : signed(15 DOWNTO 0);  -- int16
  SIGNAL tmp_reg_next                     : std_logic;
  SIGNAL tmpConfig_reg_next               : std_logic;
  SIGNAL tmpCheckCng_reg_next             : std_logic;
  SIGNAL tmpReadGyro_reg_next             : std_logic;
  SIGNAL tmpReadAccel_reg_next            : std_logic;
  SIGNAL tmpValid_reg_next                : std_logic;
  SIGNAL tmpReadDevice_reg_next           : std_logic;
  SIGNAL tmpHere_reg_next                 : std_logic;

BEGIN
  data_in_unsigned <= unsigned(data_in);

  userRegAddr_unsigned <= unsigned(userRegAddr);

  MPU6050_Interface_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        cnt <= to_unsigned(16#00000000#, 32);
        tempVal <= to_unsigned(16#00#, 8);
        enb_reg <= '0';
        rw_reg <= '0';
        mode_reg <= '0';
        reg_addr_reg <= to_unsigned(16#00#, 8);
        reg_byte_mode_reg <= '0';
        data_out_reg <= to_unsigned(16#00#, 8);
        AccelX_reg <= to_signed(16#0000#, 16);
        AccelY_reg <= to_signed(16#0000#, 16);
        AccelZ_reg <= to_signed(16#0000#, 16);
        deviceId_reg <= to_unsigned(16#00#, 8);
        regdata_reg <= to_unsigned(16#00#, 8);
        GyroX_reg <= to_signed(16#0000#, 16);
        GyroY_reg <= to_signed(16#0000#, 16);
        GyroZ_reg <= to_signed(16#0000#, 16);
        tmpCheckCng_reg <= '0';
        --Entry: I2C_MPU6050_IP/MPU6050_Interface
        --Entry Internal: I2C_MPU6050_IP/MPU6050_Interface
        --Transition: '<S5>:575'
        is_MPU6050_Interface <= IN_init;
        --Entry 'init': '<S5>:2177'
        --initstate
        Valid_Out_reg <= '0';
        selfInit <= '1';
        slv_addr_reg <= b_SlvAddr;
        --TODO delete all
        tmp_reg <= '0';
        tmpConfig_reg <= '0';
        tmpReadGyro_reg <= '0';
        tmpReadAccel_reg <= '0';
        tmpValid_reg <= '0';
        tmpReadDevice_reg <= '0';
        tmpHere_reg <= '0';
      ELSIF enb = '1' THEN
        is_MPU6050_Interface <= is_MPU6050_Interface_next;
        cnt <= cnt_next;
        tempVal <= tempVal_next;
        selfInit <= selfInit_next;
        enb_reg <= enb_reg_next;
        rw_reg <= rw_reg_next;
        mode_reg <= mode_reg_next;
        slv_addr_reg <= slv_addr_reg_next;
        reg_addr_reg <= reg_addr_reg_next;
        reg_byte_mode_reg <= reg_byte_mode_reg_next;
        data_out_reg <= data_out_reg_next;
        AccelX_reg <= AccelX_reg_next;
        AccelY_reg <= AccelY_reg_next;
        AccelZ_reg <= AccelZ_reg_next;
        Valid_Out_reg <= Valid_Out_reg_next;
        deviceId_reg <= deviceId_reg_next;
        regdata_reg <= regdata_reg_next;
        GyroX_reg <= GyroX_reg_next;
        GyroY_reg <= GyroY_reg_next;
        GyroZ_reg <= GyroZ_reg_next;
        tmp_reg <= tmp_reg_next;
        tmpConfig_reg <= tmpConfig_reg_next;
        tmpCheckCng_reg <= tmpCheckCng_reg_next;
        tmpReadGyro_reg <= tmpReadGyro_reg_next;
        tmpReadAccel_reg <= tmpReadAccel_reg_next;
        tmpValid_reg <= tmpValid_reg_next;
        tmpReadDevice_reg <= tmpReadDevice_reg_next;
        tmpHere_reg <= tmpHere_reg_next;
      END IF;
    END IF;
  END PROCESS MPU6050_Interface_process;

  MPU6050_Interface_output : PROCESS (is_MPU6050_Interface, busy, n_ack, cnt, data_in_unsigned, mstr_ack, tempVal,
       userRegAddr_unsigned, configDevice, selfInit, enb_reg, rw_reg, mode_reg,
       slv_addr_reg, reg_addr_reg, reg_byte_mode_reg, data_out_reg, AccelX_reg,
       AccelY_reg, AccelZ_reg, Valid_Out_reg, deviceId_reg, regdata_reg,
       GyroX_reg, GyroY_reg, GyroZ_reg, tmp_reg, tmpConfig_reg, tmpCheckCng_reg,
       tmpReadGyro_reg, tmpReadAccel_reg, tmpValid_reg, tmpReadDevice_reg,
       tmpHere_reg)
    VARIABLE add_temp : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_0 : unsigned(32 DOWNTO 0);
    VARIABLE cast : signed(15 DOWNTO 0);
    VARIABLE cast_0 : signed(15 DOWNTO 0);
    VARIABLE cast_1 : signed(15 DOWNTO 0);
    VARIABLE cast_2 : signed(15 DOWNTO 0);
    VARIABLE cast_3 : signed(15 DOWNTO 0);
    VARIABLE cast_4 : signed(15 DOWNTO 0);
    VARIABLE cast_5 : signed(15 DOWNTO 0);
    VARIABLE cast_6 : signed(15 DOWNTO 0);
    VARIABLE cast_7 : signed(15 DOWNTO 0);
    VARIABLE cast_8 : signed(15 DOWNTO 0);
    VARIABLE cast_9 : signed(15 DOWNTO 0);
    VARIABLE cast_10 : signed(15 DOWNTO 0);
  BEGIN
    enb_reg_next <= enb_reg;
    rw_reg_next <= rw_reg;
    mode_reg_next <= mode_reg;
    slv_addr_reg_next <= slv_addr_reg;
    reg_addr_reg_next <= reg_addr_reg;
    reg_byte_mode_reg_next <= reg_byte_mode_reg;
    data_out_reg_next <= data_out_reg;
    AccelX_reg_next <= AccelX_reg;
    AccelY_reg_next <= AccelY_reg;
    AccelZ_reg_next <= AccelZ_reg;
    Valid_Out_reg_next <= Valid_Out_reg;
    deviceId_reg_next <= deviceId_reg;
    regdata_reg_next <= regdata_reg;
    GyroX_reg_next <= GyroX_reg;
    GyroY_reg_next <= GyroY_reg;
    GyroZ_reg_next <= GyroZ_reg;
    tmp_reg_next <= tmp_reg;
    tmpConfig_reg_next <= tmpConfig_reg;
    tmpCheckCng_reg_next <= tmpCheckCng_reg;
    tmpReadGyro_reg_next <= tmpReadGyro_reg;
    tmpReadAccel_reg_next <= tmpReadAccel_reg;
    tmpValid_reg_next <= tmpValid_reg;
    tmpReadDevice_reg_next <= tmpReadDevice_reg;
    tmpHere_reg_next <= tmpHere_reg;
    is_MPU6050_Interface_next <= is_MPU6050_Interface;
    cnt_next <= cnt;
    tempVal_next <= tempVal;
    selfInit_next <= selfInit;
    --Gateway: I2C_MPU6050_IP/MPU6050_Interface
    --During: I2C_MPU6050_IP/MPU6050_Interface
    CASE is_MPU6050_Interface IS
      WHEN IN_cfgDone1 =>
        --During 'cfgDone1': '<S5>:2447'
        --Transition: '<S5>:2449'
        is_MPU6050_Interface_next <= IN_read_accelX_registers0;
        --Entry 'read_accelX_registers0': '<S5>:766'
        enb_reg_next <= '1';
        rw_reg_next <= '1';
        mode_reg_next <= '1';
        reg_addr_reg_next <= b_AccelXRegAddr;
        Valid_Out_reg_next <= '0';
        tmpReadAccel_reg_next <= '1';
      WHEN IN_clearSleepEnableSensors =>
        data_out_reg_next <= to_unsigned(16#00#, 8);
        --During 'clearSleepEnableSensors': '<S5>:2378'
        IF busy = '1' THEN 
          --Transition: '<S5>:2379'
          is_MPU6050_Interface_next <= IN_waitforNotBusy6B;
          --Entry 'waitforNotBusy6B': '<S5>:2405'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_configGyroAndAccel1 =>
        data_out_reg_next <= to_unsigned(16#00#, 8);
        --During 'configGyroAndAccel1': '<S5>:2404'
        IF busy = '1' THEN 
          --Transition: '<S5>:2407'
          is_MPU6050_Interface_next <= IN_waitforNotBusy7;
          --Entry 'waitforNotBusy7': '<S5>:2380'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_resetPowerMode =>
        data_out_reg_next <= to_unsigned(16#80#, 8);
        --During 'resetPowerMode': '<S5>:2365'
        IF busy = '1' THEN 
          --Transition: '<S5>:2367'
          is_MPU6050_Interface_next <= IN_waitforNotBusy4;
          --Entry 'waitforNotBusy4': '<S5>:2368'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_setClockSource1 =>
        data_out_reg_next <= to_unsigned(16#01#, 8);
        --During 'setClockSource1': '<S5>:2370'
        IF busy = '1' THEN 
          --Transition: '<S5>:2371'
          is_MPU6050_Interface_next <= IN_waitforNotBusy5;
          --Entry 'waitforNotBusy5': '<S5>:2372'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_setClockSource2Maybe =>
        data_out_reg_next <= to_unsigned(16#00#, 8);
        --During 'setClockSource2Maybe': '<S5>:2374'
        IF busy = '1' THEN 
          --Transition: '<S5>:2375'
          is_MPU6050_Interface_next <= IN_waitforNotBusy6;
          --Entry 'waitforNotBusy6': '<S5>:2376'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_waitforNotBusy4 =>
        --During 'waitforNotBusy4': '<S5>:2368'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2369'
          is_MPU6050_Interface_next <= IN_setClockSource1;
          --Entry 'setClockSource1': '<S5>:2370'
          enb_reg_next <= '1';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#6B#, 8);
          --0x6B
          data_out_reg_next <= to_unsigned(16#01#, 8);
          --0x01
        END IF;
      WHEN IN_waitforNotBusy5 =>
        --During 'waitforNotBusy5': '<S5>:2372'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2373'
          is_MPU6050_Interface_next <= IN_setClockSource2Maybe;
          --Entry 'setClockSource2Maybe': '<S5>:2374'
          enb_reg_next <= '1';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#6C#, 8);
          --0x6C
          data_out_reg_next <= to_unsigned(16#00#, 8);
          --0x00
        END IF;
      WHEN IN_waitforNotBusy6 =>
        --During 'waitforNotBusy6': '<S5>:2376'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2377'
          is_MPU6050_Interface_next <= IN_clearSleepEnableSensors;
          --Entry 'clearSleepEnableSensors': '<S5>:2378'
          enb_reg_next <= '1';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#1B#, 8);
          --0x6B
          data_out_reg_next <= to_unsigned(16#00#, 8);
          --0x0
        END IF;
      WHEN IN_waitforNotBusy6B =>
        --During 'waitforNotBusy6B': '<S5>:2405'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2406'
          is_MPU6050_Interface_next <= IN_configGyroAndAccel1;
          --Entry 'configGyroAndAccel1': '<S5>:2404'
          enb_reg_next <= '1';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#1C#, 8);
          --0x6B
          data_out_reg_next <= to_unsigned(16#00#, 8);
          --0x01
        END IF;
      WHEN IN_waitforNotBusy7 =>
        --During 'waitforNotBusy7': '<S5>:2380'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2448'
          is_MPU6050_Interface_next <= IN_cfgDone1;
          --Entry 'cfgDone1': '<S5>:2447'
          selfInit_next <= '0';
          tmp_reg_next <= '1';
        END IF;
      WHEN IN_accelX_LSB =>
        --During 'accelX_LSB': '<S5>:574'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2180'
          is_MPU6050_Interface_next <= IN_toggle;
        END IF;
      WHEN IN_accelX_MSB =>
        --During 'accelX_MSB': '<S5>:2175'
        IF n_ack = '1' THEN 
          --Transition: '<S5>:2204'
          --Transition: '<S5>:2287'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        ELSIF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2290'
          is_MPU6050_Interface_next <= IN_toggle3;
        END IF;
      WHEN IN_accelY_LSB =>
        --During 'accelY_LSB': '<S5>:2185'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2189'
          is_MPU6050_Interface_next <= IN_toggle1;
        END IF;
      WHEN IN_accelY_MSB =>
        --During 'accelY_MSB': '<S5>:2187'
        IF n_ack = '1' THEN 
          --Transition: '<S5>:2205'
          --Transition: '<S5>:2287'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        ELSIF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2292'
          is_MPU6050_Interface_next <= IN_toggle4;
        END IF;
      WHEN IN_accelZ_LSB =>
        --During 'accelZ_LSB': '<S5>:2196'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2195'
          is_MPU6050_Interface_next <= IN_toggle2;
          --Entry 'toggle2': '<S5>:2192'
          mode_reg_next <= '0';
        END IF;
      WHEN IN_accelZ_MSB =>
        --During 'accelZ_MSB': '<S5>:2194'
        IF n_ack = '1' THEN 
          --Transition: '<S5>:2206'
          --Transition: '<S5>:2287'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        ELSIF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2133'
          is_MPU6050_Interface_next <= IN_read_gyroX_registers0;
          --Entry 'read_gyroX_registers0': '<S5>:2320'
          enb_reg_next <= '1';
          rw_reg_next <= '1';
          mode_reg_next <= '1';
          reg_addr_reg_next <= b_GyroXRegAddr;
          Valid_Out_reg_next <= '0';
          tmpReadGyro_reg_next <= '1';
        END IF;
      WHEN IN_read_accelX_registers0 =>
        --During 'read_accelX_registers0': '<S5>:766'
        IF busy = '1' THEN 
          --Transition: '<S5>:2230'
          is_MPU6050_Interface_next <= IN_waitforNotBusy2;
          --Entry 'waitforNotBusy2': '<S5>:2229'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_toggle =>
        --During 'toggle': '<S5>:2179'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2176'
          is_MPU6050_Interface_next <= IN_accelX_MSB;
          --Entry 'accelX_MSB': '<S5>:2175'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast := signed(resize(tempVal, 16));
          cast_0 := signed(resize(data_in_unsigned, 16));
          AccelX_reg_next <= (cast sll 8) OR cast_0;
        END IF;
      WHEN IN_toggle1 =>
        --During 'toggle1': '<S5>:2188'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2183'
          is_MPU6050_Interface_next <= IN_accelY_MSB;
          --Entry 'accelY_MSB': '<S5>:2187'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast_1 := signed(resize(tempVal, 16));
          cast_2 := signed(resize(data_in_unsigned, 16));
          AccelY_reg_next <= (cast_1 sll 8) OR cast_2;
        END IF;
      WHEN IN_toggle2 =>
        --During 'toggle2': '<S5>:2192'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2190'
          is_MPU6050_Interface_next <= IN_accelZ_MSB;
          --Entry 'accelZ_MSB': '<S5>:2194'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast_3 := signed(resize(tempVal, 16));
          cast_4 := signed(resize(data_in_unsigned, 16));
          AccelZ_reg_next <= (cast_3 sll 8) OR cast_4;
        END IF;
      WHEN IN_toggle3 =>
        --During 'toggle3': '<S5>:2289'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2284'
          is_MPU6050_Interface_next <= IN_accelY_LSB;
          --Entry 'accelY_LSB': '<S5>:2185'
          tempVal_next <= data_in_unsigned;
        END IF;
      WHEN IN_toggle4 =>
        --During 'toggle4': '<S5>:2291'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2285'
          is_MPU6050_Interface_next <= IN_accelZ_LSB;
          --Entry 'accelZ_LSB': '<S5>:2196'
          tempVal_next <= data_in_unsigned;
        END IF;
      WHEN IN_waitforNotBusy2 =>
        --During 'waitforNotBusy2': '<S5>:2229'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:1091'
          is_MPU6050_Interface_next <= IN_accelX_LSB;
          --Entry 'accelX_LSB': '<S5>:574'
          tempVal_next <= data_in_unsigned;
        ELSIF n_ack = '1' THEN 
          --Transition: '<S5>:2237'
          --Transition: '<S5>:2287'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        END IF;
      WHEN IN_getDEVID =>
        --During 'getDEVID': '<S5>:2209'
        IF busy = '1' THEN 
          --Transition: '<S5>:2228'
          is_MPU6050_Interface_next <= IN_waitforNotBusy1;
          --Entry 'waitforNotBusy1': '<S5>:2227'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_getRegData =>
        --During 'getRegData': '<S5>:2239'
        IF busy = '1' THEN 
          --Transition: '<S5>:2241'
          is_MPU6050_Interface_next <= b_IN_waitforNotBusy5;
          --Entry 'waitforNotBusy5': '<S5>:2240'
          enb_reg_next <= '0';
        END IF;
      WHEN IN_readDEVID =>
        --During 'readDEVID': '<S5>:2214'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2248'
          is_MPU6050_Interface_next <= IN_getRegData;
          --Entry 'getRegData': '<S5>:2239'
          enb_reg_next <= '1';
          rw_reg_next <= '1';
          mode_reg_next <= '0';
          reg_addr_reg_next <= userRegAddr_unsigned;
        END IF;
      WHEN IN_readUserRegData =>
        --During 'readUserRegData': '<S5>:2242'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2268'
          is_MPU6050_Interface_next <= IN_read_accelX_registers0;
          --Entry 'read_accelX_registers0': '<S5>:766'
          enb_reg_next <= '1';
          rw_reg_next <= '1';
          mode_reg_next <= '1';
          reg_addr_reg_next <= b_AccelXRegAddr;
          Valid_Out_reg_next <= '0';
          tmpReadAccel_reg_next <= '1';
        END IF;
      WHEN IN_waitforNotBusy1 =>
        --During 'waitforNotBusy1': '<S5>:2227'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2210'
          is_MPU6050_Interface_next <= IN_readDEVID;
          --Entry 'readDEVID': '<S5>:2214'
          deviceId_reg_next <= data_in_unsigned;
          tmpHere_reg_next <= '1';
        ELSIF n_ack = '1' THEN 
          --Transition: '<S5>:2236'
          --Transition: '<S5>:2282'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        END IF;
      WHEN b_IN_waitforNotBusy5 =>
        --During 'waitforNotBusy5': '<S5>:2240'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2243'
          is_MPU6050_Interface_next <= IN_readUserRegData;
          --Entry 'readUserRegData': '<S5>:2242'
          regdata_reg_next <= data_in_unsigned;
        ELSIF n_ack = '1' THEN 
          --Transition: '<S5>:2249'
          --Transition: '<S5>:2282'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        END IF;
      WHEN IN_gyroX_LSB =>
        --During 'gyroX_LSB': '<S5>:2315'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2312'
          is_MPU6050_Interface_next <= b_IN_toggle;
        END IF;
      WHEN IN_gyroX_MSB =>
        --During 'gyroX_MSB': '<S5>:2310'
        IF (n_ack OR mstr_ack) = '1' THEN 
          --Transition: '<S5>:2298'
        ELSE 
          --Transition: '<S5>:2299'
          is_MPU6050_Interface_next <= b_IN_toggle3;
        END IF;
      WHEN IN_gyroY_LSB =>
        --During 'gyroY_LSB': '<S5>:2313'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2305'
          is_MPU6050_Interface_next <= b_IN_toggle1;
        END IF;
      WHEN IN_gyroY_MSB =>
        --During 'gyroY_MSB': '<S5>:2323'
        IF (n_ack OR mstr_ack) = '1' THEN 
          --Transition: '<S5>:2295'
        ELSE 
          --Transition: '<S5>:2294'
          is_MPU6050_Interface_next <= b_IN_toggle4;
        END IF;
      WHEN IN_gyroZ_LSB =>
        --During 'gyroZ_LSB': '<S5>:2307'
        IF ( NOT mstr_ack) = '1' THEN 
          --Transition: '<S5>:2316'
          is_MPU6050_Interface_next <= b_IN_toggle2;
          --Entry 'toggle2': '<S5>:2306'
          mode_reg_next <= '0';
        END IF;
      WHEN IN_gyroZ_MSB =>
        --During 'gyroZ_MSB': '<S5>:2302'
        IF n_ack = '1' THEN 
          --Transition: '<S5>:2297'
        ELSE 
          --Transition: '<S5>:2324'
          is_MPU6050_Interface_next <= IN_Valid;
          --Entry 'Valid': '<S5>:2150'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
          Valid_Out_reg_next <= '1';
        END IF;
      WHEN IN_read_gyroX_registers0 =>
        --During 'read_gyroX_registers0': '<S5>:2320'
        IF busy = '1' THEN 
          --Transition: '<S5>:2303'
          is_MPU6050_Interface_next <= b_IN_waitforNotBusy2;
          --Entry 'waitforNotBusy2': '<S5>:2318'
          enb_reg_next <= '0';
        END IF;
      WHEN b_IN_toggle =>
        --During 'toggle': '<S5>:2314'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2300'
          is_MPU6050_Interface_next <= IN_gyroX_MSB;
          --Entry 'gyroX_MSB': '<S5>:2310'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast_5 := signed(resize(tempVal, 16));
          cast_6 := signed(resize(data_in_unsigned, 16));
          GyroX_reg_next <= (cast_5 sll 8) OR cast_6;
        END IF;
      WHEN b_IN_toggle1 =>
        --During 'toggle1': '<S5>:2311'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2304'
          is_MPU6050_Interface_next <= IN_gyroY_MSB;
          --Entry 'gyroY_MSB': '<S5>:2323'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast_7 := signed(resize(tempVal, 16));
          cast_8 := signed(resize(data_in_unsigned, 16));
          GyroY_reg_next <= (cast_7 sll 8) OR cast_8;
        END IF;
      WHEN b_IN_toggle2 =>
        --During 'toggle2': '<S5>:2306'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2321'
          is_MPU6050_Interface_next <= IN_gyroZ_MSB;
          --Entry 'gyroZ_MSB': '<S5>:2302'
          --MATLAB Function 'convert_int16': '<S5>:2274'
          --'<S5>:2274:3'
          cast_9 := signed(resize(tempVal, 16));
          cast_10 := signed(resize(data_in_unsigned, 16));
          GyroZ_reg_next <= (cast_9 sll 8) OR cast_10;
        END IF;
      WHEN b_IN_toggle3 =>
        --During 'toggle3': '<S5>:2309'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2296'
          is_MPU6050_Interface_next <= IN_gyroY_LSB;
          --Entry 'gyroY_LSB': '<S5>:2313'
          tempVal_next <= data_in_unsigned;
        END IF;
      WHEN b_IN_toggle4 =>
        --During 'toggle4': '<S5>:2308'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2319'
          is_MPU6050_Interface_next <= IN_gyroZ_LSB;
          --Entry 'gyroZ_LSB': '<S5>:2307'
          tempVal_next <= data_in_unsigned;
        END IF;
      WHEN b_IN_waitforNotBusy2 =>
        --During 'waitforNotBusy2': '<S5>:2318'
        IF mstr_ack = '1' THEN 
          --Transition: '<S5>:2317'
          is_MPU6050_Interface_next <= IN_gyroX_LSB;
          --Entry 'gyroX_LSB': '<S5>:2315'
          tempVal_next <= data_in_unsigned;
        END IF;
      WHEN IN_Valid =>
        --During 'Valid': '<S5>:2150'
        IF cnt >= to_unsigned(5, 32) THEN 
          --Transition: '<S5>:2151'
          is_MPU6050_Interface_next <= IN_check_cfg;
          --Entry 'check_cfg': '<S5>:2166'
          enb_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
        ELSE 
          add_temp := resize(cnt, 33) + to_unsigned(1, 33);
          IF add_temp(32) /= '0' THEN 
            cnt_next <= X"FFFFFFFF";
          ELSE 
            cnt_next <= add_temp(31 DOWNTO 0);
          END IF;
          tmpValid_reg_next <= '1';
        END IF;
      WHEN IN_check_cfg =>
        --During 'check_cfg': '<S5>:2166'
        IF cnt >= to_unsigned(5, 32) THEN 
          --Transition: '<S5>:2167'
          is_MPU6050_Interface_next <= IN_idle;
          --Entry 'idle': '<S5>:763'
          --idlestate
          enb_reg_next <= '0';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          cnt_next <= to_unsigned(16#00000000#, 32);
          reg_byte_mode_reg_next <= '0';
        ELSE 
          add_temp_0 := resize(cnt, 33) + to_unsigned(1, 33);
          IF add_temp_0(32) /= '0' THEN 
            cnt_next <= X"FFFFFFFF";
          ELSE 
            cnt_next <= add_temp_0(31 DOWNTO 0);
          END IF;
          tmpCheckCng_reg_next <= '1';
        END IF;
      WHEN IN_idle =>
        --During 'idle': '<S5>:763'
        IF ( NOT busy) = '1' THEN 
          --Transition: '<S5>:2267'
          is_MPU6050_Interface_next <= IN_getDEVID;
          --Entry 'getDEVID': '<S5>:2209'
          enb_reg_next <= '1';
          rw_reg_next <= '1';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#75#, 8);
          tmpReadDevice_reg_next <= '1';
        ELSIF (( NOT busy) AND (configDevice OR selfInit)) = '1' THEN 
          --Transition: '<S5>:753'
          is_MPU6050_Interface_next <= IN_resetPowerMode;
          --Entry 'resetPowerMode': '<S5>:2365'
          enb_reg_next <= '1';
          rw_reg_next <= '0';
          mode_reg_next <= '0';
          reg_addr_reg_next <= to_unsigned(16#6B#, 8);
          --0x6B
          data_out_reg_next <= to_unsigned(16#80#, 8);
          --0x80
          tmpConfig_reg_next <= '1';
        END IF;
      WHEN OTHERS => 
        slv_addr_reg_next <= b_SlvAddr;
        --During 'init': '<S5>:2177'
        --Transition: '<S5>:2178'
        is_MPU6050_Interface_next <= IN_idle;
        --Entry 'idle': '<S5>:763'
        --idlestate
        enb_reg_next <= '0';
        rw_reg_next <= '0';
        mode_reg_next <= '0';
        cnt_next <= to_unsigned(16#00000000#, 32);
        reg_byte_mode_reg_next <= '0';
    END CASE;
  END PROCESS MPU6050_Interface_output;

  enb_2 <= enb_reg_next;
  rw <= rw_reg_next;
  mode <= mode_reg_next;
  slv_addr_tmp <= slv_addr_reg_next;
  reg_addr_tmp <= reg_addr_reg_next;
  reg_byte_mode <= reg_byte_mode_reg_next;
  data_out_tmp <= data_out_reg_next;
  AccelX_tmp <= AccelX_reg_next;
  AccelY_tmp <= AccelY_reg_next;
  AccelZ_tmp <= AccelZ_reg_next;
  Valid_Out <= Valid_Out_reg_next;
  deviceId_tmp <= deviceId_reg_next;
  regdata_tmp <= regdata_reg_next;
  GyroX_tmp <= GyroX_reg_next;
  GyroY_tmp <= GyroY_reg_next;
  GyroZ_tmp <= GyroZ_reg_next;
  tmp <= tmp_reg_next;
  tmpConfig <= tmpConfig_reg_next;
  tmpCheckCng <= tmpCheckCng_reg_next;
  tmpReadGyro <= tmpReadGyro_reg_next;
  tmpReadAccel <= tmpReadAccel_reg_next;
  tmpValid <= tmpValid_reg_next;
  tmpReadDevice <= tmpReadDevice_reg_next;
  tmpHere <= tmpHere_reg_next;

  slv_addr <= std_logic_vector(slv_addr_tmp);

  reg_addr <= std_logic_vector(reg_addr_tmp);

  data_out <= std_logic_vector(data_out_tmp);

  AccelX <= std_logic_vector(AccelX_tmp);

  AccelY <= std_logic_vector(AccelY_tmp);

  AccelZ <= std_logic_vector(AccelZ_tmp);

  deviceId <= std_logic_vector(deviceId_tmp);

  regdata <= std_logic_vector(regdata_tmp);

  GyroX <= std_logic_vector(GyroX_tmp);

  GyroY <= std_logic_vector(GyroY_tmp);

  GyroZ <= std_logic_vector(GyroZ_tmp);

  enb_1 <= enb_2;

END rtl;

