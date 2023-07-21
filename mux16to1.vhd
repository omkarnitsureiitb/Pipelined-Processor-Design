library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity mux16to1 is

	port(S: in std_logic_vector(3 downto 0);
	     D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15: in std_logic_vector(15 downto 0);
	     Y: out std_logic_vector(15 downto 0));
end entity mux16to1;

architecture Struct of mux16to1 is

begin

MUX_PROCESS: process(S, D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0)

begin

	if(S = "0000") then
		Y <= D0;
	elsif(S = "0001") then
		Y <= D1;
	elsif(S = "0010") then
		Y <= D2;
	elsif(S = "0011") then
		Y <= D3;
	elsif(S = "0100") then
		Y <= D4;
	elsif(S = "0101") then
		Y <= D5;
	elsif(S = "0110") then
		Y <= D6;
	elsif(S = "0111") then
		Y <= D7;
	elsif(S = "1000") then
		Y <= D8;
	elsif(S = "1001") then
		Y <= D9;
	elsif(S = "1010") then
		Y <= D10;
	elsif(S = "1011") then
		Y <= D11;
	elsif(S = "1100") then
		Y <= D12;
	elsif(S = "1101") then
		Y <= D13;
	elsif(S = "1110") then
		Y <= D14;
	else
		Y <= D15;
	end if;

end process MUX_PROCESS;

end architecture Struct;

