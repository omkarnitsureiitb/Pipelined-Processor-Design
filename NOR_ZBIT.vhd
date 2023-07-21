library ieee;
use ieee.std_logic_1164.all;
library work;


entity NOR_ZBIT is

port (A: in std_logic_vector(15 downto 0);
	  Y: out std_logic);
end entity NOR_ZBIT;
	
architecture Struct of NOR_ZBIT is
	
	begin
		
	Y<= not(A(15) or A(14) or A(13) or A(12) or A(11) or A(10) or A(9) or A(8) or A(7) or A(6) or A(5) or A(4) or A(3) or A(2) or A(1) or A(0));
	
end architecture Struct;