library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

entity bitReg is 
	port(d: in std_logic;
		  en: in std_logic;
		  clk: in std_logic;
		  q: out std_logic);
end entity bitReg;

architecture arch_Reg of bitReg is

begin

    dff_proc: process(clk)
	 
    begin
	 
        if rising_edge(clk) then
            if en = '1' then
                q <= d;
            end if;
        end if;
		  
    end process dff_proc;
	 
end architecture arch_Reg;