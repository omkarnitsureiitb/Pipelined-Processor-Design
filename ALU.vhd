library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
		  C1: in std_logic; C0: in std_logic;  Cin: in std_logic;  Zin: in std_logic;
		  ALU_C: out std_logic_vector(15 downto 0);
		  C: out std_logic; Z: out std_logic);
end entity ALU;

architecture Struct of ALU is

component ADD is
	port(A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0);
		  C_add: out std_logic);
end component ADD;

component NAND_16 is
	port(A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0));
end component NAND_16;

component XOR_16 is
  port(A, B: in std_logic_vector(15 downto 0);
		 Y: out std_logic_vector(15 downto 0));
end component XOR_16;

component NOR_ZBIT is
port (A: in std_logic_vector(15 downto 0);
	  Y: out std_logic);
end component NOR_ZBIT;

component SUBTRACT is
	port(A, B: in std_logic_vector(15 downto 0);
		  Y: out std_logic_vector(15 downto 0); B_sub: out std_logic);
end component SUBTRACT;

signal OUT1, OUT2, OUT3, OUT4, Dummy: std_logic_vector(15 downto 0);
signal C_add, C_sub: std_logic;

begin

	A1: ADD port map(A => ALU_A, B => ALU_B, Y => OUT1, C_add => C_add);
	
	NAND1: NAND_16 port map(A => ALU_A, B=> ALU_B, Y => OUT2);
	
	XOR1: XOR_16 port map(A => ALU_A, B => ALU_B, Y => OUT3);
	
	Sub1: SUBTRACT port map(A => ALU_A, B => ALU_B, Y => OUT4, B_sub => C_sub);
	
	ALU_Process: process(ALU_A, ALU_B, C1, C0, OUT1, OUT2, OUT3, OUT4, C_add, C_sub, Cin, Dummy)
	
	begin
	
		if(C1 = '0' and C0 = '0') then --Addition
			Dummy <= OUT1;
			C <= C_add;
		elsif(C1 = '0' and C0 = '1') then --XOR
			Dummy <= OUT3;
			C <= Cin;
		elsif(C1 = '1' and C0 = '0') then  --NAND
			Dummy <= OUT2;
			C <= Cin;
		else
			Dummy <= OUT4;		--Subtract
			C <= C_sub;
		end if;
	
	end process ALU_Process;
	
	N1: NOR_ZBIT port map(A => Dummy, Y => Z);
	ALU_C <= Dummy;
	
end architecture Struct;