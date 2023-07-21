library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity MUX_8To1 is

	port(Add: in std_logic_vector(2 downto 0);
		  D0, D1, D2, D3, D4, D5, D6, D7: in std_logic_vector(15 downto 0);
		  OUTPUT: out std_logic_vector(15 downto 0));
		  
end entity MUX_8To1;

architecture Struct of MUX_8To1 is

begin

MUX_PROCESS: process(Add, D7, D6, D5, D4, D3, D2, D1, D0)

begin

	if(Add = "000") then
		OUTPUT <= D0;
	elsif(Add = "001") then
		OUTPUT <= D1;
	elsif(Add = "010") then
		OUTPUT <= D2;
	elsif(Add = "011") then
		OUTPUT <= D3;
	elsif(Add = "100") then
		OUTPUT <= D4;
	elsif(Add = "101") then
		OUTPUT <= D5;
	elsif(Add = "110") then
		OUTPUT <= D6;
	else
		OUTPUT <= D7;
	end if;

end process MUX_PROCESS;

end architecture Struct;