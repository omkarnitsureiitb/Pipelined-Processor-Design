library ieee;
use ieee.std_logic_1164.all;

entity hazard_unit is
	port(ir1: in std_logic_vector(15 downto 0);
		  ir2: in std_logic_vector(15 downto 0);
		  ir3: in std_logic_vector(15 downto 0);
		  control_word1 : in std_logic_vector(50 downto 0);
		  modified_control_word : out std_logic_vector(50 downto 0));	  
		  
end entity hazard_unit;

architecture Behavourial of hazard_unit is

 begin
 
      hazard_process: process(ir1,ir2,ir3, control_word1)
		
		variable control_word :  std_logic_vector(50 DOWNTO 0) := (others => '0');
		
		begin
		
		control_word := control_word1;
		
---add/n
				if ir2(15 downto 12) = "0001" and (ir3(15 downto 12) = "0001" or ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010") then
						if ir2(5 downto 3) = ir3(11 downto 9) then
		       		control_word(38 downto 36) := "100";
						
						elsif ir2(5 downto 3) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0010";
						end if;
		
	         elsif ir2(15 downto 12) = "0001" and ir3(15 downto 12) = "0000" then
						if ir2(5 downto 3) = ir3(11 downto 9) then
						control_word(38 downto 36) := "100";	
						end if;
				elsif ir2(15 downto 12) = "0001" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir2(5 downto 3) = ir3(8 downto 6) then
						control_word(43 downto 41) := "000"	;							
						end if;
				elsif ir2(15 downto 12) = "0001" and ir3(15 downto 12) = "1111" then
						if ir2(5 downto 3) = ir3(11 downto 9) then
						control_word(43 downto 41) := "000"	;							
						end if;
				elsif ir2(15 downto 12) = "0001" and ir3(15 downto 12) = "1101" then
						if ir2(5 downto 3) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0111";
						end if;	
				elsif ir2(15 downto 12) = "0000" and ir3(15 downto 12) = "0000" then
						if ir2(8 downto 6) = ir3(8 downto 6) then
						control_word(38 downto 36) := "100";
						end if;
				elsif ir2(15 downto 12) = "0000" and (ir3(15 downto 12) = "0001" or ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010") then
						if ir2(8 downto 6) = ir3(11 downto 9) then
						control_word(38 downto 36) := "100";
						
						elsif ir2(8 downto 6) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0010";
						end if;
				elsif ir2(15 downto 12) = "0000" and ir3(15 downto 12) = "1101" then
				      if ir2(8 downto 6) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0111";
						end if;
				elsif ir2(15 downto 12) = "0000" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						 if ir2(8 downto 6) = ir3(8 downto 6) then
						 control_word(43 downto 41) := "111";
						 end if;
				elsif ir2(15 downto 12) = "0000" and ir3(15 downto 12) = "1111" then
						if ir2(8 downto 6) = ir3(8 downto 6) then
						control_word(43 downto 41) := "111"	;							
						end if;
						
	-----LLI			
				elsif ir2(15 downto 12) = "0011" and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "111";
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0111";
						end if;
				elsif ir2(15 downto 12) = "0011" and ir3(15 downto 12) = "0000" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "111";
						end if;
				elsif ir2(15 downto 12) = "0011" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir2(11 downto 9) = ir3(8 downto 6) then
					    control_word(43 downto 41) := "110";
						 end if;
				elsif ir2(15 downto 12) = "0011" and ir3(15 downto 12) = "1101" then
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0110";
						end if;
				elsif ir2(15 downto 12) = "0011" and ir3(15 downto 12) = "1111" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						 control_word(43 downto 41) := "110";
						 end if;
						
	-----Jal
				elsif (ir2(15 downto 12) = "1100" or ir2(15 downto 12) = "1101") and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "100";
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0010";
						end if;
				elsif (ir2(15 downto 12) = "1100" or ir2(15 downto 12) = "1101") and ir3(15 downto 12) = "0000" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "100";
						end if;
				elsif (ir2(15 downto 12) = "1100" or ir2(15 downto 12) = "1101") and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(43 downto 41) := "111";
						end if;
				elsif (ir2(15 downto 12) = "1100" or ir2(15 downto 12) = "1101") and ir3(15 downto 12) = "1101" then
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0111";
						end if;
				elsif (ir2(15 downto 12) = "1100" or ir2(15 downto 12) = "1101") and ir3(15 downto 12) = "1111" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(43 downto 41) := "111";
	               end if;
						
 -------lw
				elsif ir2(15 downto 12) = "0100" and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "001";
			       			control_word(2) := '0';
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "1111";
						control_word(2) := '0';
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0000" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "001";
						control_word(2) := '0';
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0100" then
						if ir1(11 downto 9) = ir2(8 downto 6) then
						control_word(43 downto 41) := "000";
						control_word(2) := '0';
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0101" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(24 downto 23) := "11";
						control_word(2) := '0';
						end if;
						if (ir2(11 downto 9) = ir3(8 downto 6) and ir1(11 downto 9) = ir3(11 downto 9))  then
						control_word(24 downto 23) := "11";
						control_word(43 downto 41) := "000";
						control_word(2) := '0';
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(43 downto 41) := "000";
						control_word(2) := '0';
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "1101" then
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "1101";
						control_word(2) := '0';
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "1111" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(43 downto 41) := "000";
						control_word(2) := '0';
						end if;
				
				
------Second Dependancies

---add/n
				elsif ir1(15 downto 12) = "0001" and (ir3(15 downto 12) = "0001" or ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010") then
						if ir1(5 downto 3) = ir3(11 downto 9) then
		       		control_word(38 downto 36) := "010";
						end if;
						if ir1(5 downto 3) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0001";
						end if;
				elsif ir1(15 downto 12) = "0001" and ir3(15 downto 12) = "0000" then
						if ir1(5 downto 3) = ir3(11 downto 9) then
						control_word(38 downto 36) := "010";
						end if;
				elsif ir1(15 downto 12) = "0001" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir1(5 downto 3) = ir3(8 downto 6) then
						control_word(43 downto 41) := "100";								
						end if;
				elsif ir1(15 downto 12) = "0001" and ir3(15 downto 12) = "1111" then
						if ir1(5 downto 3) = ir3(11 downto 9) then
						control_word(43 downto 41) := "100"	;							
						end if;
				elsif ir1(15 downto 12) = "0001" and ir3(15 downto 12) = "1101" then
						if ir1(5 downto 3) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0001";
						end if;
						
--adi						
				elsif ir1(15 downto 12) = "0000" and ir3(15 downto 12) = "0000" then
						if ir1(8 downto 6) = ir3(8 downto 6) then
						control_word(38 downto 36) := "010";
						end if;
				elsif ir1(15 downto 12) = "0000" and (ir3(15 downto 12) = "0001" or ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010") then
						if ir1(8 downto 6) = ir3(11 downto 9) then
						control_word(38 downto 36) := "010";
						end if;
						if ir1(8 downto 6) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0001";
						end if;
				elsif ir1(15 downto 12) = "0000" and ir3(15 downto 12) = "1101" then
				      if ir1(8 downto 6) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0001";
						end if;
				elsif ir1(15 downto 12) = "0000" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						 if ir1(8 downto 6) = ir3(8 downto 6) then
						 control_word(43 downto 41) := "100";
						 end if;
				elsif ir1(15 downto 12) = "0000" and ir3(15 downto 12) = "1111" then
						if ir1(8 downto 6) = ir3(8 downto 6) then
						control_word(43 downto 41) := "100"	;
						end if;
						
				
	-----LLI			
				elsif ir1(15 downto 12) = "0011" and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "011";
						end if;
						if ir1(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "1111";
						end if;
				elsif ir1(15 downto 12) = "0011" and ir3(15 downto 12) = "0000" then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "011";
						end if;
				elsif ir1(15 downto 12) = "0011" and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir1(11 downto 9) = ir3(8 downto 6) then
					    control_word(43 downto 41) := "101";
						 end if;
				elsif ir1(15 downto 12) = "0011" and ir3(15 downto 12) = "1101" then
						if ir1(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "1111";
						end if;
				elsif ir1(15 downto 12) = "0011" and ir3(15 downto 12) = "1111" then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						 control_word(43 downto 41) := "101";
						 end if;
						 
	-----Jal
				elsif (ir1(15 downto 12) = "1100" or ir1(15 downto 12) = "1101") and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "010";
						end if;
						if ir1(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "0001";
						end if;
				elsif (ir1(15 downto 12) = "1100" or ir1(15 downto 12) = "1101") and ir3(15 downto 12) = "0000" then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "010";
						end if;
				elsif (ir1(15 downto 12) = "1100" or ir1(15 downto 12) = "1101") and (ir3(15 downto 12) = "0100" or ir3(15 downto 12) = "0101") then
						if ir1(11 downto 9) = ir3(8 downto 6) then
						control_word(43 downto 41) := "100";			
						end if;
				elsif (ir1(15 downto 12) = "1100" or ir1(15 downto 12) = "1101") and ir3(15 downto 12) = "1101" then
						if ir1(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "0001";
						end if;
				elsif (ir1(15 downto 12) = "1100" or ir1(15 downto 12) = "1101") and ir3(15 downto 12) = "1111" then
						if ir1(11 downto 9) = ir3(11 downto 9) then
						control_word(43 downto 41) := "100";	
						end if;
						
	
 -------lw
				elsif ir2(15 downto 12) = "0100" and (ir3(15 downto 12) = "0001" or  ir3(15 downto 12) = "1000" or ir3(15 downto 12) = "1001" or ir3(15 downto 12) = "1010")  then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "001";
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(35 downto 32) := "1111";----
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0000" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(38 downto 36) := "001";
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0100" then
						if ir1(11 downto 9) = ir2(8 downto 6) then
						control_word(43 downto 41) := "000";
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "0101" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(24 downto 23) := "11";
						end if;
						if (ir2(11 downto 9) = ir3(8 downto 6) and ir1(11 downto 9) = ir3(11 downto 9))  then
						control_word(24 downto 23) := "11";
						control_word(43 downto 41) := "000";
						end if;
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(43 downto 41) := "000";
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "1101" then
						if ir2(11 downto 9) = ir3(8 downto 6) then
						control_word(21 downto 18) := "1101";
						end if;
				elsif ir2(15 downto 12) = "0100" and ir3(15 downto 12) = "1111" then
						if ir2(11 downto 9) = ir3(11 downto 9) then
						control_word(43 downto 41) := "000";
					   end if;
            else   control_word :=  control_word1;
				      
	
		end if;		
		
		modified_control_word <=  control_word;
		
		end process hazard_process;
		
		end Behavourial;