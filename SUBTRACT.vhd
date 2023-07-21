library ieee;
use ieee.std_logic_1164.all;

entity SUBTRACT is

	port(A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0); B_sub: out std_logic);
		  
end entity SUBTRACT;

architecture Struct of SUBTRACT is

	component ADD_4BIT is
		port(A, B: in std_logic_vector(3 downto 0); Cin : in std_logic;
			  Y: out std_logic_vector(3 downto 0); C_out: out std_logic);
	end component ADD_4BIT;
	
	signal C: std_logic_vector(3 downto 0);
	signal C_out: std_logic;
	
	begin
	
		Adder1: ADD_4BIT
			port map(A(3 downto 0), B(3 downto 0), '1', Y(3 downto 0), C(0));
		Adder2: ADD_4BIT
			port map(A(7 downto 4), B(7 downto 4), C(0), Y(7 downto 4), C(1));
		Adder3: ADD_4BIT
			port map(A(11 downto 8), B(11 downto 8), C(1), Y(11 downto 8), C(2));
		Adder4: ADD_4BIT
			port map(A(15 downto 12), B(15 downto 12), C(2), Y(15 downto 12), C_out);
			
		B_Sub <= C_out;
		
end architecture Struct;