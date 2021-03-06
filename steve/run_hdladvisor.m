DUTParam.DUT = [bdroot '/fpga_dut'];
DUTParam.Workflow = 'IP Core Generation';
DUTParam.Board = 'Xilinx Zynq ZC706 evaluation kit';
DUTParam.Dir = 'hdl_zc706';
DUTParam.ReferenceDesign = 'MathWorks VITA Camera Reference Platform (ISE 14.4)';
DUTParam.TargetInterface = {
    ... % INPUTS
    {'VideoIn', 'AXI4-Stream Video In', []},...
    {'Htarg', 'AXI4-Lite', []},...
    {'Hthresh', 'AXI4-Lite', []},...
    {'Starg', 'AXI4-Lite', []},...
    {'Sthresh', 'AXI4-Lite', []},...
    {'Vtarg', 'AXI4-Lite', []},...
    {'Vthresh', 'AXI4-Lite', []},...
    {'xtarg', 'AXI4-Lite', []},...
    {'xthresh', 'AXI4-Lite', []},...
    {'ytarg', 'AXI4-Lite', []},...
    {'ythresh', 'AXI4-Lite', []},...
    {'OutputSel', 'AXI4-Lite', []},...
    {'P1', 'AXI4-Lite', []},...
    {'P2', 'AXI4-Lite', []},...
    {'P3', 'AXI4-Lite', []},...
    {'P4', 'AXI4-Lite', []},...
    {'force_p', 'Switches MotorBoard [0:3]', []},...
    {'force_n', 'Switches MotorBoard [0:3]', []},...
    {'disable', 'AXI4-Lite', []},...
    {'Kp', 'AXI4-Lite', []},...
    {'Ki', 'AXI4-Lite', []},...
    {'Kd', 'AXI4-Lite', []},...
    {'pwm_cnt', 'AXI4-Lite', []},...
    {'desired_pos', 'AXI4-Lite', []},...
    {'a2d_in', 'ADC MotorBoard [0:7]', []},...
    ... % OUTPUTS
    {'VideoOut', 'AXI4-Stream Video Out', []},...
    {'x_o', 'AXI4-Lite', []},...
    {'y_o', 'AXI4-Lite', []},...
    {'npoints_o', 'AXI4-Lite', []},...
    {'drive_p', 'DriveP MotorBoard', []},...
    {'drive_n', 'DriveN MotorBoard', []},...
    {'drive_led_p', 'LEDs MotorBoard [0:3]', []},...
    {'drive_led_n', 'LEDs MotorBoard [0:3]', []},...
    {'pwm_trig', 'AXI4-Lite', []},...
    {'dir_dbg', 'AXI4-Lite', []},...
    {'signal_dbg', 'AXI4-Lite', []},...
    {'a2d_soc', 'SOC MotorBoard', []},...
    {'a2d_led', 'LEDs General Purpose [0:3]', []},...
    {'adc_dbg', 'AXI4-Lite', []},...
    {'adc_eoc', 'LEDs MotorBoard [0:3]', []},...
};

hdlturnkey.util.setupHDLWAInterface(DUTParam)