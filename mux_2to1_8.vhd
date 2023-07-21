library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity mux_2to1_8 is

		port(A,B: in std_logic_vector(7 downto 0);
           control:in std_logic;
	        Y: out std_logic_vector(7 downto 0));
			  
end entity mux_2to1_8;
  
architecture arch_mux2to1 of mux_2to1_8 is
	
begin

	mux_proc : process (A, B, control) 
	
	begin
	
		if control = '0' then
			Y <= A;
		else
			Y <= B;
		end if;
	end process mux_proc;
			
end architecture arch_mux2to1;