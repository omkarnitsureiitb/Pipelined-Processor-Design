library ieee;
use ieee.std_logic_1164.all;
library std;
use std.standard.all;

  
entity mux4to1_for_BLE is
   port(S1,S0: in std_logic;
		D0,D1,D2,D3: in std_logic;
		Y: out std_logic);
end entity mux4to1_for_BLE;
  
architecture archmux of mux4to1_for_BLE is
begin
	mux_proc : process (S0, S1, D0, D1, D3, D2) 
	begin
		if S0 = '0' then
			if S1 = '0' then
				Y <= D0;
			else
				Y <= D2;
			end if;
		else
			if S1 = '0' then
				Y <= D1;
			else
				Y <= D3;
			end if;
		end if;
	end process mux_proc;
end architecture archmux;