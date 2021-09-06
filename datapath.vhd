library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  generic (
    width     :     positive := 16);
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    valid_in  : in  std_logic;
    valid_out : out std_logic;
    in1       : in  std_logic_vector(width-1 downto 0);
    in2       : in  std_logic_vector(width-1 downto 0);
    in3       : in  std_logic_vector(width-1 downto 0);
    in4       : in  std_logic_vector(width-1 downto 0);
    output    : out std_logic_vector(width*2 downto 0));
end datapath;

-- TODO: Implement the structural description of the datapath shown in
-- datapath.pdf by instantiating your add_pipe and mult_pipe entities. You may
-- also use the provided reg entity, or you can create your own.

architecture STR of datapath is
	
	-- define signals required to complete circuit connections
	signal reg1_out : std_logic;
	signal mul1_out, mul2_out : std_logic_vector(width*2-1 downto 0);

begin
	-- datapath 1
	U_REG1 : entity work.reg_single
				port map(
					clk => clk,
					rst => rst,
					en => en,
					input => valid_in,
					output => reg1_out
				);
	
	U_REG2 : entity work.reg_single
				port map(
					clk => clk,
					rst => rst,
					en => en,
					input => reg1_out,
					output => valid_out
				);
	
	-- datapath 2
	U_MUL1 : entity work.mult_pipe
				generic map (
					width     => width)
				port map(
					clk => clk,
					rst => rst,
					en => en,
					in1 => in1,
					in2 => in2,
					output => mul1_out
				);
	
	U_MUL2 : entity work.mult_pipe
				generic map (
					width     => width)
				port map(
					clk => clk,
					rst => rst,
					en => en,
					in1 => in3,
					in2 => in4,
					output => mul2_out
				);
	
	U_ADD1 : entity work.add_pipe
                generic map (
					width     => 2*width)
				port map(
					clk => clk,
					rst => rst,
					en => en,
					in1 => mul1_out,
					in2 => mul2_out,
					output => output
				);
end STR;
