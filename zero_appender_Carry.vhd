library ieee;
use ieee.std_logic_1164.all;
library work;

entity zero_Appender_Carry is

port (C: in std_logic;
	   Y: out std_logic_vector(15 downto 0));
end entity zero_Appender_Carry;

architecture Struct of zero_Appender_Carry is

	signal out_temp: std_logic_vector(15 downto 0):= (others => '0');

	begin

	out_temp(0) <= C;
	Y <= out_temp;

end architecture Struct;
