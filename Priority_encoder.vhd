library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity PriorityEncoder is 
	port(reg_load_curr: in std_logic_vector(7 downto 0);
		  pen_en: in std_logic;
		  end_inst: out std_logic;
		  dummy_control: in std_logic_vector(50 downto 0);
		  control_signal: out std_logic_vector(50 downto 0);
		  reg_load_next: out std_logic_vector(7 downto 0);
		  reg_addr: out std_logic_vector(2 downto 0));
end entity PriorityEncoder;

architecture Struct of PriorityEncoder is 


begin

process_PriorityEncoder: process(reg_load_curr, pen_en, dummy_control)

	variable control_modifiable: std_logic_vector(50 downto 0);
	
	variable temp : std_logic_vector(7 downto 0);


begin
	control_modifiable := dummy_control;

	if(pen_en = '1') then
		if(reg_load_curr(0) = '1') then 
			reg_addr <= "111";
			temp := "11111110" and reg_load_curr;

		elsif(reg_load_curr(1) = '1') then 
			reg_addr <= "110";
			temp := "11111100" and reg_load_curr;

		elsif(reg_load_curr(2) = '1') then 
			reg_addr <= "101";
			temp := "11111000" and reg_load_curr;

		elsif(reg_load_curr(3) = '1') then 
			reg_addr <= "100";
			temp := "11110000" and reg_load_curr;

		elsif(reg_load_curr(4) = '1') then 
			reg_addr <= "011";
			temp := "11100000" and reg_load_curr;

		elsif(reg_load_curr(5) = '1') then 
			reg_addr <= "010";
			temp := "11000000" and reg_load_curr;

		elsif(reg_load_curr(6) = '1') then 
			reg_addr <= "001";
			temp := "10000000" and reg_load_curr;

		else
			reg_addr <= "000";
			temp := "00000000" and reg_load_curr;	

		end if;
		

		control_modifiable(10) := '1';

		control_modifiable(21 downto 18) := "0011";

		control_modifiable(4) := '0';

		control_modifiable(15) := '0';

		control_modifiable(16) := '0';

		control_modifiable(14) := '1';
		
		reg_load_next <= temp;

		if (temp = "00000000") then 
				end_inst <= '0';
		else 
				end_inst <= '1';
		end if;
		
	else
	
		control_modifiable(21 downto 18) := "0000";
		control_modifiable(4) := '1'; 
		control_modifiable(14) := '0';
		control_modifiable(10) := '0';
		control_modifiable(16) := '1';
		control_modifiable(15) := '1';
		reg_addr <= "000";
		reg_load_next <= "00000000";
		end_inst <= '0';
		
	end if;
	
	control_signal <= control_modifiable;

end process process_PriorityEncoder;

end architecture Struct;