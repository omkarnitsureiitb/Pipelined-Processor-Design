library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is 
	port(ra1: in std_logic_vector(2 downto 0);
	     ra2: in std_logic_vector(2 downto 0);
		  wa3: in std_logic_vector(2 downto 0);
		  wd3: in std_logic_vector(15 downto 0);
		  PC_in: in std_logic_vector(15 downto 0);
		  wr: in std_logic;
		  rd: in std_logic;
		  clk:in std_logic;
		  reset: in std_logic;
		  rd1: out std_logic_vector(15 downto 0);
		  rd2: out std_logic_vector(15 downto 0));
end entity reg_file;

architecture Struct of reg_file is 

type registerFile is array(0 to 7) of std_logic_vector(15 downto 0);

signal register_file : registerFile;

begin

write_process: process(clk, reset)
	
	begin
	
		if(reset = '1') then
			register_file(0) <= "0000000000000000";
			register_file(1) <= "0000000000000001";
			register_file(2) <= "0000000000000010";
			register_file(3) <= "0000000000000000";
			register_file(4) <= "0000000000000100";
			register_file(5) <= "0000000000000101";
			register_file(6) <= "0000000000000110";
			register_file(7) <= "0000000000000111";
			
		elsif(rising_edge(clk)) then
			
			if(wr='1') then
				
				register_file(to_integer(unsigned(wa3))) <= wd3;
				
			end if;
			
		end if;
	
end process write_process;

read_proc1: process(ra1, ra2, register_file)

begin

	if(ra1 = "000") then
		rd1 <= register_file(0);
	elsif(ra1 = "001") then
		rd1 <= register_file(1);
	elsif(ra1 = "010") then
		rd1 <= register_file(2);
	elsif(ra1 = "011") then
		rd1 <= register_file(3);
	elsif(ra1 = "100") then
		rd1 <= register_file(4);
	elsif(ra1 = "101") then
		rd1 <= register_file(5);
	elsif(ra1 = "110") then
		rd1 <= register_file(6);
	else
		rd1 <= register_file(7);
	end if;
	
end process read_proc1;

read_proc2: process(ra1, ra2, register_file)

begin

	if(ra2 = "000") then
		rd2 <= register_file(0);
	elsif(ra2 = "001") then
		rd2 <= register_file(1);
	elsif(ra2 = "010") then
		rd2 <= register_file(2);
	elsif(ra2 = "011") then
		rd2 <= register_file(3);
	elsif(ra2 = "100") then
		rd2 <= register_file(4);
	elsif(ra2 = "101") then
		rd2 <= register_file(5);
	elsif(ra2 = "110") then
		rd2 <= register_file(6);
	else
		rd2 <= register_file(7);
	end if;
	
end process read_proc2;


			
end architecture Struct;