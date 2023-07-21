library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(1 downto 0);
			output_vector: out std_logic_vector(1 downto 0));
end entity DUT;

architecture DutWrap of DUT is
component Processor is
   port(rst,CLK50MHZ : in std_logic;
		  Carry, Zero: out std_logic);
end component Processor;
begin

   add_instance: Processor
			port map(
					-- order of inputs B A
					rst => input_vector(1),
					CLK50MHZ => input_vector(0),
					Carry => output_vector(1),
					Zero => output_vector(0));
end architecture DutWrap;