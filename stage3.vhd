--Stage 3
library ieee;
use ieee.std_logic_1164.all;

entity stage3 is
	port(clk: in std_logic;
		  rd: in std_logic;
		  wr: in std_logic;
		  reset: in std_logic;
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
end entity stage3;

architecture Struct of stage3 is

component reg_with_reset is 
	port(d: in std_logic_vector(15 DOWNTO 0);
		clk: in std_logic;
		en: in std_logic;
		rst: in std_logic;
		q: out std_logic_vector(15 DOWNTO 0));
end component reg_with_reset;

component mux4to1_3bits is
	port(S1, S0: in std_logic;
		  D0, D1, D2, D3: in std_logic_vector(2 downto 0);
		  Y: out std_logic_vector(2 downto 0));
end component mux4to1_3bits;

component mux2to1_3bits is
   port(S0: in std_logic;
	D0,D1: in std_logic_vector(2 downto 0);
	Y: out std_logic_vector(2 downto 0));
end component mux2to1_3bits;

component reg_file is 
	port(ra1: in std_logic_vector(2 downto 0);
	     ra2: in std_logic_vector(2 downto 0);
		  wa3: in std_logic_vector(2 downto 0);
		  wd3: in std_logic_vector(15 downto 0);
		  PC_in: in std_logic_vector(15 downto 0);
		  wr: in std_logic;
		  rd: in std_logic;
		  clk:in std_logic;
		  reset: in std_logic;
		  rd1: out std_logic_vector(15 downto 0);
		  rd2: out std_logic_vector(15 downto 0));
end component reg_file;

component mux2to1_16bits is
   port(S0: in std_logic;
	D0,D1: in std_logic_vector(15 downto 0);
	Y: out std_logic_vector(15 downto 0));
end component mux2to1_16bits;

	signal Rf_a2, a3_mux: std_logic_vector(2 downto 0);
	signal d3_mux, T1_in, d1_dummy, d2_dummy: std_logic_vector(15 downto 0);

	begin

	mux1: mux2to1_16bits port map(S0 => d3_control, D0 => jmp_data, D1 => wb_mux, Y => d3_mux);	--mux2
	mux2: mux4to1_3bits port map(S0 => a3_control(0), S1 => a3_control(1), D0 => IR11_9, D1 => IR5_3, D2 => IR8_6, D3 => pen_outAddPrev, Y => a3_mux);	--mux1
	mux3: mux2to1_3bits port map(S0 => a2_control, D0 => IR8_6, D1 => pen_outAddNow, Y => Rf_a2);		--mux14
	mux4: mux2to1_16bits port map(S0 => mux16_control, D0 => T1_adder_out, D1 => d1_dummy, Y => T1_in);		--mux16
	reg1: reg_with_reset port map(d => T1_in, clk => clk, en => T1mux_control, q => T1_out, rst => reset);

	RF: reg_file port map(reset => reset, ra1 => IR11_9, ra2 => Rf_a2, wa3 => a3_mux, wd3 => d3_mux, PC_in => PCin_now, wr => wr, rd => rd, clk => clk, rd1 => d1_dummy, rd2 => d2_dummy);
		
	d1 <= d1_dummy;

	d2 <= d2_dummy;

end architecture Struct;
