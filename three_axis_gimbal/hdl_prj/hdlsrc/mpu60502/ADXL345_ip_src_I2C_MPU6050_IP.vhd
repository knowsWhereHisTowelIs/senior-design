-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\mpu60502\ADXL345_ip_src_I2C_MPU6050_IP.vhd
-- Created: 2017-11-27 10:37:54
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 2e-08
-- Target subsystem base rate: 2e-08
-- Explicit user oversample request: 125x
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        2.5e-06
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- SCL                           ce_out        2.5e-06
-- SDA                           ce_out        2.5e-06
-- AccelX                        ce_out        2.5e-06
-- AccelY                        ce_out        2.5e-06
-- AccelZ                        ce_out        2.5e-06
-- validout                      ce_out        2.5e-06
-- deviceID                      ce_out        2.5e-06
-- CS                            ce_out        2.5e-06
-- ADDRALT                       ce_out        2.5e-06
-- RegData                       ce_out        2.5e-06
-- GyroX                         ce_out        2.5e-06
-- GyroY                         ce_out        2.5e-06
-- GyroZ                         ce_out        2.5e-06
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ADXL345_ip_src_I2C_MPU6050_IP
-- Source Path: mpu60502/I2C_MPU6050_IP
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ADXL345_ip_src_I2C_MPU6050_IP IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        RegAddr                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        ConfigDevice                      :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        SCL                               :   OUT   std_logic;
        SDA                               :   INOUT std_logic;
        AccelX                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        AccelY                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        AccelZ                            :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        validout                          :   OUT   std_logic;
        deviceID                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        CS                                :   OUT   std_logic;
        ADDRALT                           :   OUT   std_logic;
        RegData                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        GyroX                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        GyroY                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
        GyroZ                             :   OUT   std_logic_vector(15 DOWNTO 0)  -- int16
        );
END ADXL345_ip_src_I2C_MPU6050_IP;


ARCHITECTURE rtl OF ADXL345_ip_src_I2C_MPU6050_IP IS

  -- Component Declarations
  COMPONENT ADXL345_ip_src_I2C_MPU6050_IP_tc
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          enb                             :   OUT   std_logic;
          enb_1_1_1                       :   OUT   std_logic;
          enb_125_1_0                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ADXL345_ip_src_MPU6050_Interface
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          busy                            :   IN    std_logic;
          n_ack                           :   IN    std_logic;
          byte_mode                       :   IN    std_logic;
          reg_mode                        :   IN    std_logic;
          data_in                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          mstr_ack                        :   IN    std_logic;
          userRegAddr                     :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          configDevice                    :   IN    std_logic;
          enb_1                           :   OUT   std_logic;
          rw                              :   OUT   std_logic;
          mode                            :   OUT   std_logic;
          slv_addr                        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_addr                        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_byte_mode                   :   OUT   std_logic;
          data_out                        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          AccelX                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          AccelY                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          AccelZ                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          Valid_Out                       :   OUT   std_logic;
          deviceId                        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          regdata                         :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          GyroX                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          GyroY                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- int16
          GyroZ                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- int16
          );
  END COMPONENT;

  COMPONENT ADXL345_ip_src_I2C_MasterController
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1                           :   IN    std_logic;
          rd_wr                           :   IN    std_logic;
          mode                            :   IN    std_logic;
          slv_addr                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_addr                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_byte_mode                   :   IN    std_logic;
          data_in                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          busy                            :   OUT   std_logic;
          I2C_SCL                         :   OUT   std_logic;
          I2C_SDA                         :   INOUT std_logic;
          n_ack                           :   OUT   std_logic;
          reg_data_burst                  :   OUT   std_logic;
          reg_addr_burst                  :   OUT   std_logic;
          mstr_ack                        :   OUT   std_logic;
          data_out                        :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ADXL345_ip_src_I2C_MPU6050_IP_tc
    USE ENTITY work.ADXL345_ip_src_I2C_MPU6050_IP_tc(rtl);

  FOR ALL : ADXL345_ip_src_MPU6050_Interface
    USE ENTITY work.ADXL345_ip_src_MPU6050_Interface(rtl);

  FOR ALL : ADXL345_ip_src_I2C_MasterController
    USE ENTITY work.ADXL345_ip_src_I2C_MasterController(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL enb_1_1_1                        : std_logic;
  SIGNAL enb_125_1_0                      : std_logic;
  SIGNAL busy                             : std_logic;
  SIGNAL n_ack                            : std_logic;
  SIGNAL reg_data_burst                   : std_logic;
  SIGNAL reg_addr_burst                   : std_logic;
  SIGNAL data_out                         : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL mstr_ack                         : std_logic;
  SIGNAL enb_1                            : std_logic;
  SIGNAL rw                               : std_logic;
  SIGNAL mode                             : std_logic;
  SIGNAL slv_addr                         : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL reg_addr                         : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL reg_byte_mode                    : std_logic;
  SIGNAL data_out_1                       : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL AccelX_tmp                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL AccelY_tmp                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL AccelZ_tmp                       : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Valid_Out                        : std_logic;
  SIGNAL deviceId_1                       : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL regdata_1                        : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL GyroX_tmp                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL GyroY_tmp                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL GyroZ_tmp                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ChipSelect_I2C_out1              : std_logic;
  SIGNAL Addr_Alt_out1                    : std_logic;

BEGIN
  u_I2C_MPU6050_IP_tc : ADXL345_ip_src_I2C_MPU6050_IP_tc
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              enb_125_1_0 => enb_125_1_0
              );

  -- <S1>/MPU6050_Interface
  u_MPU6050_Interface : ADXL345_ip_src_MPU6050_Interface
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              busy => busy,
              n_ack => n_ack,
              byte_mode => reg_data_burst,
              reg_mode => reg_addr_burst,
              data_in => data_out,  -- uint8
              mstr_ack => mstr_ack,
              userRegAddr => RegAddr,  -- uint8
              configDevice => ConfigDevice,
              enb_1 => enb_1,
              rw => rw,
              mode => mode,
              slv_addr => slv_addr,  -- uint8
              reg_addr => reg_addr,  -- uint8
              reg_byte_mode => reg_byte_mode,
              data_out => data_out_1,  -- uint8
              AccelX => AccelX_tmp,  -- int16
              AccelY => AccelY_tmp,  -- int16
              AccelZ => AccelZ_tmp,  -- int16
              Valid_Out => Valid_Out,
              deviceId => deviceId_1,  -- uint8
              regdata => regdata_1,  -- uint8
              GyroX => GyroX_tmp,  -- int16
              GyroY => GyroY_tmp,  -- int16
              GyroZ => GyroZ_tmp  -- int16
              );

  -- <S1>/I2C_MasterController
  u_I2C_MasterController : ADXL345_ip_src_I2C_MasterController
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1 => enb_1,
              rd_wr => rw,
              mode => mode,
              slv_addr => slv_addr,  -- uint8
              reg_addr => reg_addr,  -- uint8
              reg_byte_mode => reg_byte_mode,
              data_in => data_out_1,  -- uint8
              busy => busy,
              I2C_SCL => SCL,
              I2C_SDA => SDA,
              n_ack => n_ack,
              reg_data_burst => reg_data_burst,
              reg_addr_burst => reg_addr_burst,
              mstr_ack => mstr_ack,
              data_out => data_out  -- uint8
              );

  -- <S1>/ChipSelect_I2C
  ChipSelect_I2C_out1 <= '1';

  -- <S1>/Addr_Alt
  Addr_Alt_out1 <= '0';

  ce_out <= enb_1_1_1;

  AccelX <= AccelX_tmp;

  AccelY <= AccelY_tmp;

  AccelZ <= AccelZ_tmp;

  validout <= Valid_Out;

  deviceID <= deviceId_1;

  CS <= ChipSelect_I2C_out1;

  ADDRALT <= Addr_Alt_out1;

  RegData <= regdata_1;

  GyroX <= GyroX_tmp;

  GyroY <= GyroY_tmp;

  GyroZ <= GyroZ_tmp;

END rtl;

