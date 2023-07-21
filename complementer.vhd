library ieee;
use ieee.std_logic_1164.all;

entity Complementer is

	port(rf_d2: in std_logic_vector(15 downto 0);
		  complement: out std_logic_vector(15 downto 0));
		  
end entity Complementer;

architecture Struct of Complementer is
	
	signal allone: std_logic_vector(15 downto 0):= "1111111111111111";
	signal output: std_logic_vector(15 downto 0);
	
	begin
	
	output <= rf_d2 xor allone;
	complement <= output;
		
end architecture Struct;