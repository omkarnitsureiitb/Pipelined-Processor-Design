--Stage1
library ieee;
use ieee.std_logic_1164.all;

entity Stage1 is
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
end entity Stage1;

architecture Struct of Stage1 is

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

component InstrMemory is
	port(mem_add: in std_logic_vector(15 downto 0);
		  Inst: out std_logic_vector(15 downto 0));
end component InstrMemory;

component reg_with_reset is 
	port(d: in std_logic_vector(15 DOWNTO 0);
		  en: in std_logic;
		  rst: in std_logic;
		  clk: in std_logic;
		  q: out std_logic_vector(15 DOWNTO 0));
end component reg_with_reset;

component PC_Incrementer is
	port(PC_curr: in std_logic_vector(15 downto 0);
		  PC_next: out std_logic_vector(15 downto 0));
end component PC_Incrementer;

signal sig1, sig2, PC_next, PC_C: std_logic_vector(15 downto 0);

begin

	mux1 : mux2to1 port map (S0 => mux9_out, D0 => PC_next, D1 => ALU2_out, Y => sig1);
	
	PC_inc: PC_Incrementer port map(PC_curr => PC_C, PC_next => PC_next);
	
	inst1: InstrMemory port map(mem_add => PC_C, Inst => Inst);
	
	PC_d: reg_with_reset port map(d => sig2, en => PC_en, clk => clk, rst => rst, q => PC_C); 
	
	mux2: mux16to1 port map(S =>mux13_control, D0 => PC_next, D2 => sig1, D3 => PC_C, D5 => ALU2_out, D4 => Rf_d2,
									D7 => ALU3_H1, D1 => ALU3_H2, D13 => DM_out, D6 => LLI_H1, D15 => LLI_H2, D8 => PC_C,
									D9 => PC_C,D10=> PC_C,D11 => PC_C,D12 => PC_C,D14 => PC_C, Y => sig2);
	PC_current<=PC_C;
  
end architecture Struct;