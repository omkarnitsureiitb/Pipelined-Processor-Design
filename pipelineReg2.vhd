library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity pipelineReg2 is 
	port(output1: in std_logic_vector(31 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  control_word:in std_logic_vector(50 DOWNTO 0);
		  pen7_0:in std_logic_vector(7 DOWNTO 0);
		  pen2_0: std_logic_vector(2 DOWNTO 0);
	     endLMSM: in std_logic;
		  output2: out std_logic_vector(94 DOWNTO 0));
end entity pipelineReg2;

architecture arch_Reg of pipelineReg2 is

signal dummy: std_logic_vector(94 downto 0);

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
		  
            if en = '1' then
		dummy(94) <= endLMSM;
                			 dummy(93 downto 62) <= output1;
					 dummy(61 downto 54) <= pen7_0;
					 dummy(53 downto 51) <= pen2_0;
					 dummy(50 downto 0) <= control_word;
					 output2 <= dummy;
            end if;
				
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;
