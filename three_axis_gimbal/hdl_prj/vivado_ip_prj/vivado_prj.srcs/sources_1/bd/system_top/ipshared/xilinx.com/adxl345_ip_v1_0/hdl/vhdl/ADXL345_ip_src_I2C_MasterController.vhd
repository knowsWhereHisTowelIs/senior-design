-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\mpu6050\ADXL345_ip_src_I2C_MasterController.vhd
-- Created: 2017-12-01 17:05:04
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ADXL345_ip_src_I2C_MasterController
-- Source Path: mpu6050/I2C_MPU6050_IP/I2C_MasterController
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ADXL345_ip_src_I2C_MasterController IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1                             :   IN    std_logic;
        rd_wr                             :   IN    std_logic;
        mode                              :   IN    std_logic;
        slv_addr                          :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        reg_addr                          :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        reg_byte_mode                     :   IN    std_logic;
        data_in                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        busy                              :   OUT   std_logic;
        I2C_SCL                           :   OUT   std_logic;
        I2C_SDA                           :   INOUT std_logic;
        n_ack                             :   OUT   std_logic;
        reg_data_burst                    :   OUT   std_logic;
        reg_addr_burst                    :   OUT   std_logic;
        mstr_ack                          :   OUT   std_logic;
        data_out                          :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END ADXL345_ip_src_I2C_MasterController;


ARCHITECTURE rtl OF ADXL345_ip_src_I2C_MasterController IS

  -- Component Declarations
  COMPONENT i2c_bidir
    PORT( I2C_CLK                         :   IN    std_logic;
          I2C_DATA                        :   IN    std_logic;
          I2C_SCL                         :   OUT   std_logic;
          I2C_SDA                         :   INOUT std_logic;
          sda_local                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ADXL345_ip_src_i2c_mstr
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1                           :   IN    std_logic;
          rd_wr                           :   IN    std_logic;
          mode                            :   IN    std_logic;
          slv_addr                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_addr                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          reg_addr_burstIn                :   IN    std_logic;
          reg_data                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          sda_in                          :   IN    std_logic;
          busy                            :   OUT   std_logic;
          scl                             :   OUT   std_logic;
          sda                             :   OUT   std_logic;
          ack                             :   OUT   std_logic;
          n_ack                           :   OUT   std_logic;
          reg_data_burst                  :   OUT   std_logic;
          reg_addr_burst                  :   OUT   std_logic;
          mstr_ack                        :   OUT   std_logic;
          data_out                        :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ADXL345_ip_src_i2c_mstr
    USE ENTITY work.ADXL345_ip_src_i2c_mstr(rtl);

  -- Signals
  SIGNAL scl                              : std_logic;
  SIGNAL sda                              : std_logic;
  SIGNAL i2c_bidir_out1                   : std_logic;
  SIGNAL sda_in                           : std_logic;
  SIGNAL sda_local_out1                   : std_logic;
  SIGNAL busy_1                           : std_logic;
  SIGNAL ack                              : std_logic;
  SIGNAL n_ack_1                          : std_logic;
  SIGNAL reg_data_burst_1                 : std_logic;
  SIGNAL reg_addr_burst_1                 : std_logic;
  SIGNAL mstr_ack_1                       : std_logic;
  SIGNAL data_out_1                       : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL busy_dly_out1                    : std_logic;
  SIGNAL n_ack_dly_out1                   : std_logic;
  SIGNAL reg_data_dly_out1                : std_logic;
  SIGNAL reg_addr_dly_out1                : std_logic;
  SIGNAL mstr_ack_dly_out1                : std_logic;
  SIGNAL data_out_unsigned                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_out_dly_out1                : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  -- <S3>/i2c_bidir
  u_i2c_bidir : i2c_bidir
    PORT MAP( I2C_CLK => scl,
              I2C_DATA => sda,
              I2C_SCL => i2c_bidir_out1,
              I2C_SDA => I2C_SDA,
              sda_local => sda_in
              );

  -- <S3>/i2c_mstr
  u_i2c_mstr : ADXL345_ip_src_i2c_mstr
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1 => enb_1,
              rd_wr => rd_wr,
              mode => mode,
              slv_addr => slv_addr,  -- uint8
              reg_addr => reg_addr,  -- uint8
              reg_addr_burstIn => reg_byte_mode,
              reg_data => data_in,  -- uint8
              sda_in => sda_local_out1,
              busy => busy_1,
              scl => scl,
              sda => sda,
              ack => ack,
              n_ack => n_ack_1,
              reg_data_burst => reg_data_burst_1,
              reg_addr_burst => reg_addr_burst_1,
              mstr_ack => mstr_ack_1,
              data_out => data_out_1  -- uint8
              );

  -- <S3>/sda_local
  sda_local_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        sda_local_out1 <= '0';
      ELSIF enb = '1' THEN
        sda_local_out1 <= sda_in;
      END IF;
    END IF;
  END PROCESS sda_local_process;


  -- <S3>/busy_dly
  busy_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        busy_dly_out1 <= '0';
      ELSIF enb = '1' THEN
        busy_dly_out1 <= busy_1;
      END IF;
    END IF;
  END PROCESS busy_dly_process;


  -- <S3>/n_ack_dly
  n_ack_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        n_ack_dly_out1 <= '0';
      ELSIF enb = '1' THEN
        n_ack_dly_out1 <= n_ack_1;
      END IF;
    END IF;
  END PROCESS n_ack_dly_process;


  -- <S3>/reg_data_dly
  reg_data_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reg_data_dly_out1 <= '0';
      ELSIF enb = '1' THEN
        reg_data_dly_out1 <= reg_data_burst_1;
      END IF;
    END IF;
  END PROCESS reg_data_dly_process;


  -- <S3>/reg_addr_dly
  reg_addr_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reg_addr_dly_out1 <= '0';
      ELSIF enb = '1' THEN
        reg_addr_dly_out1 <= reg_addr_burst_1;
      END IF;
    END IF;
  END PROCESS reg_addr_dly_process;


  -- <S3>/mstr_ack_dly
  mstr_ack_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        mstr_ack_dly_out1 <= '0';
      ELSIF enb = '1' THEN
        mstr_ack_dly_out1 <= mstr_ack_1;
      END IF;
    END IF;
  END PROCESS mstr_ack_dly_process;


  data_out_unsigned <= unsigned(data_out_1);

  -- <S3>/data_out_dly
  data_out_dly_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        data_out_dly_out1 <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        data_out_dly_out1 <= data_out_unsigned;
      END IF;
    END IF;
  END PROCESS data_out_dly_process;


  data_out <= std_logic_vector(data_out_dly_out1);

  -- <S3>/Terminator

  busy <= busy_dly_out1;

  I2C_SCL <= i2c_bidir_out1;

  n_ack <= n_ack_dly_out1;

  reg_data_burst <= reg_data_dly_out1;

  reg_addr_burst <= reg_addr_dly_out1;

  mstr_ack <= mstr_ack_dly_out1;

END rtl;

