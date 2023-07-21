--Stage2
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity stage2 is
	port(pen_en: in std_logic;
	inst: in std_logic_vector(15 downto 0);
	carry, zero, reset: in std_logic;
	reg_load_curr: in std_logic_vector(7 downto 0);
	control_signal: out std_logic_vector(50 downto 0);
	reg_addr: out std_logic_vector(2 downto 0);
	reg_load_next: out std_logic_vector(7 downto 0);
	end_inst: out std_logic);
end entity stage2;	

architecture control_stage of stage2 is

	signal control_wait: std_logic_vector(50 downto 0);
	signal IR_8: std_logic_vector(7 downto 0);
	signal PEN_in: std_logic_vector(7 downto 0);
	signal PEN_next_wait: std_logic_vector(7 downto 0);
	signal reg_add: std_logic_vector(2 downto 0);
	signal end_LMSM: std_logic;
	
component PriorityEncoder is 
	port(reg_load_curr: in std_logic_vector(7 downto 0);
		  pen_en: in std_logic;
		  end_inst: out std_logic;
		  dummy_control: in std_logic_vector(50 downto 0);
		  control_signal: out std_logic_vector(50 downto 0);
		  reg_load_next: out std_logic_vector(7 downto 0);
		  reg_addr: out std_logic_vector(2 downto 0));
end component PriorityEncoder;
	
	component controller_logic is
		port(inst: in std_logic_vector(15 downto 0);
		reset: in std_logic;
		carry: in std_logic;
		zero: in std_logic;
		control_final: out std_logic_vector(50 downto 0));
	end component controller_logic;
	
	component mux_2to1_8 is
		port(A,B: in std_logic_vector(7 downto 0);
           control:in std_logic;
	        Y: out std_logic_vector(7 downto 0));
	end component mux_2to1_8;
		
	begin

		IR_8 <= inst(7 downto 0);
		
		Controller : controller_logic
			port map(inst, reset, carry, zero, control_wait);
			
		MUX: mux_2to1_8
			port map(reg_load_curr, IR_8, control_wait(16), PEN_in);
			
		PEN: PriorityEncoder
			port map(PEN_in, pen_en, end_LMSM, control_wait, control_signal, PEN_next_wait, reg_add);
			
		reg_addr <= reg_add;
		reg_load_next <= PEN_next_wait;
		end_inst <= end_LMSM;

end control_stage;
