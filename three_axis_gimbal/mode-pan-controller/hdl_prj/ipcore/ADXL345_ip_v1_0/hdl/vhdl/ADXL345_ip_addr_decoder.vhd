-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\mpu6050\ADXL345_ip_addr_decoder.vhd
-- Created: 2017-11-21 18:06:31
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ADXL345_ip_addr_decoder
-- Source Path: ADXL345_ip/ADXL345_ip_axi_lite/ADXL345_ip_addr_decoder
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ADXL345_ip_addr_decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        data_write                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   IN    std_logic;  -- ufix1
        rd_enb                            :   IN    std_logic;  -- ufix1
        read_AccelX                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        read_AccelY                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        read_AccelZ                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        read_validout                     :   IN    std_logic;  -- ufix1
        read_deviceID                     :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
        read_RegData                      :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
        read_GyroX                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        read_GyroY                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        read_GyroZ                        :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16
        data_read                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_axi_enable                  :   OUT   std_logic;  -- ufix1
        write_ConfigDevice                :   OUT   std_logic;  -- ufix1
        write_RegAddr                     :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
        );
END ADXL345_ip_addr_decoder;


ARCHITECTURE rtl OF ADXL345_ip_addr_decoder IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL addr_sel_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL decode_sel_AccelX                : std_logic;  -- ufix1
  SIGNAL read_AccelX_signed               : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL read_AccelY_signed               : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL read_AccelZ_signed               : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL read_deviceID_unsigned           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL read_RegData_unsigned            : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL read_GyroX_signed                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL read_GyroY_signed                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL read_GyroZ_signed                : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL decode_sel_GyroZ                 : std_logic;  -- ufix1
  SIGNAL decode_sel_GyroY                 : std_logic;  -- ufix1
  SIGNAL decode_sel_GyroX                 : std_logic;  -- ufix1
  SIGNAL decode_sel_RegData               : std_logic;  -- ufix1
  SIGNAL decode_sel_deviceID              : std_logic;  -- ufix1
  SIGNAL decode_sel_validout              : std_logic;  -- ufix1
  SIGNAL decode_sel_AccelZ                : std_logic;  -- ufix1
  SIGNAL decode_sel_AccelY                : std_logic;  -- ufix1
  SIGNAL const_0                          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_AccelX                  : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_AccelX                   : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_AccelX                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_AccelY                  : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_AccelY                   : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_AccelY                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_AccelZ                  : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_AccelZ                   : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_AccelZ                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_validout                : std_logic;  -- ufix1
  SIGNAL data_in_validout                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_validout               : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_deviceID                : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL data_in_deviceID                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_deviceID               : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_RegData                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL data_in_RegData                  : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_RegData                : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_GyroX                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_GyroX                    : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_GyroX                  : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_GyroY                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_GyroY                    : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_GyroY                  : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_GyroZ                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL data_in_GyroZ                    : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_GyroZ                  : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_sel_axi_enable            : std_logic;  -- ufix1
  SIGNAL reg_enb_axi_enable               : std_logic;  -- ufix1
  SIGNAL data_write_unsigned              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL data_in_axi_enable               : std_logic;  -- ufix1
  SIGNAL write_reg_axi_enable             : std_logic;  -- ufix1
  SIGNAL decode_sel_ConfigDevice          : std_logic;  -- ufix1
  SIGNAL reg_enb_ConfigDevice             : std_logic;  -- ufix1
  SIGNAL data_in_ConfigDevice             : std_logic;  -- ufix1
  SIGNAL write_reg_ConfigDevice           : std_logic;  -- ufix1
  SIGNAL decode_sel_RegAddr               : std_logic;  -- ufix1
  SIGNAL reg_enb_RegAddr                  : std_logic;  -- ufix1
  SIGNAL data_in_RegAddr                  : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL write_reg_RegAddr                : unsigned(7 DOWNTO 0);  -- ufix8

BEGIN
  addr_sel_unsigned <= unsigned(addr_sel);

  
  decode_sel_AccelX <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0041#, 14) ELSE
      '0';

  read_AccelX_signed <= signed(read_AccelX);

  const_1 <= '1';

  enb <= const_1;

  read_AccelY_signed <= signed(read_AccelY);

  read_AccelZ_signed <= signed(read_AccelZ);

  read_deviceID_unsigned <= unsigned(read_deviceID);

  read_RegData_unsigned <= unsigned(read_RegData);

  read_GyroX_signed <= signed(read_GyroX);

  read_GyroY_signed <= signed(read_GyroY);

  read_GyroZ_signed <= signed(read_GyroZ);

  
  decode_sel_GyroZ <= '1' WHEN addr_sel_unsigned = to_unsigned(16#004A#, 14) ELSE
      '0';

  
  decode_sel_GyroY <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0049#, 14) ELSE
      '0';

  
  decode_sel_GyroX <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0048#, 14) ELSE
      '0';

  
  decode_sel_RegData <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0047#, 14) ELSE
      '0';

  
  decode_sel_deviceID <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0046#, 14) ELSE
      '0';

  
  decode_sel_validout <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0044#, 14) ELSE
      '0';

  
  decode_sel_AccelZ <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0043#, 14) ELSE
      '0';

  
  decode_sel_AccelY <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0042#, 14) ELSE
      '0';

  const_0 <= to_unsigned(0, 32);

  reg_AccelX_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_AccelX <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_AccelX <= read_AccelX_signed;
      END IF;
    END IF;
  END PROCESS reg_AccelX_process;


  data_in_AccelX <= unsigned(resize(read_reg_AccelX, 32));

  
  decode_rd_AccelX <= const_0 WHEN decode_sel_AccelX = '0' ELSE
      data_in_AccelX;

  reg_AccelY_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_AccelY <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_AccelY <= read_AccelY_signed;
      END IF;
    END IF;
  END PROCESS reg_AccelY_process;


  data_in_AccelY <= unsigned(resize(read_reg_AccelY, 32));

  
  decode_rd_AccelY <= decode_rd_AccelX WHEN decode_sel_AccelY = '0' ELSE
      data_in_AccelY;

  reg_AccelZ_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_AccelZ <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_AccelZ <= read_AccelZ_signed;
      END IF;
    END IF;
  END PROCESS reg_AccelZ_process;


  data_in_AccelZ <= unsigned(resize(read_reg_AccelZ, 32));

  
  decode_rd_AccelZ <= decode_rd_AccelY WHEN decode_sel_AccelZ = '0' ELSE
      data_in_AccelZ;

  reg_validout_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_validout <= '0';
      ELSIF enb = '1' THEN
        read_reg_validout <= read_validout;
      END IF;
    END IF;
  END PROCESS reg_validout_process;


  data_in_validout <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & read_reg_validout;

  
  decode_rd_validout <= decode_rd_AccelZ WHEN decode_sel_validout = '0' ELSE
      data_in_validout;

  reg_deviceID_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_deviceID <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        read_reg_deviceID <= read_deviceID_unsigned;
      END IF;
    END IF;
  END PROCESS reg_deviceID_process;


  data_in_deviceID <= resize(read_reg_deviceID, 32);

  
  decode_rd_deviceID <= decode_rd_validout WHEN decode_sel_deviceID = '0' ELSE
      data_in_deviceID;

  reg_RegData_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_RegData <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        read_reg_RegData <= read_RegData_unsigned;
      END IF;
    END IF;
  END PROCESS reg_RegData_process;


  data_in_RegData <= resize(read_reg_RegData, 32);

  
  decode_rd_RegData <= decode_rd_deviceID WHEN decode_sel_RegData = '0' ELSE
      data_in_RegData;

  reg_GyroX_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_GyroX <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_GyroX <= read_GyroX_signed;
      END IF;
    END IF;
  END PROCESS reg_GyroX_process;


  data_in_GyroX <= unsigned(resize(read_reg_GyroX, 32));

  
  decode_rd_GyroX <= decode_rd_RegData WHEN decode_sel_GyroX = '0' ELSE
      data_in_GyroX;

  reg_GyroY_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_GyroY <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_GyroY <= read_GyroY_signed;
      END IF;
    END IF;
  END PROCESS reg_GyroY_process;


  data_in_GyroY <= unsigned(resize(read_reg_GyroY, 32));

  
  decode_rd_GyroY <= decode_rd_GyroX WHEN decode_sel_GyroY = '0' ELSE
      data_in_GyroY;

  reg_GyroZ_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        read_reg_GyroZ <= to_signed(16#0000#, 16);
      ELSIF enb = '1' THEN
        read_reg_GyroZ <= read_GyroZ_signed;
      END IF;
    END IF;
  END PROCESS reg_GyroZ_process;


  data_in_GyroZ <= unsigned(resize(read_reg_GyroZ, 32));

  
  decode_rd_GyroZ <= decode_rd_GyroY WHEN decode_sel_GyroZ = '0' ELSE
      data_in_GyroZ;

  data_read <= std_logic_vector(decode_rd_GyroZ);

  
  decode_sel_axi_enable <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0001#, 14) ELSE
      '0';

  reg_enb_axi_enable <= decode_sel_axi_enable AND wr_enb;

  data_write_unsigned <= unsigned(data_write);

  data_in_axi_enable <= data_write_unsigned(0);

  reg_axi_enable_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        write_reg_axi_enable <= '1';
      ELSIF enb = '1' AND reg_enb_axi_enable = '1' THEN
        write_reg_axi_enable <= data_in_axi_enable;
      END IF;
    END IF;
  END PROCESS reg_axi_enable_process;


  write_axi_enable <= write_reg_axi_enable;

  
  decode_sel_ConfigDevice <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0040#, 14) ELSE
      '0';

  reg_enb_ConfigDevice <= decode_sel_ConfigDevice AND wr_enb;

  data_in_ConfigDevice <= data_write_unsigned(0);

  reg_ConfigDevice_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        write_reg_ConfigDevice <= '0';
      ELSIF enb = '1' AND reg_enb_ConfigDevice = '1' THEN
        write_reg_ConfigDevice <= data_in_ConfigDevice;
      END IF;
    END IF;
  END PROCESS reg_ConfigDevice_process;


  write_ConfigDevice <= write_reg_ConfigDevice;

  
  decode_sel_RegAddr <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0045#, 14) ELSE
      '0';

  reg_enb_RegAddr <= decode_sel_RegAddr AND wr_enb;

  data_in_RegAddr <= data_write_unsigned(7 DOWNTO 0);

  reg_RegAddr_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        write_reg_RegAddr <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' AND reg_enb_RegAddr = '1' THEN
        write_reg_RegAddr <= data_in_RegAddr;
      END IF;
    END IF;
  END PROCESS reg_RegAddr_process;


  write_RegAddr <= std_logic_vector(write_reg_RegAddr);

END rtl;

