library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity pipelineReg5 is 
	port(clk: in std_logic;
		  en: in std_logic;
		  output4: in std_logic_vector(198 DOWNTO 0);
		  dm_data: in std_logic_vector(15 DOWNTO 0);
		  output5: out std_logic_vector(214 DOWNTO 0));
end entity pipelineReg5;

architecture arch_Reg of pipelineReg5 is

signal dummy: std_logic_vector(214 downto 0);

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
		  
            if en = '1' then
                dummy(214 downto 16) <= output4;
					 dummy(15 downto 0) <= dm_data;
					 output5 <= dummy;
            end if;
				
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;