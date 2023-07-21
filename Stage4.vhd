--Stage 4
library ieee;
use ieee.std_logic_1164.all;           

entity stage4 is 
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
end entity stage4;

architecture struct of stage4 is
	
	component mux4to1 is
		port(
			S1,S0: in std_logic;
			D0,D1,D2,D3: in std_logic_vector(15 downto 0);
			Y: out std_logic_vector(15 downto 0)
		);
	end component mux4to1;
	

	component mux2to1 is
		port(
			S0: in std_logic;
			D0,D1: in std_logic_vector(15 downto 0);
			Y: out std_logic_vector(15 downto 0)
		);
	end component mux2to1;
	
	
	component MUX_8To1 is
	port(Add: in std_logic_vector(2 downto 0);
		  D0, D1, D2, D3, D4, D5, D6, D7: in std_logic_vector(15 downto 0);
		  OUTPUT: out std_logic_vector(15 downto 0));
	end component MUX_8To1;

	
	component ALU is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
		  C1: in std_logic; C0: in std_logic;  Cin: in std_logic;  Zin: in std_logic;
		  ALU_C: out std_logic_vector(15 downto 0);
		  C: out std_logic; Z: out std_logic);
	end component ALU;
 
 
   component Complementer is
	port(rf_d2: in std_logic_vector(15 downto 0);
		  complement: out std_logic_vector(15 downto 0));
	end component Complementer;
	
	
	component SE9 is
	port (BIT9_data: in std_logic_vector(8 downto 0);
			Y: out std_logic_vector(15 downto 0));
	end component SE9;
	
	
	component SE6 is
	port (BIT6_data: in std_logic_vector(5 downto 0);
			Y: out std_logic_vector(15 downto 0));
	end component SE6;
	
	
	component ADD is
	port(A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0); C_add: out std_logic);
	end component ADD;
	
	
	component zero_Appender_Imm is
	port (Imm: in std_logic_vector(8 downto 0);
			Y: out std_logic_vector(15 downto 0));
	end component zero_Appender_Imm;
	
	
	component zero_Appender_Carry is
	port (C: in std_logic;
			Y: out std_logic_vector(15 downto 0));
	end component zero_Appender_Carry;
	
	
	component bitReg is 
	port(d: in std_logic;
		  en: in std_logic;
		  clk: in std_logic;
		  q: out std_logic);
	end component bitReg;
	
	
	component mux4to1_for_BLE is
   port(
		S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic;
		Y: out std_logic
	);
	end component mux4to1_for_BLE;
	
	component mux16to1 is
    Port ( D0 : in std_logic_vector(15 downto 0);
			  D1 : in std_logic_vector(15 downto 0);
			  D2 : in std_logic_vector(15 downto 0);
			  D3 : in std_logic_vector(15 downto 0);
			  D4 : in std_logic_vector(15 downto 0);
			  D5 : in std_logic_vector(15 downto 0);
			  D6 : in std_logic_vector(15 downto 0);
			  D7 : in std_logic_vector(15 downto 0);
			  D8 : in std_logic_vector(15 downto 0);
			  D9 : in std_logic_vector(15 downto 0);
			  D10 : in std_logic_vector(15 downto 0);
			  D11 : in std_logic_vector(15 downto 0);
			  D12: in std_logic_vector(15 downto 0);
			  D13: in std_logic_vector(15 downto 0);
			  D14 : in std_logic_vector(15 downto 0);
			  D15 : in std_logic_vector(15 downto 0);
           s : in std_logic_vector(3 downto 0);
           y : out std_logic_vector(15 downto 0));
	end component mux16to1;
	
component hazard_unit is
	port(ir1: in std_logic_vector(15 downto 0);
		  ir2: in std_logic_vector(15 downto 0);
		  ir3: in std_logic_vector(15 downto 0);
		  control_word1 : in std_logic_vector(50 downto 0);
		  modified_control_word : out std_logic_vector(50 downto 0));	  
		  
end component hazard_unit;
	
	signal mux3, mux4, mux5, mux6, mux7, mux8, t1_signal, comp_out, SE6_out, SE9_out, C_appnd, adder4_out: std_logic_vector(15 downto 0);
	signal j_imm: std_logic_vector(15 downto 0);
	signal i_imm: std_logic_vector(15 downto 0);
	signal OPCODE_last2bits: std_logic_vector(1 downto 0) ;
	signal C_alu3, Z_alu3, Cout_bit, Zout_bit: std_logic;
	signal imm_out: std_logic_vector(5 downto 0);
	signal jmp_out: std_logic_vector(8 downto 0);
	signal mux5_control, mux3_control: std_logic_vector(2 downto 0);
	signal mux6_control: std_logic_vector(3 downto 0);
	signal mux7_control, mux8_control, mux4_control, alu3_control: std_logic_vector(1 downto 0);
	signal temp, temp1: std_logic;

	begin

	OPCODE_last2bits <= inst(1 downto 0);
	imm_out <= inst(5 downto 0);
	jmp_out <= inst(8 downto 0);
	mux5_control <= control(38 downto 36);
	mux3_control <= control(43 downto 41);
	mux4_control <= control(40 downto 39);
	mux6_control <= control(35 downto 32);
	mux7_control <= control(31 downto 30);
	mux8_control <= control(29 downto 28);
	alu3_control <= control(8 downto 7);

	comp: complementer port map(rf_d2=>d2, complement=>comp_out);

	carry_append: zero_Appender_Carry port map(C=>C_alu3, Y=> C_appnd);


	SE_6: SE6 port map(BIT6_data=>imm_out, Y=> i_imm);
	SE_9: SE9 port map(BIT9_data=>jmp_out, Y=> j_imm); 

	bit_C_reg: bitReg port map( d=> C_alu3, en=>'1', clk=>clk, q=>Cout_bit); 
	bit_Z_reg: bitReg port map( d=> Z_alu3, en=>'1', clk=>clk, q=>Zout_bit); 

	mux_5: MUX_8To1 port map(Add => mux5_control, D0=>d1, D1=>dm_hazard, D2=>alu_hazard2 ,D3=>LLI_appender_hazard2,
									D4=>alu_hazard1, D5=>PC_out, D6=>PC_out,
									D7=>LLI_appender_hazard1, OUTPUT=>mux5);


	mux_6: mux16to1 port map(d2, alu_hazard2, alu_hazard1, comp_out, adder4_out, j_imm, "0000000000000010", LLI_appender_hazard1, 
								dm_hazard, dm_hazard, dm_hazard, dm_hazard, dm_hazard, dm_hazard, dm_hazard, dm_hazard, mux6_control, mux6);


	mux_7:	mux4to1 port map(S0 => mux7_control(0), S1 => mux7_control(1), D0 => C_appnd, D1 => j_imm, D2 => i_imm, D3 => i_imm, Y => mux7);	

							
	mux_8: mux4to1 port map(S0 => mux8_control(0), S1 => mux8_control(1), D0 => i_imm, D1 => j_imm, D2 => d2, D3 => comp_out, Y => mux8);

	mux_3: MUX_8To1 port map(Add => mux3_control, D0 => dm_hazard, D1 => PC_out, D2 => d1 ,D3 => d2,
									D4 => alu_hazard2, D5 => LLI_appender_hazard2, D6 => LLI_appender_hazard1,
									D7 => alu_hazard1, OUTPUT => mux3); 								

	mux_4: mux4to1 port map(S0 => mux4_control(0),S1=> mux4_control(1), D0=>i_imm, D1=>adder4_out, D2=>alu_hazard1 ,D3=>alu_hazard2, Y=>mux4);          

	ADDER2: ADD port map(A=>mux3, B=>mux4, Y=>adder2_out); 			  
				  
	ADDER4: ADD port map(A=>mux7, B=>mux8, Y=>adder4_out);

	ALU3 : ALU port map(ALU_A=>mux5, ALU_B=>mux6, C1=>alu3_control(1), C0=>alu3_control(0), Cin=>Cout_bit, Zin=>Zout_bit, ALU_C=>ALU3_out, C=>C_alu3, Z=>Z_alu3);
		
	temp <= C_alu3 or Z_alu3;
	temp1 <= C_alu3 and Z_alu3;
		
	mux_9: mux4to1_for_BLE port map(S0 => OPCODE_last2bits(0), S1 => OPCODE_last2bits(1), D0 => Z_alu3, D1 => C_alu3, D2 => temp, D3 => temp1, Y => mux9_out);

	zapc: zero_appender_Imm port map(Imm=>jmp_out, Y=>zero_appender_imm_out);

	t1_adder: ADD port map(A=>T1_in_stg3, B=>"0000000000000001", Y=> T1_adder_out);
		
	T1_out_stg4 <= T1_in_stg3;

	Carry <= C_alu3;
	Zero <= Z_alu3;
		
	hazard: hazard_unit port map(ir1 => inst2, ir2 => inst1, ir3 => inst, control_word1 => control, modified_control_word => modified_control);
 
end architecture struct;
		  
