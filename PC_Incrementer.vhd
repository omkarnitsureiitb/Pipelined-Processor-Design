library ieee;
use ieee.std_logic_1164.all;

entity PC_Incrementer is
	port(PC_curr: in std_logic_vector(15 downto 0);
		  PC_next: out std_logic_vector(15 downto 0));
end entity PC_Incrementer;

architecture Struct of PC_Incrementer is

	component ADD_4BIT is
		port(A, B: in std_logic_vector(3 downto 0); Cin : in std_logic;
			  Y: out std_logic_vector(3 downto 0); C_out: out std_logic);
	end component ADD_4BIT;
	
	signal C: std_logic_vector(3 downto 0);
	signal C_out: std_logic;
	
	begin
	
		Adder1: ADD_4BIT
			port map(PC_curr(3 downto 0), "0001", '0', PC_next(3 downto 0), C(0));
		Adder2: ADD_4BIT
			port map(PC_curr(7 downto 4), "0000", C(0), PC_next(7 downto 4), C(1));
		Adder3: ADD_4BIT
			port map(PC_curr(11 downto 8), "0000", C(1), PC_next(11 downto 8), C(2));
		Adder4: ADD_4BIT
			port map(PC_curr(15 downto 12), "0000", C(2), PC_next(15 downto 12), C_out);
		
end architecture Struct;