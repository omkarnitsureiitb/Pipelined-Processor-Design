library ieee;
use ieee.std_logic_1164.all;
library work;

entity zero_Appender_Imm is

port (Imm: in std_logic_vector(8 downto 0);
	   Y: out std_logic_vector(15 downto 0));
end entity zero_Appender_Imm;

architecture Struct of zero_Appender_Imm is

	signal out_temp: std_logic_vector(15 downto 0):= (others => '0');

	begin

	out_temp(8 downto 0) <= Imm;
	Y <= out_temp;

end architecture Struct;