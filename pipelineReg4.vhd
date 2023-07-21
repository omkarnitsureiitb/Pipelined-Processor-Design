library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity pipelineReg4 is 
	port(PC: in std_logic_vector(15 DOWNTO 0);
		  IR: in std_logic_vector(15 DOWNTO 0);
		  control_word_modif:in std_logic_vector(50 DOWNTO 0);
		  en: in std_logic;
		  clk: in std_logic;
		  Carry: in std_logic;
		  pen2_0: in std_logic_vector(2 DOWNTO 0);
		  Rf_d1: in std_logic_vector(15 DOWNTO 0);
		  Rf_d2: in std_logic_vector(15 DOWNTO 0);
		  T1_out: in std_logic_vector(15 DOWNTO 0);
		  ALU2_out: in std_logic_vector(15 DOWNTO 0);
		  ALU3_out: in std_logic_vector(15 DOWNTO 0);
		  zero_appended: in std_logic_vector(15 DOWNTO 0);
		  T1_adder_out: in std_logic_vector(15 DOWNTO 0);
		  output4: out std_logic_vector(198 DOWNTO 0));
end entity pipelineReg4;

architecture arch_Reg of pipelineReg4 is

signal dummy: std_logic_vector(198 downto 0);

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
		  
            if en = '1' then
                dummy(198 downto 183) <= PC;
					 dummy(182 downto 167) <= IR;
					 dummy(166 downto 116) <= control_word_modif;
					 dummy(115) <= Carry;
					 dummy(114 downto 112) <= pen2_0;
					 dummy(111 downto 96) <= Rf_d1;
					 dummy(95 downto 80) <= Rf_d2;
					 dummy(79 downto 64) <= T1_out;
					 dummy(63 downto 48) <= ALU2_out;
					 dummy(47 downto 32) <= ALU3_out;
					 dummy(31 downto 16) <= zero_appended;
					 dummy(15 downto 0) <= T1_adder_out;
					 output4 <= dummy;
            end if;
				
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;