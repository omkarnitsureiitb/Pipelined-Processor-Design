library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity FULL_ADDER1 is
	port(A, B, Cin : in std_logic; S, Cout: out std_logic);
end entity FULL_ADDER1;

architecture Struct of FULL_ADDER1 is

	signal S1, S2, S3 :std_logic;
	
	begin
		X1 : XOR_2
		port map(A, B, S1);
		X2 : XOR_2
		port map(S1, Cin, S);
		A1 : AND_2
		port map(Cin, S1, S2);
		A2 : AND_2
		port map(A, B, S3);
		O1 : OR_2
		port map(S2, S3, Cout);
		
end architecture Struct;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity ADD_4BIT is
	port(A, B: in std_logic_vector(3 downto 0); Cin : in std_logic;
		  Y: out std_logic_vector(3 downto 0); C_out: out std_logic);
end entity ADD_4BIT;

architecture Struct of ADD_4BIT is
	
	component FULL_ADDER1 is
		port(A, B, Cin : in std_logic; S, Cout: out std_logic);
	end component FULL_ADDER1;

	signal c1, c2, c3, a4, a5, a6, a7: std_logic;
	
	begin
	
		FA1 : FULL_ADDER1
		port map(A(0), B(0), Cin, Y(0), a5);
		FA2 : FULL_ADDER1
		port map(A(1), B(1), a5, Y(1), a6);
		FA3 : FULL_ADDER1
		port map(A(2), B(2), a6, Y(2), a7);
		FA4 : FULL_ADDER1
		port map(A(3), B(3), a7, Y(3), C_out);
			
end architecture Struct;