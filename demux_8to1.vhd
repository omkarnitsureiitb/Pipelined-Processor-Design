library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux_8to1 is
	port(data: in std_logic_vector(15 downto 0);
	control_bits: in std_logic_vector(2 downto 0);
	D0: out std_logic_vector(15 downto 0);
	D1: out std_logic_vector(15 downto 0);
	D2: out std_logic_vector(15 downto 0);
	D3: out std_logic_vector(15 downto 0);
	D4: out std_logic_vector(15 downto 0);
	D5: out std_logic_vector(15 downto 0);
	D6: out std_logic_vector(15 downto 0);
	D7: out std_logic_vector(15 downto 0)
	);
end entity demux_8to1;

architecture demuxed of demux_8to1 is

	begin
		
		demux_process: process(control_bits, data)
		begin
		D0 <= data;
		D1 <= data;
		D2 <= data;
		D3 <= data;
		D4 <= data;
		D5 <= data;
		D6 <= data;
		D7 <= data;
		end process demux_process;
end architecture demuxed;