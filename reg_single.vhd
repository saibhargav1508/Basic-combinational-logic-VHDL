library ieee;
use ieee.std_logic_1164.all;

entity reg_single is
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    input  : in  std_logic;
    output : out std_logic
	);
end reg_single;

architecture BHV of reg_single is
begin
  process(clk, rst)
  begin
    if (rst = '1') then
      output   <= '0';
    elsif (rising_edge(clk)) then
      if (en = '1') then
        output <= input;
      end if;
    end if;
  end process;
end BHV;
