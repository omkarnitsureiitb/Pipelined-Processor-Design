library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstrMemory is

	port(mem_add: in std_logic_vector(15 downto 0);
		  Inst: out std_logic_vector(15 downto 0));
		  
end entity InstrMemory;

architecture Struct of InstrMemory is

	type instructions is array(65535 downto 0) of std_logic_vector(15 downto 0);

	signal memory: instructions:=("0001001010011000",
											others=>"0001001010011000");

	signal PC: std_logic_vector(15 downto 0);


	begin

		PC <= mem_add;
		Inst <= memory(to_integer(unsigned(PC)));

end architecture Struct;