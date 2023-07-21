--Stage 5
library ieee;
use ieee.std_logic_1164.all;

entity stage5 is
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
end entity stage5;

architecture Struct of stage5 is

component mux2to1 is
   port(S0: in std_logic;
		  D0, D1: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end component mux2to1;

component mux4to1 is
   port(S1,S0: in std_logic;
		  D0,D1,D2,D3: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end component mux4to1;

component DataMemory is 
	port(data_in: in std_logic_vector(15 downto 0);
		  mem_add: in std_logic_vector(15 downto 0);
		  rd: in std_logic;
		  wr: in std_logic;
		  clk: in std_logic;
		  data_out: out std_logic_vector(15 downto 0));
end component DataMemory;

	signal address, data_write, dummy_DM: std_logic_vector(15 downto 0);

	begin

	mux1: mux2to1 port map(S0 => mux17_control, D0 => ALU2_out, D1 => T1_out, Y => address);		--mux17
	mux2: mux4to1 port map(S0 => mux11_control(0), S1 => mux11_control(1), D0 => Rf_d1, D1 =>Rf_d2, D2 => DM_data_hazard, D3 => DM_data_hazard, Y => data_write);

	datamem: DataMemory port map(data_in => data_write, mem_add => address, rd => rd, wr => wr, clk => clk, data_out => DM_data_out);

end architecture Struct;

