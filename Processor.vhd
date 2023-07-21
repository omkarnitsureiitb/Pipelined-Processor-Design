library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity Processor is
   port(rst,CLK50MHZ : in std_logic;
		  Carry, Zero: out std_logic); --2 random signals given as outputs to use the Testbench( Given to us 1n EE214 Lab) for testing
end entity Processor;


architecture Struct of Processor is

component Stage1 is
	port(clk: in std_logic;
	     rst: in std_logic;
		  PC_en: in std_logic;
		  mux9_out: in std_logic;
		  mux13_control: in std_logic_vector(3 downto 0);
		  Rf_d2: in std_logic_vector(15 downto 0);
		  ALU3_H1: in std_logic_vector(15 downto 0);
		  ALU3_H2: in std_logic_vector(15 downto 0);
		  DM_out: in std_logic_vector(15 downto 0);
		  LLI_H1: in std_logic_vector(15 downto 0);
		  LLI_H2: in std_logic_vector(15 downto 0);
		  ALU2_out: in std_logic_vector(15 downto 0);
		  Inst: out std_logic_vector(15 downto 0);
		  PC_current: out std_logic_vector(15 downto 0));
end component Stage1;

component pipelineReg1 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  output1: out std_logic_vector(31 DOWNTO 0));
end component pipelineReg1;

component stage2 is
	port(pen_en: in std_logic;
	inst: in std_logic_vector(15 downto 0);
	carry, zero, reset: in std_logic;
	reg_load_curr: in std_logic_vector(7 downto 0);
	control_signal: out std_logic_vector(50 downto 0);
	reg_addr: out std_logic_vector(2 downto 0);
	reg_load_next: out std_logic_vector(7 downto 0);
	end_inst: out std_logic);
end component stage2;

component pipelineReg2 is 
	port(output1: in std_logic_vector(31 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  control_word:in std_logic_vector(50 DOWNTO 0);
		  pen7_0:in std_logic_vector(7 DOWNTO 0);
		  pen2_0: std_logic_vector(2 DOWNTO 0);
	     endLMSM: in std_logic;
		  output2: out std_logic_vector(94 DOWNTO 0));
end component pipelineReg2;

component stage3 is
	port(reset: in std_logic;
		  clk: in std_logic;
		  rd: in std_logic;
		  wr: in std_logic;
		  IR11_9: in std_logic_vector(2 downto 0);
		  IR8_6: in std_logic_vector(2 downto 0);
		  IR5_3: in std_logic_vector(2 downto 0);
	     pen_outAddPrev: in std_logic_vector(2 downto 0);
	     pen_outAddNow: in std_logic_vector(2 downto 0);
		  a3_control: in std_logic_vector(1 downto 0);
		  d3_control: in std_logic;
	     mux16_control: in std_logic;
	     a2_control: in std_logic;
		  wb_mux: in std_logic_vector(15 downto 0);
		  jmp_data: in std_logic_vector(15 downto 0);
		  PCin_now: in std_logic_vector(15 downto 0);
	     d1: out std_logic_vector(15 downto 0);
		  d2: out std_logic_vector(15 downto 0);
		  T1_adder_out: in std_logic_vector(15 downto 0);
	     T1_out: out std_logic_vector(15 downto 0);
	     T1mux_control: in std_logic);
end component stage3;

component pipelineReg3 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  control_word:in std_logic_vector(50 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  pen2_0: in std_logic_vector(2 DOWNTO 0);
		  Rf_d1: in std_logic_vector(15 DOWNTO 0);
		  Rf_d2: in std_logic_vector(15 DOWNTO 0);
		  T1_out: in std_logic_vector(15 DOWNTO 0);
		  output3: out std_logic_vector(133 DOWNTO 0));
end component pipelineReg3;

component stage4 is 
	port(clk: in std_logic;
		  inst: in std_logic_vector(15 downto 0);
	     inst1: in std_logic_vector(15 downto 0);
	     inst2: in std_logic_vector(15 downto 0);
		  control : in std_logic_vector(50 downto 0);
		  alu_hazard1: in std_logic_vector(15 downto 0);
		  alu_hazard2: in std_logic_vector(15 downto 0);
		  dm_hazard: in std_logic_vector(15 downto 0);
		  LLI_appender_hazard1: in std_logic_vector(15 downto 0);
		  LLI_appender_hazard2: in std_logic_vector(15 downto 0);
		  d1: in std_logic_vector(15 downto 0);
		  d2: in std_logic_vector(15 downto 0);
		  PC_out: in std_logic_vector(15 downto 0);
		  T1_in_stg3: in std_logic_vector(15 downto 0);
		  modified_control: out std_logic_vector(50 downto 0);
		  T1_out_stg4: out std_logic_vector(15 downto 0);
	     T1_adder_out: out std_logic_vector(15 downto 0);
		  adder2_out: out std_logic_vector(15 downto 0);
		  ALU3_out: out std_logic_vector(15 downto 0);
		  zero_appender_imm_out: out std_logic_vector(15 downto 0);
		  mux9_out: out std_logic;
		  Carry: out std_logic;
		  Zero: out std_logic);
end component stage4;

component pipelineReg4 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  control_word_modif:in std_logic_vector(50 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  Carry: in std_logic;
		  pen2_0: in std_logic_vector(2 DOWNTO 0);
		  Rf_d1: in std_logic_vector(15 DOWNTO 0);
		  Rf_d2: in std_logic_vector(15 DOWNTO 0);
		  T1_out: in std_logic_vector(15 DOWNTO 0);
		  ALU2_out: in std_logic_vector(15 DOWNTO 0);
		  ALU3_out: in std_logic_vector(15 DOWNTO 0);
		  zero_appended: in std_logic_vector(15 DOWNTO 0);
		  T1_adder_out: in std_logic_vector(15 DOWNTO 0);
		  output4: out std_logic_vector(198 DOWNTO 0));
end component pipelineReg4;

component stage5 is
	port(rd: in std_logic;
		  wr: in std_logic;
		  clk: in std_logic;
		  T1_out: in std_logic_vector(15 downto 0);
		  ALU2_out: in std_logic_vector(15 downto 0);
		  Rf_d1: in std_logic_vector(15 downto 0);
		  Rf_d2: in std_logic_vector(15 downto 0);
		  DM_data_hazard: in std_logic_vector(15 downto 0);
		  DM_data_out: out std_logic_vector(15 downto 0);
		  mux17_control: in std_logic;
		  mux11_control: in std_logic_vector(1 downto 0));
end component stage5;

component pipelineReg5 is 
	port(clk: in std_logic;
		  en: in std_logic;
		  output4: in std_logic_vector(198 DOWNTO 0);
		  dm_data: in std_logic_vector(15 DOWNTO 0);
		  output5: out std_logic_vector(214 DOWNTO 0));
end component pipelineReg5;

component stage6 is
	port(ALU3_out: in std_logic_vector(15 downto 0);
		  DM_out: in std_logic_vector(15 downto 0);
		  mux_control: in std_logic;
		  IR11_9in: in std_logic_vector(2 downto 0);
		  IR8_6in: in std_logic_vector(2 downto 0);
		  IR5_3in: in std_logic_vector(2 downto 0);
		  IR11_9out: out std_logic_vector(2 downto 0);
		  IR8_6out: out std_logic_vector(2 downto 0);
		  IR5_3out: out std_logic_vector(2 downto 0);
		  z_appendedin: in std_logic_vector(15 downto 0);
		  z_appendedout: out std_logic_vector(15 downto 0);
		  wb_data: out std_logic_vector(15 downto 0);
		  penin2_0: in std_logic_vector(2 downto 0);
		  penout2_0: out std_logic_vector(2 downto 0));
end component stage6;

component ALU is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
		  C1: in std_logic; C0: in std_logic;  Cin: in std_logic;  Zin: in std_logic;
		  ALU_C: out std_logic_vector(15 downto 0);
		  C: out std_logic; Z: out std_logic);
end component ALU;

component MUX_8To1 is
	port(Add: in std_logic_vector(2 downto 0);
		  D0, D1, D2, D3, D4, D5, D6, D7: in std_logic_vector(15 downto 0);
		  OUTPUT: out std_logic_vector(15 downto 0));
end component MUX_8To1;

component PC is 
	port(d: in std_logic_vector(15 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  rst: in std_logic;
		  q: out std_logic_vector(15 DOWNTO 0));
end component PC;

component PC_Incrementer is
	port(PC_curr: in std_logic_vector(15 downto 0);
		  PC_next: out std_logic_vector(15 downto 0));
end component PC_Incrementer;

component PriorityEncoder is 
	port(reg_load_curr: in std_logic_vector(7 downto 0);
		  pen_en: in std_logic;
		  end_inst: out std_logic;
		  reg_load_next: out std_logic_vector(7 downto 0);
		  reg_addr: out std_logic_vector(2 downto 0));
end component PriorityEncoder;

component SE6 is
port (BIT6_data: in std_logic_vector(5 downto 0);
	   Y: out std_logic_vector(15 downto 0));
end component SE6;

component SE9 is
port (BIT9_data: in std_logic_vector(8 downto 0);
	   Y: out std_logic_vector(15 downto 0));
end component SE9;


component bitReg is 
	port(d: in std_logic;
		  en: in std_logic;
		  clk: in std_logic;
		  q: out std_logic);
end component bitReg;

component Complementer is
	port(rf_d2: in std_logic_vector(15 downto 0);
		  complement: out std_logic_vector(15 downto 0));
end component Complementer;

component controller_logic is
	port(inst: in std_logic_vector(15 downto 0);
	reset: in std_logic;
	carry: in std_logic;
	zero: in std_logic;
	control_final: out std_logic_vector(50 downto 0));
end component controller_logic;

component DataMemory is 
	port(data_in: in std_logic_vector(15 downto 0);
		  mem_add: in std_logic_vector(15 downto 0);
		  rd: in std_logic;
		  wr: in std_logic;
		  clk: in std_logic;
		  data_out: out std_logic_vector(15 downto 0));
end component DataMemory;

component mux16to1 is
	port(S: in std_logic_vector(3 downto 0);
	     D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15: in std_logic_vector(15 downto 0);
	     Y: out std_logic_vector(15 downto 0));
end component mux16to1;

component mux2to1 is
   port(S0: in std_logic;
		  D0,D1: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end component mux2to1;

component mux4to1 is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic_vector(15 downto 0);
		Y: out std_logic_vector(15 downto 0)
	);
end component mux4to1;
	
component mux4to1_for_BLE is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic;
		Y: out std_logic
	);
end component mux4to1_for_BLE;

component reg_file is 
	port(ra1: in std_logic_vector(2 downto 0);
	     ra2: in std_logic_vector(2 downto 0);
		  wa3: in std_logic_vector(2 downto 0);
		  wd3: in std_logic_vector(15 downto 0);
		  PC_in: in std_logic_vector(15 downto 0);
		  wr: in std_logic;
		  rd: in std_logic;
		  clk:in std_logic;
		  rd1: out std_logic_vector(15 downto 0);
		  rd2: out std_logic_vector(15 downto 0));
end component reg_file;

component zero_Appender_Carry is
port (C: in std_logic;
	   Y: out std_logic_vector(15 downto 0));
end component zero_Appender_Carry;

component zero_Appender_Imm is
port (Imm: in std_logic_vector(8 downto 0);
	   Y: out std_logic_vector(15 downto 0));
end component zero_Appender_Imm;

component Reg is 
	port(d: in std_logic_vector(15 DOWNTO 0);
	     en: in std_logic;
	     clk: in std_logic;
	     q: out std_logic_vector(15 DOWNTO 0));
end component Reg;

	signal clk, mux9_C, CarrySig, ZeroSig, endLMSM: std_logic;
	signal Pen_address, penout_AddPrev, IR11_9, IR8_6, IR5_3: std_logic_vector(2 downto 0);
	signal ALU3_H1, ALU3_H2, DM_data_out, LLI_H1, LLI_H2, ALU2_out, Inst, PC_current, Rf_d1, Rf_d2,
			 wb_mux_out, zero_appended9, T1_adder_out, T1_out, ALU3_out: std_logic_vector(15 downto 0);
	signal Pen_next: std_logic_vector(7 downto 0);
	signal dummy1: std_logic_vector(31 downto 0);
	signal controls, controls_hazard: std_logic_vector(50 downto 0);
	signal dummy2: std_logic_vector(94 downto 0);
	signal dummy3: std_logic_vector(133 downto 0);
	signal dummy4: std_logic_vector(198 downto 0);
	signal dummy5: std_logic_vector(214 downto 0);

	begin

	clk <= CLK50MHZ;

------Instruction Fetch------

	st1: Stage1 port map(clk => clk, rst => rst, PC_en => controls(11), mux9_out => mux9_C, mux13_control => controls(21 downto 18),
								Rf_d2 => Rf_d2, ALU3_H1 => dummy4(47 downto 32), ALU3_H2 => dummy5(63 downto 48), DM_out => DM_data_out, LLI_H1 => dummy4(31 downto 16),
								LLI_H2 => dummy5(47 downto 32), ALU2_out => ALU2_out, Inst => Inst, PC_current => PC_current);
								
	pipReg1: pipelineReg1 port map(PC => PC_current, IR => Inst, en => controls(4), clk => clk, output1 => dummy1);

------Instruction Decode------

	st2: stage2 port map(inst => dummy1(31 downto 16), carry => CarrySig, zero => ZeroSig, reset => rst, reg_load_next => Pen_next, control_signal => controls,
								reg_addr => Pen_address, end_inst => endLMSM, pen_en => dummy2(94), reg_load_curr => dummy2(61 downto 54));
								
	pipReg2: pipelineReg2 port map(output1 => dummy1, en => controls(3), clk => clk, control_word => controls, pen7_0 => Pen_next,
											 pen2_0 => Pen_address, endLMSM => endLMSM, output2 => dummy2);
											 
------Operand Read------
											 
	st3: stage3 port map(reset => rst, clk => clk, rd => dummy2(13), wr => dummy5(144), IR11_9 => IR11_9, IR8_6 => IR8_6, IR5_3 => IR5_3,
								a3_control => dummy5(178 downto 177), d3_control => dummy5(176), mux16_control => dummy2(15), a2_control => dummy2(17),
								wb_mux => wb_mux_out, jmp_data => dummy5(47 downto 32), PCin_now => dummy1(31 downto 16), d1 => Rf_d1, d2 => Rf_d2,
								T1_adder_out => T1_adder_out, T1_out => T1_out, T1mux_control => dummy2(15), pen_outAddNow => dummy2(53 downto 51),
								pen_outAddPrev => penout_AddPrev);
						
	pipReg3: pipelineReg3 port map(PC => dummy2(93 downto 78), IR => dummy2(77 downto 62), control_word => dummy2(50 downto 0), en => dummy2(2), clk => clk,
											 pen2_0 => dummy2(53 downto 51), Rf_d1 => Rf_d1, Rf_d2 => Rf_d2, T1_out => T1_out, output3 => dummy3);
											 
------Execution------
											 
	st4: stage4 port map(clk => clk, inst => dummy3(117 downto 102), inst1 => dummy4(198 downto 183), inst2 => dummy5(214 downto 199),
								control => dummy3(101 downto 51), alu_hazard1 => dummy4(47 downto 32), alu_hazard2 => dummy5(63 downto 48),
								dm_hazard => dummy5(15 downto 0), LLI_appender_hazard1 => dummy4(31 downto 16), LLI_appender_hazard2 => dummy5(47 downto 32),
								d1 => dummy3(47 downto 32), d2 => dummy3(31 downto 16), T1_in_stg3 => dummy3(15 downto 0), T1_out_stg4 => dummy3(15 downto 0),
								zero_appender_imm_out => zero_appended9, adder2_out => ALU2_out,	modified_control => controls_hazard, ALU3_out => ALU3_out,
								mux9_out => mux9_C, PC_out => dummy3(133 downto 118), T1_adder_out => T1_adder_out, Carry => CarrySig, Zero => ZeroSig);
								
	pipReg4: pipelineReg4 port map(PC => dummy3(133 downto 118), IR => dummy3(117 downto 102), control_word_modif => controls_hazard, en => dummy3(52),
											 clk => clk, pen2_0 => dummy3(50 downto 48), Rf_d1 => dummy3(47 downto 32), Rf_d2 => dummy3(31 downto 16),
											 ALU2_out => ALU2_out, ALU3_out => ALU3_out, zero_appended => zero_appended9, T1_adder_out => T1_adder_out,
											 T1_out => dummy3(15 downto 0), Carry => CarrySig, output4 => dummy4);
											 
------Memory Read/Write-----
					
	st5: stage5 port map(rd => dummy4(122), wr => dummy4(121), clk => clk, T1_out => dummy4(15 downto 0), ALU2_out => dummy4(63 downto 48),
								Rf_d1 => dummy4(111 downto 96), Rf_d2 => dummy4(95 downto 80), DM_data_out => DM_data_out, mux17_control => dummy4(130),
								mux11_control => dummy4(140 downto 139), DM_data_hazard => dummy5(15 downto 0));
								
	pipReg5: pipelineReg5 port map(clk => clk, en => dummy4(116), output4 => dummy4, dm_data => DM_data_out, output5 => dummy5);

------Write back------

	st6: stage6 port map(ALU3_out => dummy5(63 downto 48), DM_out => dummy5(15 downto 0), mux_control => dummy5(154), IR11_9in => dummy5(194 downto 192),
								IR8_6in => dummy5(191 downto 189), IR5_3in => dummy5(188 downto 186), IR11_9out => IR11_9, IR8_6out => IR8_6, IR5_3out => IR5_3,
								z_appendedin => dummy5(47 downto 32), z_appendedout => dummy5(47 downto 32), wb_data => wb_mux_out, penin2_0 => dummy5(132 downto 130),
								penout2_0 => penout_AddPrev);
							
end architecture Struct;
