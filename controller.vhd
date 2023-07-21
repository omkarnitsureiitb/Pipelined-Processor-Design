library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_logic is
	port(inst: in std_logic_vector(15 downto 0);
	reset: in std_logic;
	carry: in std_logic;
	zero: in std_logic;
-- bit_reg_cy: out std_logic;--50
-- bit_reg_z: out std_logic; --49
--	se_i: out std_logic_vector; --48
--	se_j: out std_logic; -- 47
--	mux1: out std_logic_vector(1 downto 0); --45,46
--	mux2: out std_logic_vector; --44
--	mux3: out std_logic_vector(2 downto 0); --43,42,41
--	mux4: out std_logic_vector(1 downto 0); --40,39
--	mux5: out std_logic_vector(2 downto 0); --38,37,36
--	mux6: out std_logic_vector(3 downto 0); --35,34,33,32
--	mux7: out std_logic_vector(1 downto 0); --31,30
--	mux8: out std_logic_vector(1 downto 0); --29,28
--	mux9: out std_logic_vector(1 downto 0); --27,26
--	mux10: out std_logic;                   --25
--	mux11: out std_logic_vector(1 downto 0);--24,23
--	mux12: out std_logic;                   --22
--	mux13: out std_logic_vector(3 downto 0);--21,20,19,18
--	mux14: out std_logic; --17
--	mux15: out std_logic;--16
--	mux16: out std_logic;--15
--	mux17: out std_logic;--14
--	rf_rd: out std_logic;--13
--	rf_wr: out std_logic;--12
--	pc_en: out std_logic;--11
--	t1_en: out std_logic;--10
--	pen_en: out std_logic;--9
--	ALU: out std_logic_vector(1 downto 0);--8,7
--	dm_rd: out std_logic;--6
--	dm_wr: out std_logic;--5
--	is_en: out std_logic_vector(4 downto 0);--4,3,2,1,0
	control_final: out std_logic_vector(50 downto 0));
end entity controller_logic;

architecture controller of controller_logic is
	
	begin
		
		controller_process: process(inst, reset, carry, zero)
			
		variable control: std_logic_vector(50 downto 0) := (others => '0');
			
		begin
				
			if(inst(15 downto 12) = "0001" and inst(2 downto 0) = "000") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(13) := '1';
				control(21) := '1';
				control(46 downto 45) := "01";
				control(12) := '1';
				control(22) := '1';
                                control(44) := '1';
				control(11) := '1';
				control(50 downto 49) := "11";
			
			elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "010") then
				if(carry = '1') then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(21) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(44) := '1';
					control(11) := '1';
					control(50 downto 49):= "11";
				else
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
				end if;
			
			elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "001") then
				if(zero='1') then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(21) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(44) := '1';
					control(11) := '1';
					control(50 downto 49):= "11";
				else 
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
				end if;
					
				elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "011") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
					control(13 downto 12) := "11";
					control(35 downto 32) := "0100";
					control(29 downto 28) := "10";
					control(46 downto 45) := "01";
					control(22) := '1';
					control(44) := '1';
					control(50 downto 49):= "11";
					
				elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "100") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(46 downto 45) := "01";
                       			control(44) := '1';
					control(12) := '1';
					control(11) := '1';
					control(35 downto 32) := "0011";
					control(50 downto 49):= "11";
				
				elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "110") then
					if(carry='1') then
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(13) := '1';
						control(22) := '1';
						control(44) := '1';
						control(46 downto 45) := "01";
						control(12) := '1';
						control(11) := '1';
						control(35 downto 32) := "0011";
						control(50 downto 49):= "11";
					else
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(11) := '1';
					end if;
						
				elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "101") then
					if(zero='1') then
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(13) := '1';
						control(22) := '1';
						control(44) := '1';
						control(46 downto 45) := "01";
						control(12) := '1';
						control(11) := '1';
						control(35 downto 32) := "0011";
						control(50 downto 49):= "11";
					else
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(11) := '1';
					end if;
						
				elsif(inst(15 downto 12) = "0001" and inst(2 downto 0) = "111") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
					control(13 downto 12) := "11";
					control(35 downto 32) := "0100";
					control(29 downto 28) := "11";
					control(46 downto 45) := "01";
					control(22) := '1';
					control(44) := '1';
					control(50 downto 49):= "11";
					
				elsif(inst(15 downto 12) = "0000") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
					control(13 downto 12) := "11";
					control(35 downto 32) := "0101";
					control(46 downto 45) := "10";
					control(44) := '1';
					control(48) := '1';
					control(50 downto 49):= "11";
				
				elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "000") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(44) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(11) := '1';
					control(8 downto 7) := "10";
					control(49) := '1';
					
				elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "010") then
					if(carry = '1') then
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(13) := '1';
						control(21) := '1';
						control(46 downto 45) := "01";
						control(12) := '1';
						control(44) := '1';
						control(11) := '1';
						control(8 downto 7) := "10";
						control(49) := '1';
					else
						control := (others => '0');
						control(4 downto 0) := "11111";
						control(11) := '1';
					end if;
			
			elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "001") then
				if(zero='1') then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(44) := '1';
					control(11) := '1';
					control(8 downto 7) := "10";
					control(49) := '1';
				else 
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
				end if;

			elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "100") then
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(44) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(11) := '1';
					control(35 downto 32) := "0011";
					control(8 downto 7) := "10";
					control(49) := '1';
					
			elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "110") then
				if(carry='1') then	
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(44) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(22) := '1';
					control(11) := '1';
					control(35 downto 32) := "0011";
					control(8 downto 7) := "10";
					control(49) := '1';
				else
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';
				end if;
				
			elsif(inst(15 downto 12) = "0010" and inst(2 downto 0) = "101") then
				if(zero='1') then	
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(13) := '1';
					control(22) := '1';
					control(46 downto 45) := "01";
					control(12) := '1';
					control(44) := '1';
					control(11) := '1';
					control(35 downto 32) := "0011";
					control(8 downto 7) := "10";
					control(49) := '1';
				else
					control := (others => '0');
					control(4 downto 0) := "11111";
					control(11) := '1';	
				end if;
				
			elsif(inst(15 downto 12) = "0011") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
			   control(12) := '1';
				control(47) := '1';
				
			elsif(inst(15 downto 12) = "0100") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(48) := '1';
				control(43 downto 41) := "011";
				control(6) := '1';
				control(44) := '1';
				control(12) := '1';
				control(13) := '1';
				
			elsif(inst(15 downto 12) = "0101") then
				control := (others => '0');
				control(4 downto 0) := "11110";
				control(11) := '1';
				control(43 downto 41) := "011";
				control(47) := '1';
				control(5) := '1';
				control(13) := '1';
				control(24 downto 23) := "01";

			elsif(inst(15 downto 12) = "0110") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0011";  --assumed PC_in in 4th port
				control(13 downto 12) := "11";
				control(6) := '1';
				control(10 downto 9) := "11";
				control(16) := '1'; --to be changed in hazard 
				control(17) := '1'; 
				control(15) := '1'; --to be changed in hazard
				control(14) := '1';
				control(24 downto 23) := "01";
				control(46 downto 45) := "11";
				
			
			elsif(inst(15 downto 12) = "0111") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0011";  --assumed PC_in in 4th port
				control(13) := '1';
				control(5) := '1';
				control(10 downto 9) := "11";
				control(16) := '1'; --to be changed in hazard
				control(17) := '1'; 
				control(15) := '1'; --to be changed in hazard
				control(14) := '1';
				control(24 downto 23) := "01";
				
			elsif(inst(15 downto 12) = "1000") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0010";
				control(48) := '1';
				control(13) := '1';
				control(31 downto 30) := "10";
				control(8 downto 7) := "11";
				control(40 downto 39) := "01";
				control(43 downto 41) := "001";
				control(27 downto 26) := "00";
				
			elsif(inst(15 downto 12) = "1001") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0010";
				control(48) := '1';
				control(13) := '1';
				control(31 downto 30) := "10";
				control(8 downto 7) := "11";
				control(40 downto 39) := "01";
				control(43 downto 41) := "001";
				control(27 downto 26) := "01";

				
			elsif(inst(15 downto 12) = "1010") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0010";
				control(48) := '1';
				control(13) := '1';
				control(31 downto 30) := "10";
				control(8 downto 7) := "11";
				control(40 downto 39) := "01";
				control(43 downto 41) := "001";
				control(27 downto 26) := "10";
				
			elsif(inst(15 downto 12) = "1100") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0101";
				control(47) := '1';
				control(31 downto 30) := "01";
				control(29 downto 28) := "01";
				control(40 downto 39) := "01";
				control(43 downto 41) := "001";
				control(38 downto 36) := "101";
				control(35 downto 32) := "0110";
				control(22) := '1';
				control(44) := '1';
				control(12) := '1';
				
			elsif(inst(15 downto 12) = "1101") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(21 downto 18) := "0100";
				control(47) := '1';
				control(31 downto 30) := "01";
				control(29 downto 28) := "01";
				control(40 downto 39) := "01";
				control(43 downto 41) := "001";
				control(38 downto 36) := "101";
				control(35 downto 32) := "0110";
				control(22) := '1';
				control(44) := '1';
				control(12) := '1';
				
			elsif(inst(15 downto 12) = "1111") then
				control := (others => '0');
				control(4 downto 0) := "11111";
				control(11) := '1';
				control(47) := '1';
				control(40 downto 39) := "00";
				control(43 downto 41) := "010";
				control(21 downto 18) := "0101";
				
			else
				if(reset = '1') then
					control := (others => '0');
				else
					control := (others => '0');
					control(4 downto 0) := "11110";
					control(11) := '1';
				end if;
			end if;
		
				
			control_final <= control;
				
			end process controller_process;

end controller;