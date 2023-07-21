library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity mux2to1_3bits is

   port(S0: in std_logic;
	D0,D1: in std_logic_vector(2 downto 0);
	Y: out std_logic_vector(2 downto 0));
	
end entity mux2to1_3bits;
  
architecture arch_mux2to1_3bits of mux2to1_3bits is
	
begin

	mux_proc : process (S0, D0, D1) 
	
	begin
		if S0 = '0' then
			Y <= D0;
		else
			Y <= D1;
		end if;
	end process mux_proc;
			
end architecture arch_mux2to1_3bits;
