library ieee;
use ieee.std_logic_1164.all;
library work;

entity XOR_16  is

  port (A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end entity XOR_16; 

architecture Struct of XOR_16 is
	
	begin
		Y<= A xor B;
	
end architecture Struct;