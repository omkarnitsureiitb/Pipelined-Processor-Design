--Stage 6
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;


entity stage6 is
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
end entity stage6;

architecture Struct of stage6 is

component mux2to1 is
   port(S0: in std_logic;
		  D0, D1: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end component mux2to1;


	begin

	mux1: mux2to1 port map(S0 => mux_control, D0 => DM_out, D1 => ALU3_out, Y => wb_data);			--mux12

	IR11_9out <= IR11_9in;
	IR8_6out <= IR8_6in;
	IR5_3out <= IR5_3in;

	z_appendedout <= z_appendedin;

	penout2_0 <= penin2_0;

end architecture Struct;
