library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity pipelineReg1 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  output1: out std_logic_vector(31 DOWNTO 0));
end entity pipelineReg1;

architecture arch_Reg of pipelineReg1 is

signal dummy: std_logic_vector(31 downto 0);

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
		  
            if en = '1' then
                dummy(31 downto 16) <= PC;
					 dummy(15 downto 0) <= IR;
					 output1 <= dummy;
            end if;
				
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;