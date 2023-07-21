library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity pipelineReg3 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  control_word:in std_logic_vector(50 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  pen2_0: in std_logic_vector(2 DOWNTO 0);
		  Rf_d1: in std_logic_vector(15 DOWNTO 0);
		  Rf_d2: in std_logic_vector(15 DOWNTO 0);
		  T1_out: in std_logic_vector(15 DOWNTO 0);
		  output3: out std_logic_vector(133 DOWNTO 0));
end entity pipelineReg3;

architecture arch_Reg of pipelineReg3 is

signal dummy: std_logic_vector(133 downto 0);

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
		  
            if en = '1' then
                dummy(133 downto 118) <= PC;
					 dummy(117 downto 102) <= IR;
					 dummy(101 downto 51) <= control_word;
					 dummy(50 downto 48) <= pen2_0;
					 dummy(47 downto 32) <= Rf_d1;
					 dummy(31 downto 16) <= Rf_d2;
					 dummy(15 downto 0) <= T1_out;
					 output3 <= dummy;
            end if;
				
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;